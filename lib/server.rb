#!/usr/bin/env ruby
#
# Created on Nov / 27 / 2012
#
# @author WilliamCabrera
require "rubygems"
require "json"
require "socket"
require 'timeout'

class Lib_Server
  
  def initialize
    @@instance_locked = false # no instance has it  
    @tests = []
    @testQueue = 0
    @clientSize = 0
    @clientObjects = {}
    @port = 0
  end
  
  attr_accessor :tests
  attr_accessor :testQueue
  attr_accessor :clientSize
  attr_accessor :clientObjects
  
  def testService(clients, tests, port)
    @port = port
    @tests = tests # => .shuffle
    @clientSize = tests.size
    createClientObjects(clients)
    #startServerSocket(port+1)
    while (@tests.size > 0)
      clients.each do |client|
        state = @clientObjects[client]
        if (state==:offline or state==:ready) and isPortAvailable(client, port) and (@tests.size > 0)   #isPortAvailable(client, port) or state==:offline
          startClientSocket(client, port, @tests.shift)
        end     
      end
    end
    
    return true
  end

  def waitingForReport
    _startTime = Time.now
    until (@testQueue == @clientSize) do 
      sleep 2   # lazy wait
      if ((Time.now - _startTime) > 7200)
        break
      end
    end    
    getReportFromReports()
    stopClientSocket()
  end
  
  private 
    
  def startClientSocket(client, port, test)
    @clientObjects[client] = :busy   
    print "\nRunning #{test} on #{client}"
    $stdout.flush
    Thread.new do 
      begin
        _conn = TCPSocket.new(client, port) 
        _conn.print "ruby run_test.rb #{test} #{$validArguments.join(' ').gsub(/--server/,'--local')}\r\n"   
        _conn.flush    
        _response = _conn.gets  # => gets.strip
        _conn.close
        @testQueue += 1
        @clientObjects[client] = :ready  
      rescue      
        puts "An error has ocurred while running #{test}"
        @tests << test
        @testQueue -= 1
        @clientObjects[client] = :aborted  
      end
    end
  end

  def stopClientSocket()      
    @clientObjects.each do |client, state|              
      $stdout.flush
      Thread.new do 
          _conn = TCPSocket.new(client, @port) 
          _conn.print "shutdown\r\n"   
          _conn.flush    
          _conn.close
      end
   end
  end
  
  def startServerSocket(port)
    serverFactory = TCPServer.open(port) 
    Thread.new do
      loop do
        Thread.start(serverFactory.accept) do |_conn| 
          _response = _conn.gets.strip
          puts _response
          setReportInfo(_response)
          #@testQueue += 1
          _conn.close              
        end
      end
    end
  end
  
  def createClientObjects clients
    clients.each do |client|
      @clientObjects[client] = :offline
    end
  end

  def getReportFromReports()
    @results = JSON.parse("{}")
    @results[:tests] = []
    _dir = Dir['./sockets/reports/*']
    # =>  get all tests reports
    _dir.each do |filename|
      if filename.include?("overall_report")
        getReportInfo(filename)
        FileUtils.rm_f(filename)  # =>  remove report
      end
    end   
    setReportInfo "#{JSON.unparse(@results)}"
  end
    
  def getReportInfo(filename)
    get_Lock()
      begin
        _filename = "#{filename}"
        _report = File.open(_filename,'r')
        _content = ""
        while (line = _report.gets)
          _content << line
        end
        _report.close
        
        _content.scan(/('\{("[a-z]+":"([0-9]|[a-zA-Z ])+",?)+\}')+/) { |m|
          _tmpJSON = JSON.parse("#{m[0]}".gsub(/'/,''))
          @results[:tests] << _tmpJSON
        }
      rescue
        puts :ErrorReadingReport
      end    
    put_Lock()   
  end
  
  def setReportInfo response
    begin
      _tests = JSON.parse(response)
        _tests["tests"].each do |_test|
          _count = { :passed => _test["passed"].to_i, :failed => _test["failed"].to_i }
          _title = ''
          _title << '<li class=test-title><div class=icon>&nbsp;</div><div class=test-step><h3>'
          _title << _test["name"]
          _title << '</h3>'+ (_test["online"]=="1" ? '<div class=user>&nbsp;</div>':'') +'</div><div class=test-result><p>&nbsp;</p></div></li>'       
          $report.addToReport(_title, _count)
        end      
    rescue
      puts :CouldNotParseJSON
    end  
  end
  
  def isPortAvailable(ip, port)
    begin
      Timeout::timeout(1) do
        begin
          s = TCPSocket.new(ip, port)
          s.print "testing port\r\n"
          s.flush
          #s.print "close\r\n"
          #s.flush
          s.close
          return true
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
          return false
        end
      end
    rescue Timeout::Error
    end
  
    return false
  end
  
  def get_Lock
    while(@@instance_locked)   
      # just wait   
    end
    @@instance_locked = true
  end
  
  def put_Lock
    @@instance_locked = false
  end   
end

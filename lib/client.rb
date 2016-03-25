#!/usr/bin/env ruby
#
# Created on Nov / 12 / 2012
#
# @author ManuelCerda
require "rubygems"
require 'socket'
require 'date'
require 'json'

class Lib_Client

  def initialize   
    #system("rm -r reports/*;")    
    system("sshfs -o idmap=user #{Configuration::USERNAME}@#{Configuration::HOST}:/var/www/html/continuous_delivery/acceptance_tests/sockets/reports ./sockets/reports/")
  end

  def startServerSocket(port)
    print "\nWaiting for Connection on port: #{port}\n\r"
    serverFactory = TCPServer.new(port) 
    loop do
       canBreak = false
       Thread.start(serverFactory.accept) do |_conn| 
        	  _execStr = _conn.gets.strip        
        	  if _execStr.include?("Tests_")
        	    system("git pull")
        	    system("#{_execStr}")
        	    _conn.print "getReportInfo()\r\n"  # => getReportInfo(),"\r\n"
        	    _conn.flush  
        	  elsif _execStr.include?('testing port')  
        	    #nothing
        	  else        	        
              if ([0,6].include?(Date.today.wday))
                canBreak = true
              end  
        	  end
        	 _conn.gets              
        end
        if canBreak
          break
        end
    end  
  end
  
  def sendReport port
    Thread.new do 
      _conn = TCPSocket.new(Configuration::HOST, port+1) 
      _conn.puts getReportInfo()
      _conn.flush
      _conn.close
    end     
  end
  
  def getReportInfo()    
    begin
      sleep 3 # wait report
      _report = File.open(Dir['reports/*'].last,'r')
      _content = ""
      while (line = _report.gets)
        _content << line
      end
      _report.close
      
      _results = JSON.parse("{}")
      _tests = []
      
      _content.scan(/('\{.*\}')+/) do |test|
        _tmpJSON = JSON.parse("#{test}".gsub(/'/,''))
        _tests << _tmpJSON
      end
      _results[:tests] = _tests
    rescue
      _results = "{}"
    end
    
    return "#{JSON.unparse(_results)}"
  end
end

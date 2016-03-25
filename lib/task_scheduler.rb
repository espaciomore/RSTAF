class Lib_TaskScheduler 
  
  attr_accessor :tests
  attr_accessor :threads
  attr_accessor :lock_
  
  def initialize()    
    @@tests = []
    @@threads = []    
    #@@execs = [] #just to generate symbolic link files
    @@lock_ = false # no instance has it
  end

  def add _tests,isThread=false     
    _tests.each do |test|      
      #@@execs << "touch #{test}"
      if isTest(test)  
        get_Lock
        addIt(test,isThread)
        put_Lock
      else          
        test.new.test
      end
    end
    
    return self
  end
    
  def schedule groupPriority=0
    count = 6
    main = Thread.new do
      Thread.current.priority = groupPriority
      @@threads.each do |test|   
        groupPriority -= 1   
        t = Thread.new do 
          Thread.current.priority = groupPriority
          Thread.current[:name] = "#{test}"
          test.new.test 
          Thread.stop  
        end   
        sleep count**2
        count += 2 
      end     
    end    
    main.join
    
    return self
  end
  
  def runTests(isServer=false)  
    if isServer
      _server = Lib_Server.new
      if _server.testService( ($target_browser==:ie ? Configuration::CLIENTS_IE : Configuration::CLIENTS), @@tests, Configuration::PORT )
        _server.waitingForReport
      end
    else     
      @@tests.each do |test_class|
        begin
          test_class.new.test
        rescue
          puts "\nError running #{test_class}"
        end  
      end   
      #system @@execs.join(';')    
    end
    return self
  end
  
  def getTests
    return @@tests
  end

  def getThreads
    return @@threads
  end    
  
  private
  
  def usingThreads?
    return ($thread)
  end  
  
  def isTest test
    return !("#{test}".include?"Suite")
  end
  
  def addIt test,isThread   
    if (!isThread or !usingThreads?)
      (@@tests << test)
    end
    if (isThread and usingThreads?)    
      (@@threads << test)
    end
    return nil
  end
  
  def get_Lock
    while(@@lock_)   
      # just wait   
    end
    @@lock_ = true
  end
  
  def put_Lock
    @@lock_ = false
  end  
  
end
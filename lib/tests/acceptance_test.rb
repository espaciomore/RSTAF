class Lib_Tests_AcceptanceTest
  
  LOGGEDIN = true
  LOGGEDOUT = false
  
  def initialize(tools=nil)
    if tools      
      @generalTools = tools
      @watir_helper = tools.watir_helper
      @wizardTools = tools.wizardTools
      @validator = tools.validator
      @browser = tools.browser
      @report = tools.report
    end
  end
  
  def test 
    if(testLoggedIn && Configuration::TEST_LOGGED_IN)  
      showConsoleInfo
      self::processTest Lib_Tests_AcceptanceTest::LOGGEDIN
    end
         
    if(testLoggedOut && !$login)
      showConsoleInfo
      self::processTest Lib_Tests_AcceptanceTest::LOGGEDOUT
    end          
    
    return true
  end
  
  def showConsoleInfo
    print "\nRunning #{self.class}" 
    #********************************************************
    if $thread      
      t = Thread.current    
      print " | #{t.priority}" 
    end
    #********************************************************  
  end
  
  def processTest withLogin
    if (self::beforeSetUp)
      self::setUp
      self::afterSetUp
      
      if withLogin
        @watir_helper.goto $target_server
        if(isProvider)
         login({:using => :provider_user, :on => login_context, :user => provider_user, :pwd => provider_pwd})
        else
         _using = testUser
         login({:using => _using, :on => login_context})
        end
      end    
      
      @watir_helper.goto testSite 
      if (self::caughtTest)
        self::beforeTearDown
        self::tearDown
      end
      self::afterTearDown
    end
    
    #********************************************************
    if $thread      
      t = Thread.current    
      print " | #{t.priority}" 
    end
    #********************************************************
  end  
  
  def beforeSetUp
    $isLoggedIn = false
    begin
      client = Selenium::WebDriver::Remote::Http::Default.new
      client.timeout = 360 # =>  seconds - default is 60
      @browser = Watir::Browser.new $target_browser, :http_client => client      
      @browser.window.resize_to(1280,900) # => @browser.send_keys :f11
      @report = Lib_Tools_TestReportsFactory.new()  
      @generalTools = Lib_Tools_GeneralSite.new(@browser, @report)
      @watir_helper = @generalTools.watir_helper
      @wizardTools = @generalTools.wizardTools
      @watir_helper.clearCookies     
      @validator = @generalTools.validator      
      _safeSetUp = true
    rescue
      _safeSetUp = false
      error = "\n\tCrashed! \nReason: " + $!.to_s
      if(Configuration::DEBUG)
        puts error
      end
    end
    return _safeSetUp
  end
  
  def testUser
    return :test_user  
  end
  
  def provider_user
    return Configuration::PROVIDER_USER
  end
  
  def provider_pwd
    return Configuration::PROVIDER_PASS
  end
  
  def login_context
    :abstractHeader
  end
  
  def testSite
    "#{$target_server}/"
  end
  
  def afterSetUp
  end

  def beforeTearDown
  end

  def afterTearDown
    begin
      if $target_browser==Constants::IE
        @browser.quit
      else
        @browser.close 
      end
      @report.finishReport()
    rescue
      puts :TearDownCrashed
    end
  end

  def caughtTest
    begin
      @report.createReport(self::getReportPath)
      self::runTest
      print $thread?"\nFinishing #{self.class}":" Done"      
      saveTest = true
    rescue      
      saveTest = false
      error = "\n\tCrashed! \nReason: " + $!.to_s
      if(Configuration::DEBUG)
        puts error
      end
      update_report(error, "CRASHED")
    end
    return saveTest
  end

  def setUp    
  end

  def getReportPath
    raise NotImplementedError
  end

  def runTest
    raise NotImplementedError
  end

  def tearDown
  end

  def testLoggedIn
    return true
  end

  def isProvider
    return false
  end
  
  def testLoggedOut
    return true
  end
  
  def update_report(description, reason)
    @generalTools.update_report(description, reason)   
  end 
  
  def report_status_passed
    @report.overallResult=='PASSED'
  end
  
  def wait _text
    (report_status_passed ? @generalTools.wait(_text, Configuration::WAIT_TIMEOUT) : false)
  end
  
  def login(params)
    return @generalTools.login(params)
  end
        
  def logout()
    return @generalTools.logout()
  end 

  def register(testName, xname='//*[@id="name"]',xemail='//*[@id="email"]',xpwd='//*[@id="password"]')
    return (@generalTools.register(testName, xname, xemail, xpwd))
  end

  def get_overlay_on_homepage
    @generalTools.get_overlay_on_homepage
  end
  
  def validate_entries_for_new_user
    @generalTools.validate_entries_for_new_user
  end
  
  def validate_facebook_agreement
    @generalTools.validate_facebook_agreement
  end
  
  def validate_birthdate_for_new_user
    @generalTools.validate_birthdate_for_new_user
  end
  
  def register_new_user
    @generalTools.register_new_user
  end
  
  def homepage_register_new_user
    @generalTools.homepage_register_new_user
  end
  
  def removeUser
    @generalTools.removeUser
  end
  
  def testGridItem testName
    @generalTools.testGridItem testName
  end
  
  def testBGImage(xpath)
    return @generalTools.testBGImage(xpath)
  end
  
  def testSocialNetwork target
    return @generalTools.testSocialNetwork(target)
  end
  
  def testBreadcrum composition
    return @generalTools.testBreadcrum(composition)
  end
end

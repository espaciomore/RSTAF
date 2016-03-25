class Lib_Tool
  def initialize(browser, report=nil)
    @browser = browser    
    @report = report
    @watir_helper = Lib_Tools_WatirHelper.new(self) 
    @validator = Lib_Forms_Validator.new(self)
  end
    
  def watir_helper
    return @watir_helper
  end
  
  def validator
    return @validator
  end
  
  def browser
    return @browser
  end
  
  def report
    return @report
  end
    
  def wait(text, waitValue = 0, usingXpath=false)
    if(waitValue == 0)
      waitValue = Configuration::WAIT_TIMEOUT
    end
    # Don't take longer than 20 seconds to find the specified text
    sleepTime = 0.2
    slept = 0
    while slept < waitValue do
      begin
        if not usingXpath and (@browser.html.include?(text) == true)
          return true
        end
        if usingXpath
          begin
            wasFound = @browser.element(:xpath => text).exists?
          rescue
            wasFound = false
          end
          if wasFound
            return true
          end
        end
      rescue
        return false
      end
      sleep sleepTime
      slept += sleepTime
    end
    return false
  end

  def waitOff(text, waitValue = 0, usingXpath=false)
    if(waitValue == 0)
      waitValue = Configuration::WAIT_TIMEOUT
    end
    # Don't take longer than 20 seconds to find the specified text
    sleepTime = 0.2
    slept = 0
    while slept < waitValue do
      if not usingXpath and (@browser.html.include?(text) == false)
        return true
      end
      if usingXpath and (Hpricot(@browser.html).search(text).length==0)
        return true
      end
      sleep sleepTime
      slept += sleepTime
    end
    return false
  end
  
  def waitUrl(url = "#{$target_server}/", waitValue = 0)
    if(waitValue == 0)
      waitValue = Configuration::WAIT_TIMEOUT
    end
    # Don't take longer than 20 seconds to find the specified text
    sleepTime = 0.2
    slept = 0
    while slept < waitValue do
      if (@browser.url == url)
        return true
      end
      sleep sleepTime
      slept += sleepTime
    end
    return false
  end

  def waitUrlLike(url = "#{$target_server}/", waitValue = 10)
    if(waitValue == 0)
      waitValue = Configuration::WAIT_TIMEOUT
    end
    # Don't take longer than 20 seconds to find the specified text
    sleepTime = 0.2
    slept = 0
    while slept < waitValue do
      if @browser.url.include?(url)
        return true
      end
      sleep sleepTime
      slept += sleepTime
    end
    return false
  end
    
  def waitUrls(urls, timeout = Configuration::WAIT_TIMEOUT)
    for i in 0..timeout
      urls.each do |url|
        if waitUrl(url,0.2)
          return true
        end
      end
    end
    return false
  end

  def waitOrCrash(text, waitValue = 0, usingXpath=false)
    if(waitValue == 0)
      waitValue = Configuration::WAIT_TIMEOUT
    end
    if(self::wait(text,waitValue,usingXpath))
      return true
    else
      begin
        raise("Finding the text: '#{text}' timed out after " + waitValue.to_s + " seconds")
      rescue
        return false
      end
    end
  end

  def waitOffOrCrash(text, waitValue = 0, usingXpath=false)
    if(waitValue == 0)
      waitValue = Configuration::WAIT_TIMEOUT
    end
    if(self::waitOff(text,waitValue,usingXpath))
      return true
    else
      begin
        raise("Finding the text: '#{text}' timed out after " + waitValue.to_s + " seconds")
      rescue
        return false
      end
    end
  end
  
  def verifyText(text, waitValue = 0, usingXpath=false)
    if(text.kind_of?(Array))
      text.each do |var|
        if(!verifyText(var, waitValue, usingXpath))
          return false
        end
      end
    else
      return wait(text, waitValue, usingXpath)
    end
    return true
  end
  
  def testBGImage(xpath)
    bgImage =  "#{@watir_helper.find(:xpath => xpath).style?('background-image').to_s}"
    url = bgImage.gsub!(/(.*?\()|(\).*?)/,"").gsub!(/(")+/,"")
    isImageLoaded = false
    begin
      newBrowser = Watir::Browser.new $target_browser
      newBrowser.goto("#{url}")
      sleep(2)
      isImageLoaded = newBrowser.image(:xpath, "//body/img").loaded?
      newBrowser.close
    rescue
      isImageLoaded = false
    end
    return isImageLoaded
  end
  
  def testSlider(regExp, xpath='//*[@id="sliderChoice"]/div/a') 
    begin
     slider = @browser.element(:xpath, xpath)
     slider.hover
     sleep 0.5
     slider.click
     succeeded = ((regExp.match slider.style)!=nil)
   rescue
     succeeded = false
   end
   return succeeded
  end

  def giveMeWord(length=2)
    if length<0
      length.abs
    end   
    string = ""
    chars = ("a".."z").to_a
    length.times do
      string << chars[rand(chars.length-1)]
    end
    return string
  end
  
  def including? first,second
    if second.kind_of?(Array)
      second.each do |recursive_second|
        if including?(first, recursive_second)
          return true
        end
      end
    else
      return first.include?(second)
    end
    return false  #becuase 
  end
  
  def onBreadcrum
    return @watir_helper.reset.div(:id => 'pathBreadcrumb')
  end
  
  def testBreadcrum composition 
    if !composition
      return false
    end
    begin
      _isValid = composition.has_key?(:image) ? onBreadcrum.image(:xpath => composition[:image]).loaded? : true
      composition[:titles].each do |_title|
        _isValid = (_isValid and onBreadcrum.find(:text => _title).exists?)
      end
    rescue
      _isValid = false
    end
    
    return _isValid
  end

  def update_report(description, reason)
    _reason = @report.overallResult=='PASSED' ? reason : 'CRASHED'
    if _reason.instance_of?(Proc) # => Proc === _reason
      update_report(description, _reason.call) 
    else
      @report.addToReport(description, _reason)  
    end    
  end 
    
  def login(params)
    return @LI.login(params)
  end
        
  def logout()
    return @LO.logout()
  end 
  
end
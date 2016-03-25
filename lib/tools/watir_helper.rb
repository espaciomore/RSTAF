class Lib_Tools_WatirHelper 
  def initialize(tools)
    @browser = tools.browser   
  end
  
  def clearCookies
    begin
      @browser.cookies.clear  
    rescue
      puts :WatirCouldNotClearCookies
    end
  end
  
  def reset
    @element = nil
    return self
  end
    
  def element
    @element
  end
  alias :context :element
  
  def setElement _element
    @element = _element  
    return self
  end
  
  def pageTitle
    begin
      return @browser.title  
    rescue
      puts :CannotRetrieveTitle
    end
    return nil
  end

  def send_keys key
    begin
      @browser.send_keys key  
      sleep 1
    rescue
      puts :CannotSimulateKeyPressed
    end
  end
  
  def urlLike _url
    begin
      return waitOnEval("@browser.url.include?('#{_url}')")  
    rescue
      puts :BrowserDoesNotIncludeURL
    end
    return false
  end

  def urlsLike _urls
    begin
      sleep_time = 0
      while(sleep_time < 5)
        _urls.each do |_url|
          if @browser.url.include?(_url) 
            return true
          end 
        end
        sleep_time += 1
        sleep 0.5
     end  
    rescue
      puts :BrowserDoesNotIncludeURL
    end
    return false
  end
        
  def goto _url
    begin
      @browser.goto _url
      return urlLike(_url)    
    rescue 
      puts :GotoCouldNotBeCompleted
    end
    
    return false
  end

  def go_back_to _url
    begin
      @browser.back   
      return urlLike(_url)
    rescue 
      puts :GotoCouldNotBeCompleted
    end
    return false
  end
  
  def use_window _index=1
    begin
      if(has_window(_index))
        @browser.window(:index => _index).use
      end
    rescue
      return false
    end
    return true
  end
  
  def has_window _index=1
    @browser.window(:index => _index).present?
  end
  
  def find(selector, timeout=6)
    begin
      sleepTime = 0.33
      slept = 0
      while slept < timeout do
        begin
          if @element
            @element = @element.element(selector) 
          else
            @element = @browser.element(selector) 
          end
          if @element.exists?
            break
          end
        rescue
          #nothing just continue
        end
        sleep sleepTime
        slept += sleepTime
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end

  def findAnchor selector,timeout=6
    begin
      sleepTime = 0.5
      slept = 0
      while slept < timeout do
        begin
          @element = @browser.a(selector) 
          if @element.exists?
            break
          end
        rescue
          #nothing just continue
        end
        sleep sleepTime
        slept += sleepTime
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end
  alias :findButton :findAnchor
  alias :findLink :findAnchor
  
  def image selector={:xpath => 'img'}
    begin
      if @element
        @element = @element.img(selector) 
      else
        @element = @browser.img(selector) 
      end 
    rescue 
      puts :ElementNotFound
    end
    return self
  end
  alias :img :image

  def tbody selector={:xpath => 'tbody'}
    begin
      if @element
        @element = @element.tbody(selector) 
      else
        @element = @browser.tbody(selector) 
      end 
    rescue 
      puts :ElementNotFound
    end
    return self
  end

  def tr selector={:xpath => 'tr'}
    begin
      if @element
        @element = @element.tr(selector) 
      else
        @element = @browser.tr(selector) 
      end 
    rescue 
      puts :ElementNotFound
    end
    return self
  end
        
  def checkbox selector={:xpath => 'input'}
    begin
      if @element
        @element = @element.checkbox(selector) 
      else
        @element = @browser.checkbox(selector) 
      end 
    rescue 
      puts :ElementNotFound
    end
    return self
  end
    
  def radio selector={:xpath => 'input'}
    begin
      if @element
        @element = @element.radio(selector) 
      else
        @element = @browser.radio(selector) 
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end

  def p selector={:xpath => 'p'}
    begin
      if @element
        @element = @element.p(selector) 
      else
        @element = @browser.p(selector) 
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end

  def litem selector={:xpath => 'li'}
    begin
      if @element
        @element = @element.li(selector) 
      else
        @element = @browser.li(selector) 
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end
    
  def span selector={:xpath => 'span'}
    begin
      if @element
        @element = @element.span(selector) 
      else
        @element = @browser.span(selector) 
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end
    
  def select_list selector={:xpath => 'select'}
    begin
      if @element
        @element = @element.select_list(selector) 
      else
        @element = @browser.select_list(selector) 
      end      
    rescue 
      puts :ElementNotFound
    end
    return self
  end

  def text_field selector={:xpath => 'input'}
    begin
      if @element
        @element = @element.text_field(selector) 
      else
        @element = @browser.text_field(selector) 
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end
  
  def button selector={:xpath => 'input'}
    begin
      if @element
        @element = @element.button(selector) 
      else
        @element = @browser.button(selector) 
      end 
    rescue 
      puts :ElementNotFound
    end
    return self
  end

  def anchor selector={:xpath => 'a'}
    begin
      if @element
        @element = @element.a(selector) 
      else
        @element = @browser.a(selector) 
      end 
    rescue 
      puts :ElementNotFound
    end
    return self
  end
  alias :abutton :anchor
  alias :link :anchor

  def div selector={:xpath => 'div'}
    begin
      if @element
        @element = @element.div(selector) 
      else
        @element = @browser.div(selector) 
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end
  alias :box :div

  def form selector={:xpath => 'form'}
    begin
      if @element
        @element = @element.form(selector) 
      else
        @element = @browser.form(selector) 
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end
    
  def h1 selector={:xpath => 'h1'}
    begin
      if @element
        @element = @element.h1(selector) 
      else
        @element = @browser.h1(selector) 
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end

  def h3 selector={:xpath => 'h3'}
    begin
      if @element
        @element = @element.h3(selector) 
      else
        @element = @browser.h3(selector) 
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end

  def h4 selector={:xpath => 'h4'}
    begin
      if @element
        @element = @element.h4(selector) 
      else
        @element = @browser.h4(selector) 
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end
      
  def ul selector={:xpath => 'ul'}
    begin
      if @element
        @element = @element.ul(selector) 
      else
        @element = @browser.ul(selector) 
      end
    rescue 
      puts :ElementNotFound
    end
    return self
  end
      
  def getText
    begin
      _text = @element.send(:text)
    rescue
      _text = ""
      puts :CouldNotGetText
    end  
    return _text
  end
  
  def lis max=100
    _list = []
    _index = 1
    _element = @element
    while(_index <= max)
      begin
        @element = _element.li(:xpath => "li[#{_index}]") 
        if not exists?
          raise :FoundAnyMoreElement
        end
        _list << @element
      rescue 
        break
      end
      _index += 1
    end
    @element = _element
    return _list
  end

  def trows max=100
    _trows = []
    _index = 1
    _element = @element
    while(_index <= max)
      begin
        @element = _element.tr(:xpath => "tr[#{_index}]") 
        if not exists?
          raise :FoundAnyMoreElement
        end
        _trows << @element
      rescue 
        break
      end
      _index += 1
    end
    @element = _element
    return _trows
  end

  def tcols max=10
    _tcols = []
    _index = 1
    _element = @element
    while(_index <= max)
      begin
        @element = _element.td(:xpath => "td[#{_index}]") 
        if not exists?
          raise :FoundAnyMoreElement
        end
        _tcols << @element
      rescue 
        break
      end
      _index += 1
    end
    @element = _element
    return _tcols
  end
      
  def divs max=100
    _list = []
    _index = 1
    _element = @element
    while(_index <= max)
      begin
        @element = _element.div(:xpath => "div[#{_index}]") 
        if not exists?
          raise :FoundAnyMoreElement
        end
        _list << @element
      rescue 
        break
      end
      _index += 1
    end
    @element = _element
    return _list
  end

  def get_spans max=10
    _list = []
    _index = 1
    _element = @element
    while(_index <= max)
      begin
        @element = _element.span(:xpath => "span[#{_index}]") 
        if not exists?
          raise :FoundAnyMoreElement
        end
        _list << @element
      rescue 
        break
      end
      _index += 1
    end
    @element = _element
    return _list
  end
  
  def options max=100
    _list = []
    _index = 1
    _element = @element
    while(_index <= max)
      begin
        @element = _element.option(:xpath => "option[#{_index}]") 
        if not exists?
          raise :FoundAnyMoreElement
        end
        _list << @element
      rescue 
        break
      end
      _index += 1
    end
    @element = _element
    return _list
  end  

  def clickAndDrag(_X,_Y)
    begin
      @element.mouseDownAt(_X)
      @element.mouseUpAt(_Y)
    rescue 
      puts :ElementCouldNotBeDragged
    end
  end
  
#  def click
#    begin
#      @element.mouseDown
#      @element.mouseUp
#    rescue 
#      puts :ElementCouldNotBeClicked
#    end
#  end
            
  def clickOn wTime=0.5
    begin
      @element.hover
      sleep wTime
      @element.click
    rescue 
      puts :ElementCouldNotBeClick
    end
  end
  
  def set value=true
    begin
      @element.set value.to_s
    rescue 
      begin
        @element.set
      rescue
        puts :ElementCouldNotBeSet
      end
    end
  end

  def typeBySet(value='',slow=0.3)
    begin
      valString = ''
      (value.to_s).each_char do |char|
        valString += char
        @element.set valString
        sleep slow
      end
    rescue 
      begin
        @element.set value
      rescue
        puts :ElementCouldNotBeSet
      end
    end
  end
  
  def type(value='',slow=0.2)
    begin
      @element.clear
      (value.to_s).each_char do |char|
        @element.append char
        sleep slow
      end
    rescue 
      begin
        @element.set value
      rescue
        puts :ElementCouldNotBeSet
      end
    end
  end
          
  def select value
    begin
      @element.select value.to_s
    rescue 
      puts :ElementCouldNotBeSelected
    end
  end
  
  def style? style
    return @element.style.include?(style)
  end

  def css style
    return @element.style(style)
  end
      
  def attr attr
    @element.attribute_value(attr)
  end   
  
  def exists?(_element=@element) 
    begin
      _exists = _element.exists?
    rescue
      _exists = false
    end
    return _exists
  end
  
  def loaded? _element=@element   
    return _element.loaded?
  end
  
  def waitOnEval(_code='',wTime=10)
    for i in 0..wTime
      if eval(_code)
        return true
      end
      sleep 0.5
    end
    return false
  end
      
  protected
  def method_missing(target,*args, &block)
    #puts "*#{target}*"
    begin
      for i in 0..3
        if @element.exists? && @element.visible?
          break
        end
        sleep 0.5
      end
      if @element.exists?
        case target
        when :click then
          @element.click    
        else
          return @element.send(target,*args,&block)
        end
      else
        puts "MissingElement"
      end  
    rescue
      puts "MissingMethod_#{target}"
    end
  end
  
  private
  def element=obj
    @element = obj
  end
end
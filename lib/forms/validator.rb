class Lib_Forms_Validator
  def initialize(tools)
    @generalTools = tools
    @watir_helper = tools.watir_helper
    @browser = tools.browser
  end

  def clearValuesFor(formField)
    formField.each do |key, value|
      value.clearValue @generalTools, key
    end
  end

  def validate(formFields, allowDisable = false, searchType=:class, searchValue = "mButton submit wizard-submit", assumeFull = false)
    begin
      if(!formFields.kind_of?Array)
        formFields = [formFields]
      end
      wrongs = 0
      for i in 0..formFields.size-1
        formFields[i].each do |key, value|
          if(value.getUnsupportedValue == false)
            begin
              value.clearValue(@generalTools, key)
              value.setValue(@generalTools, key, value.getSupportedValue())
            rescue
              if(allowDisable)
                next
              else
                raise
              end
            end
          else
            value.setValue(@generalTools, key, value.getUnsupportedValue())
            sleep value.needsWaitTime
            wrongs += 1
          end
          sleep 1
        end
      end
      formSubmit(searchType, searchValue)
      error = @generalTools.wait("Please insert valid values",3) or @generalTools.wait("Please insert a valid Zip Code or City and State combination",3)
      if error and wrongs == 0 or not error and wrongs > 0
        return false
      end
      if wrongs > 0
        for i in 0..formFields.size-1
          formFields[i].each do |key, value|
            if(value.getSupportedValue() == false)
              value.setValue(@generalTools, key, key)
            else
              wrongs -= 1
              value.setValue(@generalTools, key, value.getSupportedValue())
              sleep value.needsWaitTime
            end
            value.setExtraActions(@generalTools, key, value)
            sleep 2
            if i == formFields.size-1 and not assumeFull
              formSubmitToNext(searchType, searchValue)
            else
              formSubmit(searchType, searchValue)
            end
            error = @generalTools.wait("Please insert valid values",3) or @generalTools.wait("Please insert a valid Zip Code or City and State combination",3)
            if error and wrongs == 0 or !error and wrongs > 0
              return false
            end
          end
        end
      end 
      return true
    rescue
      #nothing 
    end
    return false
  end

  def validateForm(formFields, allowDisable = false)
    begin
      errors = Array.new
      if(!formFields.kind_of?Array)
        formFields = [formFields]
      end
      wrongs = 0
      for i in 0..formFields.size-1
        formFields[i].each do |key, value|
          if(value.getUnsupportedValue == false)
            begin
              value.setValue(@generalTools, key, key)
            rescue
              if(allowDisable)
                next
              else
                raise
              end
            end
          else
            value.setValue(@generalTools, key, value.getUnsupportedValue())
            sleep value.needsWaitTime
            wrongs += 1
          end
          sleep 1
          if(value.validateText)
            errors << value.validateText #Save errors messages in an Array to verify later
          end
        end
      end
      @browser.send_keys :tab
      @browser.link(:class, "submit").click
      sleep 3 #Giving time for the error messages to appear
      error = true
      errors.each do |message|
        #puts message
        if !@generalTools.wait(message, 5) #false if the error text doesn't appear on the site
          #puts 'false'
          error = false
        else
          #puts 'true'
        end
      end
      if error and wrongs == 0 or !error and wrongs > 0
        return false
      end
      if wrongs > 0
        for i in 0..formFields.size-1
          formFields[i].each do |key, value|
            if(value.getSupportedValue() == false)
              value.setValue(@generalTools, key, key)
              value.setExtraActions(@generalTools, key, value)
            else
              wrongs -= 1
              value.setValue(@generalTools,key,value.getSupportedValue())
              sleep value.needsWaitTime
              value.setExtraActions(@generalTools, key, value)
            end
            sleep 2
            error = @generalTools.wait(value.validateText, 5) #Verify that the error text of the current field appears on the site
            if error and wrongs == 0 or !error and wrongs > 0
              return false
            end
          end
        end
      end
      submitClaim()
      return true
    rescue
      #nothing
    end
    return false
  end

  def submitClaim()
    formSubmit(:class, "submit")
  end
  
  def formSubmit(searchType=:class, searchValue="mButton submit wizard-submit")
    @browser.a(searchType, searchValue).click
  end
  
  def formSubmitToNext(searchType=:class, searchValue="mButton submit wizard-submit")
    isWizard = true
    begin
      before = @browser.div(:xpath, 'INSERT XPATH HERE').style
      after = @browser.div(:xpath, 'INSERT XPATH HERE').style
    rescue
      isWizard = false
    end
    @browser.a(searchType, searchValue).click     
    if isWizard
      for i in 0..10
        sleep(0.5)
        after = @browser.div(:xpath, 'INSERT XPATH HERE').style
        if before!=after
          return false
        end
      end
      puts "\nWarning: the progression bar for the #{@browser.url.gsub(/\/[a-zA-Z]+#/).capitalize} Wizard did not change"
    end
  end
end
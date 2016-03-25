class Lib_Tools_OverallReportsFactory < Lib_Tools_Reports
  def openReport(reportName)
    @overallResult = 'PASSED'
    @email_report = ''
    @content = Array.new
    @testCount = {:passed => 0, :failed => 0}
    @html = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
            <html xmlns="http://www.w3.org/1999/xhtml" lang="en" dir="ltr">
              !html!
            </html>'
    _fileName = reportName.gsub(/(?:\.\.\/)?/,'')
    @testName = _fileName.gsub(/(?:.*\/)+/,'')

    # Get current time
    t = Time.now
    # Create the report name
    strTime = t.strftime("_%d%m%Y_%H%M%S") 
    strNiceTime = t.strftime("%d-%m-%Y @ %H:%M:%S")
    strTotalReport = reportName + strTime
    _fileName += strTime

    re = Regexp.compile(Regexp.escape(Config_Paths::REPORT_FOLDER_PATH))
    baseUrl_fileName = strTotalReport.gsub(/#{re}?/,'')
    # Create the HTML report

    # Format the header of the HTML report
    stylesheet = 'style.css'

    @head =
       '<meta content=text/html; charset=ISO-8859-1 http-equiv=content-type>
        <title>Ruby & Selenium Test Automation Framework</title>
        <style type="text/CSS">'+Config_ReportConstants::CSS+'</style>'

    @body =
       '<div class=title>
        <h3>Acceptance Test Report</h3>
        </div>
        <hr width=100% size=1px />
        <table class=main border=0 width=95% cellpadding=2 cellspacing=2>
           <tbody>
              <tr>
                 <td width=20%><p class=bold_text>Target Server</p></td>
                 <td width=5%><p class=bold_text>:</p></td>
                 <td width=75%><p class=normal_text>' +$target_server+ '</p></td>
              </tr>
              <tr>
                 <td width=20%><p class=bold_text>Report Filename</p></td>
                 <td width=5%><p class=bold_text>:</p></td>
                 <td width=75%><p class=normal_text>' +_fileName.gsub(/(?:.*\/)+/,'')+ '</p></td>
              </tr>
             <tr>
                <td width=20%><p class=bold_text>Test Execution</p></td>
                <td width=5%><p class=bold_text>:</p></td>
                <td width=75%><p class=normal_text>From <span class="timestamp">' + strNiceTime + '</span> To <span class="timestamp">!time!</span></p></td>
             </tr>
             <tr>
                <td width=20%><p class=bold_text>Overall Result</p></td>
                <td width=5%><p class=bold_text>:</p></td>!overall!</tr>
           </tbody>
         </table>
         <div class=legend>
            <div>
              <div class=user>&nbsp;</div><div>User logged in</div>
              <div class=passed>&nbsp;</div><div>Test passed</div>
              <div class=failed>&nbsp;</div><div>Test failed</div>
              <div class=missing>&nbsp;</div><div>Test crashed &#47 Incomplete</div>
            </div>
         </div>
         <ul>'

    @fileName = baseUrl_fileName

    @absolutePath = strTotalReport
  end

  def addToReport(step, arg, tool = 'none', action = 'none')
    @testCount[:passed] += arg[:passed]
    @testCount[:failed] += arg[:failed]
    if arg[:failed]>0
      @overallResult = 'FAILED'
    end
    p = arg[:passed]
    f = arg[:failed]
    t = (p + f)
    if t>0
      passed = (100*p/t).to_s
      failed = (100*f/t).to_s
    else
      passed = '0'
      failed = '0'
    end
    
    _values = JSON.parse("{}")
    _values[:name] = step.match(/<h3.*<\/h3>/).to_s.gsub(/(<h3>)|(<\/h3>)/,'')
    _values[:online] = (step.match(/"user"+/).to_s.size > 0) ? "1" : "0"
    _values[:passed] = "#{p}"
    _values[:failed] = "#{f}"
    _values[:total] = "#{t}"
    _values[:ppercentage] = "#{passed}"   
    _values[:fpercentage] = "#{failed}" 
    
    @content << step
    @content << '<p value=\''+JSON.unparse(_values)+"'>#{p} acceptance tests out of #{t} (#{passed}%) have passed</p>"
    @content << '<table id="overall_results" width="740px"><tr>'
    @content << '<td width="'+passed+'%" style="background-color: green;"></td>'
    @content << '<td width="'+failed+'%" style="background-color: red;"></td>'
    @content << '</tr></table>'

  end

  def setTestCount testCount
    @testCount = testCount
    if @testCount[:failed] > 0
      @overallResult == 'FAILED'
    end
  end

  def setReportItems reportItems
    @reportItems = reportItems
  end

  def closeReport()
    #Construct overall results information
    @title = ''
    @title << '<li class=test-title><div class=icon>&nbsp;</div><div class=test-step><h3 style="color: black;">'
    tmp = @testName.split('_').each {|w| w.capitalize! }
    @title << tmp.join(' ')
    @title << '</h3></div><div class=test-result><p>&nbsp;</p></div></li>'
    p = @testCount[:passed]
    f = @testCount[:failed]
    t = (p + f)
    if t>0
      passed = (100*p/t).to_s
      failed = (100*f/t).to_s
    else
      passed = '0'
      failed = '0'
    end
    @title << "<p>#{p} acceptance tests out of #{t} (#{passed}%) have passed</p>"
    @email_report << "#{p} acceptance tests out of #{t} (#{passed}%) have passed.\n"
    @title << '<table id="overall_results" width="740px"><tr>'
    @title << '<td width="'+passed+'%" style="background-color: green;"></td>'
    @title << '<td width="'+failed+'%" style="background-color: red;"></td>'
    @title << '</tr></table>'
    @title << '<hr width=96% size=1px />'
    #Add content to the body
    @body << @title
    @body << @content.join('')
    # Open the HTML report
    
    # Get current time
    t = Time.now
    # Create the report name
    strTime = t.strftime("_%d%m%Y_%H%M%S")
    @absolutePath << strTime + '.html' 
    if(createDirectory(@absolutePath))      
      strFile = File.open(@absolutePath, 'w')
    else
    return false
    end

    # Add finishing time
    @body.gsub!(/(?:!time!)/,Time.new.strftime("%d-%m-%Y @ %H:%M:%S"))

    if (@overallResult == 'PASSED')
      @body.gsub!(/(?:!overall!)/,'<td width=75%><p class=overall_ok>' + @overallResult + '</p></td>')
    else
      @body.gsub!(/(?:!overall!)/,'<td width=75%><p class=overall_nok>' + @overallResult + '</p></td>')
    end

    if(@reportItems)
      @body << @reportItems
    end

    # Format the footer of the HTML report
    @body << '</ul>
            <hr width=100% size=1px />
            <div class=footer>
                <p class=small_text>espaciomore</p>
            </div>'

    html = "<head>#{@head}</head>"
    html << "<body>#{@body}</body>"

    stringToWrite = @html.gsub!(/(?:!html!)/, html)

    strFile.puts(stringToWrite)

    # Close the report
    strFile.close

    if Configuration::EMAIL_NOTIFICATION
      begin
        options = Hash.new
        options[:sender] = Configuration::GMAIL_USER
        options[:recipients] = Configuration::RECEPIENTS
        options[:body] = "\nRegression Tests have finished running on #{$target_server}.\n\n#{@email_report}\n\nFor more information see the attachments."
        options[:subject] = 'UAT Notification'
        require 'base64'
        options[:attachment] = "#{Base64.encode64(stringToWrite)}"
        emailHelper = Config_Email.new(options)
        emailHelper.sendEmail()
      rescue
        #nothing
        puts :EmailCouldNotBeSent
      end
    end
  end
end
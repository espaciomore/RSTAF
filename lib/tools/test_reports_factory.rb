class Lib_Tools_TestReportsFactory < Lib_Tools_Reports
  def openReport(reportName)
    @overallResult = 'PASSED'
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
    strTime = t.strftime("_%d%m%Y_%H%M%S") + '.html'
    strNiceTime = t.strftime("%d-%m-%Y @ %H:%M:%S")
    strTotalReport = reportName + strTime
    _fileName += strTime
    
    re = Regexp.compile(Regexp.escape(Config_Paths::REPORT_FOLDER_PATH))
    baseUrl_fileName = strTotalReport.gsub(/#{re}?/,'') 
    # Create the HTML report

    # Format the header of the HTML report
    stylesheet = '../style.css'
    
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
    
    @title = ''
    @title << '<li class=test-title><div class=icon>&nbsp;</div><div class=test-step><h3>'
    tmp = @testName.split('_').each {|w| w.capitalize! }
    @title << tmp.join(' ')
    @title << '</h3>'+ ($isLoggedIn?'<div class=user>&nbsp;</div>':'') +'</div><div class=test-result><p>&nbsp;</p></div></li>'  
      
    @absolutePath = strTotalReport 
  end
  
  def addToReport(step, arg, tool = 'none', action = 'none')
    @content << '<li><div class=icon>&nbsp;</div><div class=test-step>'
    @content << '<p class=normal_text>' + step + '</p></div>' 
    @content << '<div class=test-result>'
    
    if (arg == true)
      @content << '<div class=passed>&nbsp;</div>' #'<p class=result_ok>PASSED</p>'
      @testCount[:passed] += 1
    elsif (arg == false)
      @overallResult = 'FAILED'
      @content << '<div class=failed>&nbsp;</div>' #'<p class=result_nok>FAILED</p>'      
      @testCount[:failed] += 1
      $stdOutput.testReport("#{step}",'FAILED')
      if /(?:[bB][aA][cC][kK])+/.match(action) != nil
        tool.prevQuestion()
      end
    elsif (/(?:[mM][aA][tT][cC][hH])+/.match(arg) != nil)
      @content << '<p class=match>RESULTS MATCH</p>'
      @testCount[:passed] += 1
    elsif (/(?:[nN][oO][mM][aA][tT][cC][hH])+/.match(arg) != nil)
      @content << '<p class=nomatch>RESULTS DON\'T MATCH</p>'
      @testCount[:passed] += 1
    else
      @overallResult = 'FAILED'
      @content << '<div class=missing>&nbsp;</div>' #'<p class=result_nok>CRASHED</p>'
      @testCount[:failed] += 1
      $stdOutput.testReport("#{step}",'CRASHED')
    end
    @content << '</div>'
    @content << '</li>'   
    
  end
  
  def closeReport()
    #Add results count to overall report
    $report.addToReport(@title, @testCount)
    #Add content to the body
    _content = @title.dup
    _content << @content.join('')
    @body << _content
    # Open the HTML report
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
  end
end
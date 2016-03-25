class LocalRunTest

  def initialize()
    defineScopeVariable()
    defineGlobalVariables()
    setUpOptions()
  end

  def runTests()
    initReport()
    #!
    if @_tests.empty?
      @_tests << Tests_Suite
    end

    $scheduler.add(@_tests, true)
    sleep 2 # wait until all tests are added

    $runnungThread = true
    $scheduler.schedule(100)
    $runnungThread = false
    $scheduler.runTests( $_machine == "--server" )
    #!
    saveReport()
  end

  def setAcceptanceTest(test)
    begin
      @_tests << Object.const_get(test)
    rescue
      abort(@console_error_message)
    end
  end

  def setUpSocketOptions(optionsArray)
    optionsArray.each{ |option|
      ARGV << option
    }
    setUpOptions()
  end

  private

  def defineScopeVariable()
    #!  Define scope variables
    @options = {'--save-results' => false,
                '--dev' => false,
                '--prod' => false,
                '--qa' => false,
                '--ff' => false,
                '--ie' => false,
                '--login' => false,
                '--thread' => false,
                '--out' => false,
                '--server' => false,
                '--client' => false,
                '--endless' => false, }

    @console_error_message = "
    The syntax of this command is:\truby run_test.rb [OPTIONS] | [CLASSNAMES]\n
    Examples:\n 
    > ruby run_test.rb --prod --ff Tests_Sitemap_SitemapTest
    > ruby server_run_test.rb --qa
    > ruby client_run_test.rb
    
    OPTIONS:\t[ --save-results | --dev | --prod | --qa | --ff | --ie | --chrome | --login | --thread | --out | --local ]
    
    * Verify that all params are valid."

    @_tests = []
    #!
  end

  def defineGlobalVariables()
    #!  Define global variables
    if not File.exists?("config/configuration.rb")
      system("sed -e 's/QA/DEV/g' config/configuration.rb.tpl > config/configuration.rb;")
    end

    $validArguments = []
    $_usingStdOutput = Configuration::STD_OUTPUT
    $_machine = '--local'
    $stdOutput = Lib_Tools_StdOutputProxy.new
    $login = false
    $user = ''
    $runnungThread = false
    $saveResults = false
    $target_server = Configuration::TEST_SERVER
    $target_browser = Configuration::TEST_BROWSER
    $thread = false
    $report = Lib_Tools_OverallReportsFactory.new
    $scheduler = Lib_TaskScheduler.new
    $endless = false
    #!
  end

  def setUpOptions()
    for i in 0..(ARGV.size - 1) do
      param = ARGV[i]
      if (param != nil)
        if (!@options['--save-results'] and param == "--save-results")
          @options['--save-results'] = true
          $saveResults = true
          $validArguments << param
        elsif (!@options['--dev'] and param == "--dev")
          @options['--dev'] = true
          $validArguments << param
          $target_server = Constants::DEV
        elsif (!@options['--qa'] and param == "--qa")
          @options['--qa'] = true
          $validArguments << param
          $target_server = Constants::QA
        elsif (!@options['--prod'] and param == "--prod")
          @options['--prod'] = true
          $validArguments << param
          $target_server = Constants::PROD
        elsif (!@options['--ff'] and param == "--ff")
          @options['--ff'] = true
          $validArguments << param
          $target_browser = Constants::FIREFOX
        elsif (!@options['--ie'] and param == "--ie")
          @options['--ie'] = true
          $validArguments << param
          $target_browser = Constants::IE
        elsif (!@options['--chrome'] and param == "--chrome")
          @options['--chrome'] = true
          $validArguments << param
          $target_browser = Constants::CHROME
        elsif (!@options['--login'] and param == "--login")
          @options['--login'] = true
          $validArguments << param
          $login = true
        elsif (!@options['--thread'] and param == "--thread")
          @options['--thread'] = true
          $validArguments << param
          $thread = !$thread
        elsif (!@options['--out'] and param == "--out")
          @options['--out'] = true
          $validArguments << param
          $_usingStdOutput = true
        elsif (!@options['--server'] and param == "--server")
          @options['--server'] = true
          $validArguments << param
          $_machine = param
        elsif (!@options['--client'] and param == "--client")
          @options['--client'] = true
          $validArguments << param
          $_machine = param   
        elsif (!@options['--endless'] and param == "--endless")
          @options['--endless'] = true
          $validArguments << param
          $endless = true                      
        else
          begin            
            @_tests << Object.const_get(param)
          rescue
            abort(@console_error_message)
          end
        end
      end
    end
  end

  def initReport()
    $report.openReport(Config_Paths::REPORT_FOLDER_PATH + '/overall_report')
  end

  def saveReport()
    $report.finishReport
  end
end

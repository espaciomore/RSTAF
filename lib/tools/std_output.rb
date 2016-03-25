class Lib_Tools_StdOutput 
  def initialize()
    
  end
  
  def testReport(reason, condition)
    begin
      $stderr.puts("#{reason} #{condition}")
    rescue
      puts :CouldNotWriteToStdOut
    end
  end
end
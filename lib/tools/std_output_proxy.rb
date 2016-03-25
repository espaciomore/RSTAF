class Lib_Tools_StdOutputProxy
  def initialize()
    @stdOutput = Lib_Tools_StdOutput.new
  end
  
  def testReport(reason, condition)
    if $_usingStdOutput
      @stdOutput.testReport(reason, condition)
    end
  end
end
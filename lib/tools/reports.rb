class Lib_Tools_Reports 
  attr_accessor :fileName
  attr_accessor :absolutePath  
  attr_accessor :testName
  attr_accessor :html
  attr_accessor :head
  attr_accessor :body
  attr_accessor :title
  attr_accessor :content
  attr_accessor :overallResult
  attr_accessor :testCount 
  
  def initialize()    
  end
  
  def addToReport(step, arg, tool = 'none', action = 'none')
    raise NotImplementedError
  end
  
  def createReport(reportName)
    return self::openReport(reportName)
  end
  
  def finishReport()
    self::closeReport()
  end
  
  def openReport(reportName)
    raise NotImplementedError
  end
  
  def closeReport()
    raise NotImplementedError
  end
end
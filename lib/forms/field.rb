class Lib_Forms_Field
  def getSupportedValue
    raise NotImplementedError
  end

  def getUnsupportedValue
    raise NotImplementedError
  end

  def validateText
    raise NotImplementedError
  end

  def getInstance
    raise NotImplementedError
  end

  def setValue(tools, selector, value)
    raise NotImplementedError
  end

  def needsWaitTime
    return 0
  end

  def setExtraActions(tools, selector, value)
    return false
  end

  def emptyValue
    return ''
  end

  def clearValue(tools, selector)
    self::setValue(tools, selector, self::emptyValue)
  end
end
require "rubygems"
require "hpricot"
require "selenium-webdriver"
require "watir-webdriver"
require 'net/http'
require 'uri'
require 'json'

autoload(:Configuration, File.dirname(__FILE__) + "/configuration")

def pr(text)
  if Configuration::DEBUG
    puts text
  end
end

def getFilePath(klassName)
  path = klassName.split('_').collect! do |name|
    name.split(/(?=[A-Z])/).join('_')
  end
  return File.dirname(__FILE__) + "/.." + File::SEPARATOR + path.join('/').downcase
end

class Object
  
  class Array
    def shuffle
      sort_by { rand }
    end
  end

  class << self
    alias_method :old_const_missing, :const_missing
    private :old_const_missing
    def const_missing(const)
      filename = getFilePath(const.to_s)
      begin
        if File.exists?("#{filename}.rb")
          require filename
        else
          raise "FileNotFound"
        end
        const_get(const)
      rescue LoadError => e
        if e.message.include? filename
          old_const_missing(const)
        else
          raise
        end
      end
    end
  end
end

def createDirectory(path)
      pathArray = path.split('/')
      if(pathArray.empty?)
        return false
      end
      child = pathArray.pop
      parent = pathArray.join('/')
      if(parent.empty?)
        return false
      end
    if(!File.exists?(parent))
      create = createDirectory(parent)
      if(create)
        Dir.mkdir(parent)
      else
        return false
      end
    end
    return true
end

def subclasses_of(superclass)
  subclasses = []
  ObjectSpace.each_object(Class) do |k|
    next if !k.ancestors.include?(superclass) || superclass == k || k.to_s.include?('::') || subclasses.include?(k.to_s)
    subclasses << k.to_s
  end
  subclasses
end
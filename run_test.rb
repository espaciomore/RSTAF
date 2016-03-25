require File.dirname(__FILE__) + "/config/bootstrap.rb"
require File.dirname(__FILE__) + "/local_run_test.rb"

run_test = LocalRunTest.new()

while(true)
  run_test.runTests()
  break if not $endless
  sleep(23400) if $endless # => 6h30
end 
    
system('exit 0')


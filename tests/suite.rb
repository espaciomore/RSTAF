class Tests_Suite
  attr_accessor :tests
  
  def test
    @tests = [    
            # INSERT TEST CLASS NAMES
            ]
    
    $scheduler.add(@tests)   
    
    #*************************************
        
    @tests = [      
            # INSERT TEST CLASS NAMES
            ]
           
    $scheduler.add(@tests,true)
  end
end
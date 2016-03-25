class Tests_Sitemap_Suite  
  attr_accessor :tests
  
  def test
    @tests = [
            Tests_Sitemap_SitemapTest,
            ]
    
    $scheduler.add(@tests, true)
  end
end
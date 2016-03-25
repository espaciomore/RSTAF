class Tests_Sitemap_SitemapTest < Lib_Tests_AcceptanceTest
  def getReportPath
    Config_Paths::REPORT_FOLDER_PATH + '/sitemap/sitemap'
  end
  
  def testSite
    "#{$target_server}/sitemap"
  end
  
  def testLoggedIn
    false
  end
  
  def runTest
    sitemap = {
      'KEY' => 'VALUE',
    }

    sitemap.each do |site, ref|
      update_report("[Sitemap] Test that the sitemap found the \"#{site}\" sitemaps to link to", 
                    test_link(site, ref))
    end
  end
  
  def test_link(site, ref)
    Proc.new do
      begin
        raise "verify link '#{site}' present" if not @watir_helper.reset.link( :text => site).exists?
        @browser.link(:href => "#{$target_server}/sitemap/#{ref}").click
        raise "verify redirect to /#{site}" if not @watir_helper.urlLike("#{$target_server}/sitemap/#{ref}")
        raise "verify redirect back to /sitemap" if not @watir_helper.go_back_to("#{$target_server}/sitemap")      
        isValid = true
      rescue Exception => e
        puts "FAILED to #{e}"
        isValid = false  
      end
      isValid
    end
  end
end
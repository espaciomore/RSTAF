require 'net/smtp'
require 'tlsmail'

class Config_Email 
  
  def initialize(options=nil)
    @options = Hash.new
    if options == nil
      @options[:sender] = 'INSERT SENDER EMAIL ADDRESS'
      @options[:recipients] = 'INSERT RECIPIENT EMAIL ADDRESS'
      @options[:body] = "An Error has ocurred while running the regression tests for Noodle Site.\n\nFor more information see the attachments."
      @options[:subject] = 'UAT Notification'
      @options[:attachment] = ""
    else
      @options = options
    end
  end
    
  def sendEmail msgstr=""        
    
    msgstr << "from:UAT Notification Center <#{@options[:sender]}>\r\n"
    msgstr << "subject:#{@options[:subject]}\r\n"
    msgstr << "MIME-Version: 1.0\r\n"
    msgstr << "Content-Type: multipart/mixed; boundary=ENDBODY\r\n"
    msgstr << "--ENDBODY\r\n"
    msgstr << "Content-Type: text/plain\r\n"
    msgstr << "Content-Transfer-Encoding: 8bit\r\n"
    msgstr << "#{@options[:body]}\r\n"
    msgstr << "--ENDBODY\r\n"
    msgstr << "Content-Type: text/xml\r\n"
    msgstr << "Content-Transfer-Encoding:base64\r\n"
    msgstr << "Content-Disposition: attachment; filename=reporte.html\r\n"
    msgstr << "#{@options[:attachment]}\r\n"
    msgstr << "--ENDBODY--"
    
    Net::SMTP.enable_tls(OpenSSL::SSL::VERIFY_NONE)
    Net::SMTP.start('smtp.gmail.com', 587, 'gmail.com', Configuration::GMAIL_USER, Configuration::GMAIL_PASS, :plain) do |smtp|
      @options[:recipients].each do |recipient|
        smtp.send_message(msgstr, @options[:sender], recipient)
      end
    end
  end
end



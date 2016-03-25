require File.dirname(__FILE__) + "/constants"

class Configuration
  # Use stderr for std output, to be used by TeamCity
  STD_OUTPUT = true
  
  # Server to run the test
  TEST_SERVER = Constants::DEV

  # Browser to run the test
  TEST_BROWSER = Constants::FIREFOX

  #Folder root
  ROOT_FOLDER_PATH = File.dirname(__FILE__) + "/.."

  # Wait timeout for browser requests and wait timer
  WAIT_TIMEOUT = 10

  # Debug mode on
  DEBUG = true

  # Default USER, PASS for application login action
  DEFAULT_USER = 'INSERT DEFAULT USERNAME'
  DEFAULT_PASS = 'INSERT DEFAULT USERNAME'

  # Default USER, PASS for application login action
  REGISTER_USER = 'INSERT REGISTRATION USERNAME'
  REGISTER_PASS = 'INSERT REGISTRATION PASSWORD'
  
  # Facebook USER, PASS for FacebookConnect form
  FACEBOOK_USER = 'INSERT FACEBOOK USERNAME'
  FACEBOOK_PASS = 'INSERT FACEBOOK PASSWORD'

  # Provider USER, PASS for application login acction
  PROVIDER_USER = 'INSERT APPLICATION USERNAME'
  PROVIDER_PASS = 'INSERT APPLICATION PASSWORD'
  
  # Double test with login by default
  TEST_LOGGED_IN = true
  
  # Activate Email Notification
  EMAIL_NOTIFICATION = false
  RECEPIENTS = ['INSERT NOTIFICATIONS EMAIL ADDRESSES']
  
  # Gmail USER, PASS 
  GMAIL_USER = 'INSERT EMAIL ADDRESS'
  GMAIL_PASS = 'INSERT EMAIL PASSWORD'  
  
  # Master / Slave Arquitecture
  CLIENTS = ["INSERT IP ADDRESS HERE"]
  CLIENTS_IE = ["INSERT IP ADDRESS HERE"]
  USERNAME = 'INSERT HOST USER ACCOUNT'
  HOST = 'INSERT HOST IP ADDRESS'
  PORT = 15000
end

#!/usr/bin/env ruby
 require 'rubygems'
 require 'net/ssh'
 
 HOST = '10.0.0.29'
 USER = 'noodleqa'
 PASS = 'welc0me'
 
 Net::SSH.start( HOST, USER, :password => PASS ) do|ssh|
  #result = ssh.exec!('ls /var/www/html/continuous_delivery/acceptance_tests/sockets/reports')
  result = ssh.exec!('ls')
  
  puts result
 end
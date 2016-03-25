#!/usr/bin/env ruby
 require 'rubygems'
 require 'net/ssh'
 
 HOST = 'INSERT HOST IP ADDRESS'
 USER = 'INSERT HOST ACCOUNT'
 PASS = 'INSERT HOST PASSWORD'
 
 Net::SSH.start( HOST, USER, :password => PASS ) do|ssh|
  #result = ssh.exec!('ls /var/www/html/continuous_delivery/acceptance_tests/sockets/reports')
  result = ssh.exec!('ls')
  
  puts result
 end

# feel free to use irb to test.

require 'socket'

s = TCPSocket.open("localhost", 3999)

s.puts "NEW" ; r = s.gets ; p r

s = TCPSocket.open("localhost", 3999)

s.puts r ; rr = s.gets ; p rr

s.puts "QUERY Who is Anna?" ; rr = s.gets ; p rr

s.puts "TWEET" ; rr = s.gets ; p rr
s.puts "TWEET" ; rr = s.gets ; p rr
s.puts "TWEET" ; rr = s.gets ; p rr
s.puts "QUERY Who is Elisa?" ; rr = s.gets ; p rr
s.puts "TWEET" ; rr = s.gets ; p rr
s.puts "TWEET" ; rr = s.gets ; p rr

s.puts "QUIT" ; rr = s.gets ; p rr

s.close

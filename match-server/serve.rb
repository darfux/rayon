# -*- coding: utf-8 -*-
require 'socket'                # Get sockets from stdlib
require 'time'

port = 3999 # on which the server will listen

server = TCPServer.open(port)   # Socket to listen on port

hh = Hash.new # hash table to store each request.

loop {                          # Servers run forever
  Thread.start(server.accept) do |client|

    salt = "" # UNIQUE ID sent by server.
    const_salt_length = 18 #现在ID是18位
    begin
      str = client.gets
      p str
      str.chomp!
      if str == "HELO" # C: HELLO?
        client.puts "OK" # S: Hi.
      elsif str == "NEW" # C: I'm a new comer
        salt = (sprintf("%.07f",(Time.now.to_f() + rand()).to_s()))
        hh[salt] = 0
        client.puts salt # S: I'll give you your ID.
      elsif str.length > 6 && str[0..4] == "QUERY" # C: Where is ...
        if salt != "" # S: I know you.
          if hh[salt] > 10 or hh[salt] == 0
            client.puts "ACCEPTED" # S: I'll look for that.
            hh[salt] = 1 # S: your request has been recorded.
          else # S: Your last QUERY is not yet finished.
            client.puts "DECLINED"
          end
        else # S: I don't know you. (due to timeout), please send your ID.
          client.puts "WHO" # S: WHO?
        end
      elsif str == "TWEET" # C: Hey, Where is ...
        if salt != "" # S: I know you
          if hh[salt] > 10 # S: I got that.
            client.puts "ANSWER" # S: It is at ...
          else
            hh[salt]*=2; # Fake progress.
            client.puts "WAIT" # S: Still searching...
          end
        else
          client.puts "WHO" # S: I don't know you (due to timeout), please send your ID.
        end
      elsif str.length() == const_salt_length && str=~ /[0-9\.]*/ # Client send its ID.
        if hh.has_key? str # S: Oh, I remembered.
          salt = str # set salt.
          client.puts "BUDDY" # Oh, buddy it you.
        else
          client.puts "NO_USER" # Oh, We've never met!!!
        end
      elsif str == "QUIT" # C: Goodbye.
        client.puts "Bye~" # S: Byebye.
        hh.delete(salt) if salt != ""
        client.close # Disconnect from the client
      end
    end while str!="QUIT"
  end
}

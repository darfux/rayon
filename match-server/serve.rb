require 'rubygems'
require 'rack'
require 'json'

Rack::Handler::Mongrel.run proc { |env|

  headers = {
    :'Content-Type' => 'text/plain',
    :Server => 'Ruby-Mongrel'
  }

  postData =  env["rack.input"].string.strip

  bodies = ["Some body\n"]

  ## validate postData.
  post = false
  begin 
    post = (JSON.parse(postData)).to_s if postData!=""
  rescue
    puts "invalid post json"
  end

  if not post
    headers[:reason] = 'Post not found.'
    next [200, headers, []];
  end


  ## Deal with posts 
  
  [200, headers, [post]]
  
}, :Port => 3999


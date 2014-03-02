require 'rubygems'
require 'rack'
require 'json'

Rack::Handler::Mongrel.run proc { |env|

  headers = {
    :'Content-Type' => 'text/plain',
    :Server => 'Ruby-Mongrel'
  }

  postData =  env["rack.input"].string

  bodies = ["Some body\n"]

  ## TODO: validate postData.
  post = (JSON.parse(postData)).to_s if postData.strip!=""

  if not post
    headers[:reason] = 'Post not found.'
    next [200, headers, []];
  end


  ## Deal with posts 
  
  [200, headers, [post]]
  
}, :Port => 3999


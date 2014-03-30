require "data_url/version"

require 'base64'
require 'uri'

module DataURL
  def self.parse(url)
    return nil, nil, nil if url.nil? or url.empty?
    
    scheme, content_type, body = url.split(%r/[:,]/, 3).map { |field| URI.unescape(field) }
    raise InvalidURLError, "Can't parse as data URL: #{url}" if scheme != 'data' or body.nil?

    base64 = not(content_type.sub!(';base64', '').nil?)
    
    content_type = "text/plain;charset=US-ASCII" if content_type.empty?
    content_type = "text/plain" + content_type if content_type =~ /\A;/
    
    body = Base64.decode64(body) if base64 
    
    return body, content_type, base64
  end
  
  def self.create(body, content_type = 'application/octet-stream', base64 = true)
    return nil if body.nil?
    
    encoded_body = if base64
      content_type += ";base64"
      Base64.strict_encode64(body)
    else
      body
    end
    
    "data:#{URI.escape(content_type)},#{URI.escape(encoded_body)}"
  end
  
  class InvalidURLError < StandardError; end
end

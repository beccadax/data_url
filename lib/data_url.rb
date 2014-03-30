require "data_url/version"

require 'base64'
require 'uri'

module DataURL
  def self.parse(url)
    return nil, nil, nil if url.nil? or url.empty?
    
    scheme, content_type, encoded_data = url.split(%r/[:,]/, 3)
    fail "Not a data URI: #{url}" if scheme != 'data' or encoded_data.nil?

    content_type = "application/octet-stream" if content_type.empty?
    base64 = not(content_type.sub!(';base64', '').nil?)
    
    data = if base64 
      Base64.decode64(encoded_data)
    else
      URI.unescape(encoded_data)
    end
    
    return data, content_type, base64
    
  end
  
  def self.create(data, content_type = 'application/octet-stream', base64 = true)
    return nil if data.nil?
    
    encoded_data = if base64
      content_type += ";base64"
      Base64.strict_encode64(data)
    else
      URI.escape(data)
    end
    
    "data:#{content_type},#{encoded_data}"
  end
end

require "data_url/version"

require 'base64'
require 'uri'

module DataURL
  def self.parse(url)
    return nil, nil, nil if str.nil? or str.empty?
    
    scheme, type, encoded_data = str.split(%r/[:,]/, 3)
    fail "Not a data URI: #{str}" if scheme != 'data' or encoded_data.nil?

    type = "application/octet-stream" if type.empty?
    base64 = not(type.sub!(';base64', '').nil?)
    
    data = if base64 
      Base64.decode64(encoded_data)
    else
      URI.unescape(encoded_data)
    end
    
    return data, type, base64
    
  end
  
  def self.create(data, content_type = 'application/octet-stream', base64 = true)
    return nil if data.nil?
    
    encoded_data = if base64
      type += ";base64"
      Base64.strict_encode64(data)
    else
      URI.escape(data)
    end
    
    "data:#{type},#{encoded_data}"
  end
end

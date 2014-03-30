require "data_url/version"

require 'base64'
require 'uri'

module DataURL
  def self.parse(url)
    return nil, nil, nil if url.nil? or url.empty?
    
    scheme, content_type, encoded_data = url.split(%r/[:,]/, 3)
    raise InvalidURLError, "Can't parse as data URL: #{url}" if scheme != 'data' or encoded_data.nil?

    base64 = not(content_type.sub!(';base64', '').nil?)
    content_type = "application/octet-stream" if content_type.empty?
    
    data = URI.unescape(encoded_data)
    data = Base64.decode64(data) if base64 
    
    return data, content_type, base64
  end
  
  def self.create(data, content_type = 'application/octet-stream', base64 = true)
    return nil if data.nil?
    
    encoded_data = if base64
      content_type += ";base64"
      Base64.strict_encode64(data)
    else
      data
    end
    encoded_data = URI.escape(encoded_data)
    
    "data:#{content_type},#{encoded_data}"
  end
  
  class InvalidURLError < StandardError; end
end

require "data_url/version"

require 'base64'
require 'uri'

module DataURL
  def self.parse(url)
    return nil, nil, nil if url.nil? or url.empty?
    
    scheme, content_type, data = url.split(%r/[:,]/, 3).map { |field| URI.unescape(field) }
    raise InvalidURLError, "Can't parse as data URL: #{url}" if scheme != 'data' or data.nil?

    base64 = not(content_type.sub!(';base64', '').nil?)
    content_type = "application/octet-stream" if content_type.empty?
    
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
    
    "data:#{URI.escape(content_type)},#{URI.escape(encoded_data)}"
  end
  
  class InvalidURLError < StandardError; end
end

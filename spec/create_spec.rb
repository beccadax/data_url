require 'spec_helper'

describe DataURL do
  context :create do
    it "should return nil if data is nil" do
      DataURL.create(nil).should be_nil
    end
    
    it "should return empty data if data is empty" do
      DataURL.create('').should match(/,\Z/)
    end
    
    it "should return data URLs" do
      DataURL.create('').should match(/\Adata:/)
    end
    
    it "should encode as Base64 by default" do
      DataURL.create('').should match(/;base64,/)
    end
    
    it 'should URL-encode when Base64 is off' do
      DataURL.create('abc ', 'application/octet-stream', false).should match(/abc%20\Z/)
    end
    
    it "should correctly encode Base64" do
      DataURL.create('abc').should match(/,YWJj\Z/)
    end
    
    it 'should include content type when specified' do
      DataURL.create('abc', 'foo/bar').should match(/:foo\/bar;/)
    end
    
    it 'should default content type to octet-stream' do
      DataURL.create('abc').should match(/:application\/octet-stream/)
    end
    
    it 'should not include newlines in Base64 data' do
      data = 'x' * 1000
      DataURL.create(data).should_not match(/\n/)
    end
  end
end
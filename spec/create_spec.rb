require 'spec_helper'

describe DataURL do
  context :create do
    it "should return nil if data is nil" do
      DataURL.create(nil).should be_nil
    end
    
    it "should return empty data if data is empty" do
      expect(DataURL.create('')).to match(/,\Z/)
    end
    
    it "should return data URLs" do
      expect(DataURL.create('')).to match(/\Adata:/)
    end
    
    it "should encode as Base64 by default" do
      expect(DataURL.create('')).to match(/;base64,/)
    end
    
    it 'should URL-encode when Base64 is off' do
      expect(DataURL.create('abc ', 'application/octet-stream', false)).to match(/abc%20\Z/)
    end
    
    it "should correctly encode Base64" do
      expect(DataURL.create('abc')).to match(/,YWJj\Z/)
    end
    
    it 'should include content type when specified' do
      expect(DataURL.create('abc', 'foo/bar')).to match(/:foo\/bar;/)
    end
    
    it 'should default content type to octet-stream' do
      expect(DataURL.create('abc')).to match(/:application\/octet-stream/)
    end
    
    it 'should not include newlines in Base64 data' do
      data = 'x' * 1000
      expect(DataURL.create(data)).not_to match(/\n/)
    end
  end
end
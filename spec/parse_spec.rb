require 'spec_helper'

describe DataURL do
  context :parse do
    it "should return nils if URL is nil" do
      DataURL.parse(nil).should == [nil, nil, nil]
    end
    
    it "should return empty string for empty data" do
      DataURL.parse('data:,').first.should == ''
    end
    
    it "should parse base64'd data as base64" do
      DataURL.parse('data:;base64,YWJj').should == ['abc', 'application/octet-stream', true]
    end
    
    it "should parse URL-encoded data as URL-encoded" do
      DataURL.parse('data:,abc%20').should == ['abc ', 'application/octet-stream', false]
    end
    
    it "should parse out content types" do
      DataURL.parse('data:text/plain,').should == ['', 'text/plain', false]
    end
  end
end
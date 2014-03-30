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
      DataURL.parse('data:;base64,YWJj').should == ['abc', 'text/plain;charset=US-ASCII', true]
    end
    
    it "should parse URL-encoded data as URL-encoded" do
      DataURL.parse('data:,abc%20').should == ['abc ', 'text/plain;charset=US-ASCII', false]
    end
    
    it "should parse out content types" do
      DataURL.parse('data:application/octet-stream,').should == ['', 'application/octet-stream', false]
    end
    
    it "should default to ASCII text/plain" do
      DataURL.parse('data:,')[1].should == 'text/plain;charset=US-ASCII'
    end
    
    it "should default to text/plain when a charset is specified" do
      DataURL.parse('data:;charset=UTF-8,')[1].should == 'text/plain;charset=UTF-8'
    end
    
    it "should raise an exception for invalid strings" do
      expect { DataURL.parse('gibberish') }.to raise_error DataURL::InvalidURLError
    end
    
    it "should raise an exception for non-data URLs" do
      expect { DataURL.parse('http://google.com/some,thing') }.to raise_error DataURL::InvalidURLError
    end
    
    it "should raise an exception for data URL with the content-type field and delimiter missing" do
      expect { DataURL.parse('data:gibberish') }.to raise_error DataURL::InvalidURLError
    end
    
    it "should ignore invalid crap in base64'd data" do
      DataURL.parse('data:;base64,YWJj!YWJj').first.should == 'abcabc'
    end
    
    it "should ignore escaped invalid crap in base64'd data" do
      DataURL.parse('data:;base64,YWJj%20YWJj').first.should == 'abcabc'
    end
  end
end
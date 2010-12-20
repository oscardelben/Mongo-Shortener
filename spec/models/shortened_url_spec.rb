require 'spec_helper'

describe ShortenedUrl do
  
  context "Shortend url creation" do
    
    it "should create the shortened version before save" do
      url = ShortenedUrl.new(:url => 'http://example.com')
      url.save!
      url.shortened.should_not be_nil
    end
    
    it "shuld create the shortened version before save only if not already present" do
      url = ShortenedUrl.new(:url => 'http://example.com', :shortened => 'foo')
      url.save!
      url.shortened.should == 'foo';
    end
    
    it "should check that shortened version don't exist already" do
      ShortenedUrl.create!(:url => 'http://example.com', :shortened => 'foo')
      
      url = ShortenedUrl.create!(:url => 'http://another-example.com', :shortened => 'foo')
      url.shortened.should_not == 'foo';
      url.shortened.should_not be_nil
    end
    
  end
  
  context "Visited!" do
    
    it "should increment hits_count if nil" do
      url = ShortenedUrl.create!(:url => 'http://example.com', :shortened => 'foo')
      url.visited!
      url.reload.hits_count.should == 1
    end
    
    it "should increment hits_count" do
      url = ShortenedUrl.create!(:url => 'http://example.com', :shortened => 'foo', :hits_count => 16453)
      url.visited!
      url.reload.hits_count.should == 16454
    end
    
    it "should update last_hit" do
      url = ShortenedUrl.create!(:url => 'http://example.com', :shortened => 'foo')
      url.visited!
      url.last_hit.to_date.should == Time.now.to_date
    end
    
  end
  
end

require 'spec_helper'

describe UrlsController do

  describe "POST make_short" do
  
    context "when posting a valid url" do
      
      let(:full_url) { 'http://example.com' }
      let(:short) { 'abcde' }
      
      before(:each) do
        @url = mock_model('ShortenedUrl', :save! => true, :shortened => short)
        ShortenedUrl.should_receive(:new).with(:url => full_url).and_return(@url)
        @url.should_receive(:save!)
      end
      
      it "should save the url" do
        xhr :post, :make_short, :url => full_url
      end
      
      it "should render the shortened version via javascript update" do
        page = double('page')
        controller.stub(:render)
        controller.stub(:render).with(:update).and_yield(page)
        
        shortened_url = controller.url_for(:controller => :urls, :action => :show, :id => short)
        
        page.should_receive(:replace_html).with('result', shortened_url)
        page.should_receive(:<<).with("$('#result').show()")
        
        xhr :post, :make_short, :url => full_url
      end
      
    end
  
  end
  
  describe "GET show" do
    
    let(:shortened_url) { mock_model('ShortenedUrl', :hits_count => nil, :last_hit => nil, :url => 'http://example.com?foo=bar', :shortened => 'a3de3') }
    
    before(:each) do
      ShortenedUrl.should_receive(:first).and_return(shortened_url)
      shortened_url.stub!(:visited!).and_return(true)
    end
    
    context "format http" do
    
      it "should redirect to full url" do
        get :show, :id => 'a3de3'    
        response.should redirect_to('http://example.com?foo=bar')
      end
      
      it "should add stats" do
        shortened_url.should_receive(:visited!)       
        get :show, :id => 'a3de3'
      end
      
    end
    
    context "format stats" do
      
      it "should be successful" do
        get :show, :id => 'a3de3', :format => :stats
        response.status.should == 200
      end
      
    end
    
    context "format preview" do
      
      it "should be successful" do
        get :show, :id => 'a3de3', :format => :preview
        response.status.should == 200
      end
      
    end
    
  end

end

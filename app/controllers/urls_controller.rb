class UrlsController < ApplicationController
  
  def index
    
  end
  
  def make_short
    @shortened_url = ShortenedUrl.new(:url => params[:url])
    @shortened_url.save!
    
    shortened = url_for(:action => :show, :id => @shortened_url.shortened)

    render :update do |page|
      page.replace_html 'result', shortened
      page << "$('#result').show()"
    end
  end
  
  def show
    @shortened_url = ShortenedUrl.first(:conditions => { :shortened => params[:id] })

    respond_to do |format|
      format.html do
        @shortened_url.visited!
        redirect_to(@shortened_url.url)
      end
      format.stats { render :layout => "application.html" }
      format.preview { render :layout => "application.html" }
    end
  end
  
end

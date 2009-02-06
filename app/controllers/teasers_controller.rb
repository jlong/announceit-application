class TeasersController < ApplicationController
  before_filter :assign_account
  before_filter :assign_teaser
  
  def show
    render_teaser_page
  end
  
  def subscribe
    @subscriber = @teaser.subscribers.create(params[:subscriber])
    if @subscriber.new_record?
      render_teaser_page
    else
      flash[:thanks] = true
      redirect_to teaser_view_url(@account)
    end
  end
  
  private
    def assign_account
      @account = current_account || Account.find_by_subdomain(request.subdomains.first)
      head :not_found unless @account
    end
    
    def render_teaser_page
      render :template => "teasers/#{@teaser.background_color}_background.html.haml", :layout => false
    end
end
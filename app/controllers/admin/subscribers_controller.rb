module Admin
  class SubscribersController < AbstractController
    def index
      respond_to do |format|
        format.html { @subscribers = @teaser.subscribers.paginate :page => params[:page], :per_page => 25 }
        format.txt { render :text => @teaser.subscribers.collect(&:email).join(', ') }
        format.csv { @filename = 'subscribers.csv'; @subscribers = @teaser.subscribers }
      end
    end
    
    def destroy
      @teaser.subscribers.find(params[:id]).destroy
      redirect_to :action => :index
    end
  end
end
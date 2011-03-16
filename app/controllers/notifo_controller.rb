require 'notifo'

class NotifoController < ApplicationController
  def setup
    @user = current_user
  end

  def auth    
    @user = current_user
    notifo = Notifo.new NOTIFO_CONFIG[:username], NOTIFO_CONFIG[:secret]
    
    saved = @user.update_attributes(params[:user])
    auth = notifo.subscribe_user @user.notifo_username
    status = JSON.parse(auth)['status']

    respond_to do |format|
      if saved && status == 'success'
        format.html { redirect_to user_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "setup" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end

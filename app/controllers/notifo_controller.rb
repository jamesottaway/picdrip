require 'notifo'

class NotifoController < ApplicationController
  def setup
    @user = current_user
  end

  def auth    
    @user = current_user
    notifo = Notifo.new NOTIFO_CONFIG[:username], NOTIFO_CONFIG[:secret]
    
    saved = @user.update_attributes(params[:user])
    auth = JSON.parse notifo.subscribe_user(@user.notifo_username)
    success = auth['status'] == 'success'
    already_registered = auth['response_message'] == 'User is already subscribed'
    
    if already_registered
      redirect_to user_path
    elsif saved && success
      redirect_to(notifo_try_confirm_path, :notice => 'Please complete the authorisation process on your device that is connected to Notifo before continuing.')
    else
      render :action => :setup
    end
  end
  
  def try_confirm
    @user = current_user
    render "confirm"
  end
  
  def do_confirm
    @user = current_user
    notifo = Notifo.new NOTIFO_CONFIG[:username], NOTIFO_CONFIG[:secret]
    
    auth = notifo.subscribe_user @user.notifo_username
    success = JSON.parse(auth)['response_message'] == 'User is already subscribed'

    respond_to do |format|
      if success
        format.html { redirect_to user_path }
        format.xml  { head :ok }
      else
        format.html { redirect_to(notifo_try_confirm_path, :notice => "It looks like you haven't finished the authorisation process yet. Please try again.") }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end

require 'spec_helper'

describe NotifoController do
  before do
    @user = stub 'user'
    
    @controller = NotifoController.new
    
    @controller.stub!(:current_user).and_return @user
  end
  
  context '#auth' do
    before do
      @notifo = stub 'notifo'
      @auth = stub 'notifo auth'
      @auth_json = stub 'notifo auth json'
      @user_params = stub 'user params'
      
      @user.stub!(:notifo_username).and_return 'bob'
      
      Notifo.should_receive(:new).with(NOTIFO_CONFIG[:username], NOTIFO_CONFIG[:secret]).and_return @notifo
      @notifo.should_receive(:subscribe_user).with('bob').and_return @auth
      JSON.should_receive(:parse).with(@auth).and_return @auth_json
    end
    
    it 'should trigger authentication if not done so already' do
      try_confirm_path = stub 'try confirm path'
      notice = {:notice => 'Please complete the authorisation process on your device that is connected to Notifo before continuing.'}
    
      @controller.stub!(:notifo_try_confirm_path).and_return try_confirm_path
      
      @user.should_receive(:update_attributes).with(@user_params).and_return true
      @auth_json.should_receive(:[]).with('status').and_return 'success'
      @auth_json.should_receive(:[]).with('response_message').and_return 'OK'
      @controller.should_receive(:redirect_to).with try_confirm_path, notice
    
      @controller.params = {:user => @user_params}
      @controller.auth
    end

    it 'should return to setup if cannot save' do
      @user.should_receive(:update_attributes).with(@user_params).and_return false
      @auth_json.should_receive(:[]).with('status').and_return 'success'
      @auth_json.should_receive(:[]).with('response_message').and_return 'OK'
      @controller.should_receive(:render).with :action => :setup

      @controller.params = {:user => @user_params}
      @controller.auth
    end

    it 'should return to setup if auth attempt is not successful' do
      @user.should_receive(:update_attributes).with(@user_params).and_return true
      @auth_json.should_receive(:[]).with('status').and_return 'unsuccessful'
      @auth_json.should_receive(:[]).with('response_message').and_return 'OK'
      @controller.should_receive(:render).with :action => :setup

      @controller.params = {:user => @user_params}
      @controller.auth
    end
    
    it 'should redirect to the user page if already authenticated' do
      user_path = stub 'user path'
      
      @controller.stub!(:user_path).and_return user_path
      
      @user.should_receive(:update_attributes).with(@user_params).and_return true
      @auth_json.should_receive(:[]).with('status').and_return 'success'
      @auth_json.should_receive(:[]).with('response_message').and_return 'User is already subscribed'
      @controller.should_receive(:redirect_to).with user_path

      @controller.params = {:user => @user_params}
      @controller.auth
    end
  end
end

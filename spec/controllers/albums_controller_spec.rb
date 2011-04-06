require 'spec_helper'

describe AlbumsController do
  before do
    @album = stub 'album'
    
    @controller = AlbumsController.new
  end
  
  context '#create' do
    it 'should save and redirect to show' do
      album_params = 'values'
      params = {:album => album_params}
      
      Album.should_receive(:new).with(album_params).and_return @album
      @album.should_receive(:save).and_return true
      @controller.should_receive(:redirect_to).with @album, :notice => 'Album was successfully created.'
      
      @controller.params = params
      @controller.create
    end
    
    it 'should not save and return to new' do
      album_params = 'values'
      params = {:album => album_params}

      Album.should_receive(:new).with(album_params).and_return @album
      @album.should_receive(:save).and_return false
      @controller.should_receive(:render).with :action => :new

      @controller.params = params
      @controller.create
    end
  end

  context '#update' do
    it 'should update attributes and redirect to show' do
      id = 1
      album_params = 'values'
      params = {:id => id, :album => album_params}

      Album.should_receive(:find).with(id).and_return @album
      @album.should_receive(:update_attributes).with(album_params).and_return true
      @controller.should_receive(:redirect_to).with @album, :notice => 'Album was successfully updated.'

      @controller.params = params
      @controller.update
    end

    it 'should not update attributes and return to edit' do
      id = 1
      album_params = 'values'
      params = {:id => id, :album => album_params}

      Album.should_receive(:find).with(id).and_return @album
      @album.should_receive(:update_attributes).with(album_params).and_return false
      @controller.should_receive(:render).with :action => :edit

      @controller.params = params
      @controller.update
    end
  end
  
  context '#destroy' do
    it 'should destroy and redirect to index' do
      id = 1
      params = {:id => id}
      albums_path = stub 'albums path'
    
      @controller.stub!(:albums_path).and_return albums_path
    
      Album.should_receive(:find).with(id).and_return @album
      @album.should_receive(:destroy)
      @controller.should_receive(:redirect_to).with albums_path
    
      @controller.params = params
      @controller.destroy
    end
  end
end
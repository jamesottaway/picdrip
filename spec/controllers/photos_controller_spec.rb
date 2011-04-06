require 'spec_helper'

describe PhotosController do
  before do
    @photo = stub 'photo'
    @album = stub 'album'
    @album_photo_path = stub 'album photo path'
    
    @controller = PhotosController.new
    
    @controller.stub!(:album_photo_path).with(@album, @photo).and_return @album_photo_path
    
    @controller.instance_variable_set :@album, @album
  end
  
  context '#create' do
    it 'should save and redirect to show' do
      photo_params = 'values'
      params = {:photo => photo_params}
      
      Photo.should_receive(:new).with(photo_params).and_return @photo
      @photo.should_receive(:save).and_return true
      @controller.should_receive(:redirect_to).with @album_photo_path, :notice => 'Photo was successfully created.'
      
      @controller.params = params
      @controller.create
    end
    
    it 'should not save and return to new' do
      photo_params = 'values'
      params = {:photo => photo_params}

      Photo.should_receive(:new).with(photo_params).and_return @photo
      @photo.should_receive(:save).and_return false
      @controller.should_receive(:render).with :action => :new

      @controller.params = params
      @controller.create
    end
  end

  context '#update' do
    it 'should update attributes and redirect to show' do
      id = 1
      photo_params = 'values'
      params = {:id => id, :photo => photo_params}

      Photo.should_receive(:find).with(id).and_return @photo
      @photo.should_receive(:update_attributes).with(photo_params).and_return true
      @controller.should_receive(:redirect_to).with @album_photo_path, :notice => 'Photo was successfully updated.'

      @controller.params = params
      @controller.update
    end

    it 'should not update attributes and return to edit' do
      id = 1
      photo_params = 'values'
      params = {:id => id, :photo => photo_params}

      Photo.should_receive(:find).with(id).and_return @photo
      @photo.should_receive(:update_attributes).with(photo_params).and_return false
      @controller.should_receive(:render).with :action => :edit

      @controller.params = params
      @controller.update
    end
  end
  
  context '#destroy' do
    it 'should destroy and redirect to index' do
      id = 1
      params = {:id => id}
      album_photos_path = stub 'album photos path'
    
      @controller.stub!(:album_photos_path).with(@album).and_return album_photos_path
    
      Photo.should_receive(:find).with(id).and_return @photo
      @photo.should_receive(:destroy)
      @controller.should_receive(:redirect_to).with album_photos_path
    
      @controller.params = params
      @controller.destroy
    end
  end
end
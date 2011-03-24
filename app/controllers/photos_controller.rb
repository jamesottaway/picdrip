class PhotosController < ApplicationController
  load_and_authorize_resource :album
  load_and_authorize_resource :photo, :through => :album
  
  # GET /photos
  def index
  end

  # GET /photos/1
  def show
  end

  # GET /photos/new
  def new
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  def create
    if @photo.save
      redirect_to album_photo_path(@album, @photo), :notice => 'Photo was successfully created.'
    else
      render :action => "new"
    end
  end

  # PUT /photos/1
  def update
    if @photo.update_attributes(params[:photo])
      redirect_to album_photo_path(@album, @photo), :notice => 'Photo was successfully updated.'
    else
      render :action => "edit"
    end
  end

  # DELETE /photos/1
  def destroy
    @photo.destroy
    redirect_to album_photos_url(@album)
  end
end

class AlbumsController < ApplicationController
  load_and_authorize_resource
  
  # GET /albums
  def index
  end

  # GET /albums/1
  def show
    @title_prefix = @album.title
  end

  # GET /albums/new
  def new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  def create
    if @album.save
      redirect_to @album, :notice => 'Album was successfully created.'
    else
      render :action => :new
    end
  end

  # PUT /albums/1
  def update
    if @album.update_attributes(params[:album])
      redirect_to @album, :notice => 'Album was successfully updated.'
    else
      render :action => :edit
    end
  end

  # DELETE /albums/1
  def destroy
    @album.destroy
    redirect_to albums_path
  end
end

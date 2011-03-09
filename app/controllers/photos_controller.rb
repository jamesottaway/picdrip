class PhotosController < ApplicationController
  load_and_authorize_resource :album
  load_and_authorize_resource :photo, :through => :album
  
  # GET /photos
  # GET /photos.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    puts @album.inspect
    puts @photo.inspect
  end

  # POST /photos
  # POST /photos.xml
  def create
    respond_to do |format|
      if @photo.save
        format.html { redirect_to(album_photo_path(@album, @photo), :notice => 'Photo was successfully created.') }
        format.xml  { render :xml => @photo, :status => :created, :location => @photo }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /photos/1
  # PUT /photos/1.xml
  def update
    respond_to do |format|
      if @photo.update_attributes(params[:photo])
        format.html { redirect_to(album_photo_path(@album, @photo), :notice => 'Photo was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.xml
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to(album_photos_url(@album)) }
      format.xml  { head :ok }
    end
  end
end

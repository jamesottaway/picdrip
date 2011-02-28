class PhotosController < ApplicationController
  before_filter :authenticate_user!
  
  # GET /photos
  # GET /photos.xml
  def index
    @photos = Photo.for current_user

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @photos }
    end
  end

  # GET /photos/1
  # GET /photos/1.xml
  def show
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.owned_by? current_user
        format.html # show.html.erb
        format.xml  { render :xml => @photo }
      else
        render :status => :unauthorized
      end
    end
  end

  # GET /photos/new
  # GET /photos/new.xml
  def new
    @photo = Photo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @photo }
    end
  end

  # GET /photos/1/edit
  def edit
    @photo = Photo.find(params[:id])
    if @photo.not_owned_by? current_user
      render :status => :unauthorized
    end
  end

  # POST /photos
  # POST /photos.xml
  def create
    @photo = Photo.new(params[:photo])
    @photo.user = current_user

    respond_to do |format|
      if @photo.save
        format.html { redirect_to(@photo, :notice => 'Photo was successfully created.') }
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
    @photo = Photo.find(params[:id])

    respond_to do |format|
      if @photo.owned_by? current_user && @photo.update_attributes(params[:photo])
        format.html { redirect_to(@photo, :notice => 'Photo was successfully updated.') }
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
    @photo = Photo.find(params[:id])
    
    if @photo.owned_by? current_user
      @photo.destroy
      respond_to do |format|
        format.html { redirect_to(photos_url) }
        format.xml  { head :ok }
      end
    else
      render :status => :unauthorized
    end
  end
end

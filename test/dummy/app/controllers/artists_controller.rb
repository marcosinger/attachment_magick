class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end
  
  def new
    @artist = Artist.new
  end
  
  def create
    @artist = Artist.new(params[:artist])
    @artist.images.create(params[:images])
    @artist.save
    
    redirect_to artists_path
  end
  
  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    
    redirect_to artists_path
  end
end

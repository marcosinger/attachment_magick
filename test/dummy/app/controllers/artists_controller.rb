class ArtistsController < ApplicationController
  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def create
    @artist = Artist.new(params[:artist])
    @artist.save

    redirect_to edit_artist_path(@artist)
  end

  def update
    @artist = Artist.find(params[:id])
    @artist.update_attributes(params[:artist])

    redirect_to edit_artist_path(@artist)
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy

    redirect_to artists_path
  end
end

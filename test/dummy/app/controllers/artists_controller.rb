class ArtistsController < ApplicationController
  before_filter :load_artist, :only => [:edit, :update, :destroy]

  def index
    @artists = Artist.all
  end

  def new
    @artist = Artist.new
  end

  def create
    @artist = Artist.new(params[:artist])
    @artist.save

    redirect_to edit_artist_path(@artist)
  end

  def update
    @artist.update_attributes(params[:artist])
    redirect_to edit_artist_path(@artist)
  end

  def destroy
    @artist.destroy
    redirect_to artists_path
  end

  private

  def load_artist
    @artist = Artist.find(params[:id])
  end
end

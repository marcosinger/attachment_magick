class WorksController < ApplicationController
  before_filter :load_artist
  
  def index
    @works = @artist.works
  end

  def new
    @work = @artist.works.build
  end

  def edit
    @work = @artist.works.find(params[:id])
  end

  def create
    @work = @artist.works.create(params[:work])

    redirect_to edit_artist_path(@artist)
  end

  def update
    @work = @artist.works.find(params[:id])
    @work.update_attributes(params[:work])

    redirect_to edit_artist_path(@artist)
  end

  def destroy
    @artist.works.find(params[:id]).destroy

    redirect_to artists_path
  end

  private
  
  def load_artist
    @artist = Artist.find(params[:artist_id])  
  end
end

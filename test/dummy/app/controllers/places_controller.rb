class PlacesController < ApplicationController
  before_filter :load_place, :only => [:edit, :update, :destroy]

  def index
    @places = Place.all
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.new(params[:place])
    @place.save

    redirect_to edit_place_path(@place)
  end

  def update
    @place.update_attributes(params[:place])
    redirect_to edit_place_path(@place)
  end

  def destroy
    @place.destroy
    redirect_to places_path
  end

  private

  def load_place
    @place = Place.find(params[:id])
  end
end

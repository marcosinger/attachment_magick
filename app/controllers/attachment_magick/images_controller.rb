class AttachmentMagick::ImagesController < ActionController::Base
  # protect_from_forgery  :except => :create
  respond_to    :html, :js
  before_filter :load_klass

  def create
    @image = @klass.images.create(:photo => params[:Filedata], :source => params[:source], :image_type => params[:data_type])
    @klass.save

    if params[:data_partial]
      render :partial => params[:data_partial], :collection => [@image], :as => :image
    else
      render :partial => AttachmentMagick.configuration.default_add_partial, :collection => [@image], :as => :image, :locals => { :size => @klass.class.style_publisher }
    end
  end

  def update_sortable
    array_ids = params[:images]
    hash      = {}

    array_ids.each_with_index do |id, index|
      hash.merge!( {"#{index}" => {:id => "#{id}", :priority => index}} )
    end

    @klass.images_attributes = hash
    @klass.save

    render :text => "ok"
  end

  def destroy
    @klass.images.find(params[:id]).destroy
    render :text => "ok"
  end

  private

  def load_klass
    query   = ""
    objects = params[:data_attachment].split("_")
    objects = objects.in_groups_of(2)

    objects.each do |el|
      str = objects.index(el) == 0 ? "" : "."
      query << "#{str}#{el.first}.find('#{el.last}')"
    end

    @klass = eval(query)
  end
end
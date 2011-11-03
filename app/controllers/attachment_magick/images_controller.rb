class AttachmentMagick::ImagesController < ActionController::Base
  # protect_from_forgery  :except => :create
  respond_to    :html, :js
  before_filter :load_klass

  def create
    options = {
      :photo      => params[:Filedata],
      :source     => params[:source],
      :file_name  => (params[:Filedata].original_filename unless params[:source])
    }

    @image = @klass.images.create(options)
    @klass.save

    partial_options = {
      :collection => [@image],
      :as         => :image,
      :partial    => AttachmentMagick.configuration.default_add_partial
    }

    partial_options.merge!({:partial => params[:data_partial]}) if params[:data_partial].present?
    render partial_options
  end

  def update_sortable
    hsh = {}
    params[:images].each_with_index {|id, index| hsh.merge!({"#{index}" => {:id => "#{id}", :priority => index}}) }
    @klass.images_attributes = hsh
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
class Publisher::ImagesController < ActionController::Base
  protect_from_forgery  :except => :create
  respond_to            :html, :js
  
  #TODO Criar um befor_filter aqui para carregar a variavel @klass
  def create
    klass   = params[:klass].capitalize.constantize
    @klass  = klass.find(params[:klass_id])
    @image  = @klass.images.create(:photo => params[:Filedata])
    
    @klass.save
    render :partial => "layouts/publisher/images/add_image", :locals => { :image => @image, :size => @klass.grid_10 }
  end
  
  def destroy
    klass   = params[:klass].capitalize.constantize
    @klass  = klass.find(params[:klass_id])
    
    @klass.images.find(params[:id]).destroy
    render :text => "ok"
  end
end
module ApplicationHelper
  def attachment_for(klass)
    unless klass.new_record?
      images = "<div id ='attachmentSortable' class='list_images'>"

      header = %{ <div class='thumbnails grid_5 alpha'>
        <h4>Imagens</h4>
        <div id='attachmentProgressContainer' class='grid_5 alpha'></div>
        <span id='attachmentButton' class='grid_1 omega'></span>
      }

      images << "#{render :partial => "layouts/publisher/images/add_image", :collection => klass.images.order_by(:priority.asc), :as =>:image, :locals => {:size => klass.publisher}}"
      footer = %{ 
        </div>
        <input id="klass" type="hidden" value= #{klass.class.name}> <input id="klass_id" type="hidden" value= #{klass.id}>
        </div>
      }

      "#{header}#{images}#{footer}".html_safe
    end		 
  end
end

# -unless @artist.new_record?
#		.thumbnails.grid_5.alpha
#			%h4 Imagens
#			#attachmentProgressContainer.grid_5.alpha
#			%span#attachmentButton.grid_1.omega
#			
#			.list_images
#				-@artist.images.each do |image|
#					= render :partial => "layouts/publisher/images/add_image", :locals => { :image => image, :size => @artist.grid_10 }
# 
#			%input{:id => "klass",		:type => "hidden", :value => @artist.class.name}
#			%input{:id => "klass_id", :type => "hidden", :value => @artist.id}
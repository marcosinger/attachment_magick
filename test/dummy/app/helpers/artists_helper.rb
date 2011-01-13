module ArtistsHelper
  
  #FIXME Melhorar a abordagem e passar para o Publisher::ImagesHelper.attachment_for
  def attachment_for(klass)
    unless klass.new_record?
      images = []
      header = %{
                  <div class='thumbnails grid_5 alpha'>
                    <h4>Imagens</h4>
                    <div id='attachmentProgressContainer' class='grid_5 alpha'></div>
                    <span id='attachmentButton' class='grid_1 omega'></span>
          
                      <div class='list_images'>
                }
                    
      klass.images.each do |image|
        images << "#{render :partial => "layouts/publisher/images/add_image", :locals => { :image => image, :size => klass.grid_10 }}"
      end
    
      footer = %{
                <input id="klass" type="hidden" value= #{klass.class.name}>
                <input id="klass_id" type="hidden" value= #{klass.id}>
                </div></div>}
             
          "#{header}#{images}#{footer}".html_safe
    end     
  end
end

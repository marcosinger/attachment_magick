module ApplicationHelper
  def attachment_progress_container(object)
    obj = object
    key = "#{object.class.to_s.underscore}_#{object.id}"
    
    if obj.embedded?
      embedded_in = obj.relations.values.select { |x| x.macro == :embedded_in}.first
      parent      = embedded_in.class_name
      parent_id   = obj._parent.id.to_s
      inverse_of  = embedded_in.inverse_of
      text_eval   = "#{parent}_#{parent_id}_#{inverse_of}_#{obj.id.to_s}"
    end

    data_attachment = text_eval.blank? ? "#{object.class}_#{object.id}" : text_eval
    
    html  = %{<div id='attachmentProgressContainer'></div>
              <span id='attachmentButton'></span>
              <input id='attachmentmagick_key' data_attachment='#{data_attachment}' type='hidden' value='#{key}'>
            }

    html.html_safe
  end
  
  def attachment_for_view(object, &block)
    key = "#{object.class.to_s.underscore}_#{object.id}"
    
    if block_given?
      html = capture(object.images, &block)
    else
      html = render(:partial => "layouts/publisher/images/add_image", :collection => object.images.order_by(:priority.asc), :as =>:image)
    end
    
    video = %{
              <label>vídeo</label>
              <ol class='form-block'>
                #{render :partial => "layouts/publisher/images/video_upload"}
              </ol>
            }
    
    "<div id='#{key}' #{"class='attachmentSortable'" unless block_given?}>#{html}</div><div>#{video}</div>".html_safe
  end
end
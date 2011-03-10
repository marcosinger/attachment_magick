# encoding: UTF-8

module AttachmentMagick::AttachmentMagickHelper
  def attachment_progress_container(object, data_type="images")
    unless object.new_record?
      obj = object
      key = "#{object.class.to_s.underscore}_#{object.id}"

      if obj.respond_to? :embedded?
        if obj.embedded?
          embedded_in = obj.relations.values.select { |x| x.macro == :embedded_in}.first
          parent      = embedded_in.class_name
          parent_id   = obj._parent.id.to_s
          inverse_of  = embedded_in.inverse_of
          text_eval   = "#{parent}_#{parent_id}_#{inverse_of}_#{obj.id.to_s}"
        end
      end

      data_attachment = text_eval.blank? ? "#{object.class}_#{object.id}" : text_eval

      html  = %{<div id='attachmentProgressContainer'></div>
                <span id='attachmentButton'></span>
                <input id='attachmentmagick_key' data_attachment='#{data_attachment}' data_type='#{data_type}' type='hidden' value='#{key}'>
              }

      html.html_safe
    end
  end

  def attachment_for_view(object, partial = nil, collection=nil, use_video=true, use_sortable=true)
    unless object.new_record?
      unless collection.present?
        if object.class.include?(Mongoid::Document)
          collection  = object.images.order_by(:priority.asc)
        end

        if object.class.include?(ActiveRecord::Persistence)
          collection  = object.images.order(:priority)
        end
      end

      key           = "#{object.class.to_s.underscore}_#{object.id}"
      video         = %{<label>vídeo</label><ol class='form-block'>#{render :partial => "layouts/attachment_magick/images/video_upload"}</ol>} if use_video
      html_partial  = "<input id='attachmentmagick_partial' data-partial='#{partial}' type='hidden' value='#{key}'>" if partial
      html          = render(:partial => partial || "layouts/attachment_magick/images/add_image", :collection => collection, :as =>:image)

      "#{html_partial}<div id='#{key}' class='attachment_magick_image #{'attachmentSortable' if use_sortable}'>#{html}</div><div>#{video}</div>".html_safe
    end
  end
end

# encoding: UTF-8

module AttachmentMagick::AttachmentMagickHelper
  def attachment_progress_container(object, data_type="images")
    unless object.new_record?
      obj = object
      key = "#{object.class.to_s.underscore}_#{object.id}"

      if obj.respond_to?(:embedded?)
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

  def attachment_for_view(object, partial = nil, collection=nil, use_sortable=true)
    unless object.new_record?
      unless collection.present?
        if AttachmentMagick.configuration.orms.include?("Mongoid")
          if object.class.include?(Mongoid::Document)
            collection  = object.images.order_by(:priority.asc)
          end
        end

        if AttachmentMagick.configuration.orms.include?("ActiveRecord")
          if object.class.include?(ActiveRecord::Persistence)
            collection  = object.images.order(:priority)
          end
        end
      end

      key           = "#{object.class.to_s.underscore}_#{object.id}"
      html_partial  = "<input id='attachmentmagick_partial' data-partial='#{partial}' type='hidden' value='#{key}'>" if partial
      html          = render(:partial => partial || AttachmentMagick.configuration.default_add_partial, :collection => collection, :as =>:image)

      "#{html_partial}<div id='#{key}' class='#{'attachmentSortable' if use_sortable}'>#{html}</div><div></div>".html_safe
    end
  end

  def attachment_for_video(object)
    %{<label>vídeo</label><ol class='form-block'>#{render :partial => "/attachment_magick/video_upload"}</ol>}.html_safe unless object.new_record?
  end

  #FIXME - verify this html
  def attachment_for_flash(url, width=100, height=60)
    "<object classid='clsid:d27cdb6e-ae6d-11cf-96b8-444553540000' width='#{width}' height='#{height}' id='#{url}' align='middle'>
      <param name='movie' value='#{url}' />
      <param name='quality' value='high' />
      <param name='bgcolor' value='#FFF' />
      <param name='play' value='true' />
      <param name='loop' value='true' />
      <param name='wmode' value='window' />
      <param name='scale' value='showall' />
      <param name='menu' value='true' />
      <param name='devicefont' value='false' />
      <param name='salign' value='' />
      <param name='allowScriptAccess' value='sameDomain' />
      <!--[if !IE]>-->
      <object type='application/x-shockwave-flash' data='#{url}' width='#{width}' height='#{height}'>
        <param name='movie' value='#{url}' />
        <param name='quality' value='high' />
        <param name='bgcolor' value='#FFF' />
        <param name='play' value='true' />
        <param name='loop' value='true' />
        <param name='wmode' value='window' />
        <param name='scale' value='showall' />
        <param name='menu' value='true' />
        <param name='devicefont' value='false' />
        <param name='salign' value='' />
        <param name='allowScriptAccess' value='sameDomain' />
      <!--<![endif]-->
        <a href='http://www.adobe.com/go/getflash'>
          <img src='http://www.adobe.com/images/shared/download_buttons/get_flash_player.gif' alt='Get Adobe Flash player' />
        </a>
      <!--[if !IE]>-->
      </object>
      <!--<![endif]-->
    </object>".html_safe
  end
end

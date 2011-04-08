module AttachmentMagick
  class MongoidImage
    include Mongoid::Document
    include AutoHtml
    include AutoHtmlFor

    before_create :set_content_type

    attr_accessor :file_name

    field           :photo_uid
    field           :caption
    field           :priority
    field           :source
    field           :content_type
    image_accessor  :photo
    embedded_in     :imageable, :inverse_of => :image

    auto_html_for :source => "_to_html" do
      youtube(:width => 620, :height => 465)
      vimeo(:width => 620, :height => 465)
    end

    auto_html_for :source => "_to_image" do
      youtube_image
      vimeo_image(:size => :large)
    end

    def imageable
      self._parent
    end

    #FIXME - find a better way to compare
    def is_flash?
      if self.content_type =~ /flash/
        true
      else
        false
      end
    end

    private
    def set_content_type
      require "mime/types"
      self.content_type = MIME::Types.type_for(self.file_name.to_s).to_s
    end
  end
end
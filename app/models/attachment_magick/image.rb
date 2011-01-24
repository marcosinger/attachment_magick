module AttachmentMagick
  class Image
    include Mongoid::Document
    include AutoHtml
    include AutoHtmlFor

    field           :photo_uid
    field           :caption
    field           :priority
    field           :source
    image_accessor  :photo
    embedded_in     :imageable, :inverse_of => :image

    auto_html_for :source => "_to_html" do
      vimeo(:width => 620, :height => 465)
    end

    auto_html_for :source => "_to_image" do
      vimeo_image(:size => :large)
    end
  end
end
module AttachmentMagick
  class ActiveRecordImage < ActiveRecord::Base
    set_table_name "amagick_images"

    include AutoHtml
    include AutoHtmlFor

    belongs_to      :imageable, :polymorphic => true
    image_accessor  :photo

    auto_html_for :source => "_to_html" do
      vimeo(:width => 620, :height => 465)
    end

    auto_html_for :source => "_to_image" do
      vimeo_image(:size => :large)
    end
  end
end

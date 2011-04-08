module AttachmentMagick
  class ActiveRecordImage < ActiveRecord::Base
    set_table_name "amagick_images"

    belongs_to      :imageable, :polymorphic => true
    image_accessor  :photo

    attr_accessor :file_name #not implemented yet

    auto_html_for :source => "_to_html" do
      youtube(:width => 620, :height => 465)
      vimeo(:width => 620, :height => 465)
    end

    auto_html_for :source => "_to_image" do
      youtube_image
      vimeo_image(:size => :large)
    end

    #not implemented yet
    def is_flash?
      false
    end

  end if defined? ActiveRecord::Persistence
end

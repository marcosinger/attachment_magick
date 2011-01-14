module AttachmentMagick
  class Image
    include Mongoid::Document

    field           :photo_uid
    field           :caption
    field           :priority, :type => Integer
    image_accessor  :photo
    embedded_in     :imageable, :inverse_of => :image
  end
end
class Work
  include Mongoid::Document
  extend AttachmentMagick
  
  field       :name
  field       :local
  embedded_in :artist, :inverse_of => :works
  
  attachment_magick do
    publisher
  end
end

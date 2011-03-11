class Work
  include Mongoid::Document
  include AttachmentMagick

  field       :name
  field       :local
  embedded_in :artist, :inverse_of => :works

  attachment_magick do
    grid_5
    publisher
  end
end

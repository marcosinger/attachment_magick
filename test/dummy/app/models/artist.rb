class Artist
  include Mongoid::Document
  extend AttachmentMagick
  
  field :name
  field :lastname
  
  attachment_magick do
    grid_1
    grid_10 :width => 150
  end
end

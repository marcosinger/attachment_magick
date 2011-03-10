class Place < ActiveRecord::Base
  extend AttachmentMagick

  attachment_magick do
    grid_3
    publisher
  end
end

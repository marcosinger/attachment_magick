class Place < ActiveRecord::Base
  include AttachmentMagick

  attachment_magick do
    grid_3
    publisher
  end
end

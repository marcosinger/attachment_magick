class Image
  include Mongoid::Document

  field           :photo_uid
  image_accessor  :photo
  embedded_in     :imageable, :inverse_of => :image
end

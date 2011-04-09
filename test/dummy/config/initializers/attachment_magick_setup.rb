AttachmentMagick.setup do |config|
  config.columns_amount       = 19
  config.columns_width        = 54
  config.gutter               = 3

  config.custom_styles do
    thumb       "36x36"
    portrait    "x700>"
    fullscreen  :width => 1024
    publisher   "54x"
  end
end
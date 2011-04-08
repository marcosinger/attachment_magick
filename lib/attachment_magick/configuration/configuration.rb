require "attachment_magick/configuration/custom_style"

module AttachmentMagick
  class Configuration

    attr_accessor :columns_amount
    attr_accessor :columns_width
    attr_accessor :gutter
    attr_accessor :default_add_partial

    def initialize
      @columns_amount         = 19
      @columns_width          = 54
      @gutter                 = 3
      @custom_styles          = []
      @default_add_partial    = "/attachment_magick/add_image"
    end

    def custom_styles(&block)
      if block_given?
        @custom_styles = CustomStyle.new
        @custom_styles.instance_eval(&block)
      else
        return @custom_styles
      end
    end
  end
end
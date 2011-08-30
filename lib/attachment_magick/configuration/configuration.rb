require "attachment_magick/configuration/custom_style"
require 'css_parser'

module AttachmentMagick
  class Configuration
    include CssParser

    attr_accessor :columns_amount
    attr_accessor :columns_width
    attr_accessor :gutter
    attr_accessor :default_add_partial
    attr_accessor :orms

    def initialize
      @columns_amount         = 19
      @columns_width          = 54
      @gutter                 = 3
      @custom_styles          = []
      @orms                   = ["Mongoid"]
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

    def parse_stylesheet(stylesheet)
      return if stylesheet.blank?

      stylesheet_file = Dir.glob(File.join(Rails.root, "public", "**", "#{stylesheet}")).first
      parser          = CssParser::Parser.new

      if stylesheet_file
        parser.load_uri!(stylesheet_file)

        all_containers  = parser.find_by_selector(/\.container/).keys
        container       = all_containers.first
        container_width = parser.find_by_selector(/\.container/)[container]["width"].to_i
        grid_1          = parser.find_by_selector(/\b(grid_1)\b/).values
        grid_1_width    = grid_1.detect{|attr| attr["width"]}["width"].to_i
        gutter          = grid_1.map{|attr| attr.values_at('margin-left')}.flatten.compact.join.to_i

        @columns_width  = grid_1_width
        @gutter         = gutter
        @columns_amount = container_width/(@columns_width+@gutter*2)
      end
    end
  end
end
require "attachment_magick/configuration/configuration"
require "attachment_magick/dragonfly/dragonfly_mongo"
require "attachment_magick/dsl"
require 'attachment_magick/railtie'

module AttachmentMagick
  attr_accessor :attachment_magick_default_options
  attr_accessor :attachment_default_view

  class << self
    attr_accessor :configuration
  end

  def self.setup
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  def attachment_magick(&block)
    embeds_many                   :images, :class_name => "AttachmentMagick::Image", :polymorphic => true
    accepts_nested_attributes_for :images

    default_grids = generate_grids
    map           = DSL.new(self, default_grids)
    map.instance_eval(&block)

    @attachment_magick_default_options = {:styles => map.styles || default_grids}
    grid_methods
  end

  def generate_grids(column_amount=AttachmentMagick.configuration.columns_amount, column_width=AttachmentMagick.configuration.columns_width, gutter=AttachmentMagick.configuration.gutter, only=[])
    hash = {}
    grids_to_create = only.empty? ? 1.upto(column_amount) : only

    grids_to_create.each do |key|
      grid  = ("grid_#{key}").to_sym
      value = (key * column_width) + (gutter * (key - 1))
      hash.merge!({grid => {:width => value}})
    end

    unless AttachmentMagick.configuration.custom_styles.styles.empty?
      AttachmentMagick.configuration.custom_styles.styles.each do |key, value|
        option = value
        if value.is_a?(String)
          width, height = value.split("x")
          option        = {:width => width.to_i}
          option.merge!({:height => height.to_i}) if height
        end

        hash.merge!({key.to_sym => option})
      end
    end

    return hash
  end

  def grid_methods
    @attachment_magick_default_options[:styles].each do |key, value|
      self.send :define_singleton_method, "style_#{key.to_s}" do
        metric = "#{value[:width]}x#{value[:height]}"
        metric = "#{metric}#" if value[:height] && value[:crop] == true

        return metric
      end
    end
  end

  private :generate_grids
  private :grid_methods
end
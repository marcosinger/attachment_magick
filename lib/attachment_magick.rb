module AttachmentMagick
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def has_attachment_magick(*styles)
      #include InstanceMethods
      styles_for_me = ( styles.size == 0 ? nil : {})
      grids         = generate_grids
      
      #FIXME Não gosto de CASE e a abordagem é fraca. Mudar isso..
      styles.each do |style|        
        case style.class.name
          when "Hash"
            style.each do |key, value|  
              styles_for_me.merge!({ key => grids[key].merge!(value) })
            end
          when "Symbol"
            styles_for_me.merge!({ style => grids[style] })
        end
      end
      
      write_inheritable_attribute(:attachment_magick_default_options, {:styles => styles_for_me || grids})      
    end
    
    def attachment_magick_default_options
      read_inheritable_attribute(:attachment_magick_default_options)
    end
    
    #FIXME Passar os valores default para um arquivo de setup
    def generate_grids(column_amount=19, column_width=54, gutter=0, only=[])
      hash = {}
      grids_to_create = only.empty? ? 1.upto(column_amount) : only

      grids_to_create.each do |key|
        grid  = ("grid_"+key.to_s).to_sym
        value = (key*column_width)+(gutter*(key-1))
        
        hash.merge!( {grid => {:width => value}} )
      end

      hash
    end
  end
  
  # module InstanceMethods
  #   def generate_styles
  #     require 'RMagick'
  # 
  #     original_image  = self.img.path(:original)
  #     klass           = self.imageable.class.name.downcase
  # 
  #     return false if original_image.nil? || !File.exists?(original_image)
  # 
  #     Image.styles_for(klass).each do |key, value|
  #       new_image     = Magick::ImageList.new(original_image)
  #       width         = value[:width]  || ""
  #       height        = value[:height] || "" 
  #       geometry_size = "#{width}x#{height}"
  # 
  #       height.blank? ? new_image.change_geometry!(geometry_size) { |cols, rows, img| img.resize!(cols, rows) } : new_image.resize_to_fill!(width, height)
  # 
  #       new_height  = new_image.rows
  #       new_width   = new_image.columns
  #       rest        = new_height % BASELINE
  # 
  #       new_image.crop!(0, rest/2.0, new_width, new_height-rest)
  #       new_image.write(File.join(File.dirname(original_image), "#{project_name}-#{key}"+File.extname(original_image)))
  #     end
  #     true
  #   end
  # end
end
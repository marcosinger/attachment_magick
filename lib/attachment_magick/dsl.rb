module AttachmentMagick
  class DSL
    attr_reader :styles
    
    def initialize(set, default_grids)
      @set    = set
      @styles = {}
      @default_grids = default_grids
    end

    def generate_grids(column_amount=19, column_width=54, gutter=0, only=[])
      hash = {}
      grids_to_create = only.empty? ? 1.upto(column_amount) : only

      grids_to_create.each do |key|
        grid  = ("grid_" + key.to_s).to_sym
        value = (key*column_width)+(gutter*(key-1))

        hash.merge!( {grid => {:width => value}} )
      end

      hash
    end

    def method_missing(name, *params, &blk)
      options = params.first
      
      if options.nil?
        options = @default_grids[name.to_sym]
      elsif options.is_a?(String)
        values = options.split('x')
        
        options = {}
        options.merge!(:width => values.first.to_i) if values.first
        options.merge!(:height => values.last.to_i) if values.last

        options = @default_grids[name.to_sym].merge(options)
      elsif options.is_a?(Hash)
        options = @default_grids[name.to_sym].merge(options)
      end
      
      @styles.merge!(name.to_sym => options)
    end
  end
end
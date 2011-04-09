module AttachmentMagick
  class DSL
    attr_reader :styles
    attr_reader :default_options

    def initialize(set, default_grids)
      @set    = set
      @styles = {}
      @default_grids = default_grids
    end

    def method_missing(name, *params, &blk)
      options = params.first

      if options.nil?
        options = @default_grids[name.to_sym]
      elsif options.is_a?(String)
        values = options.split('x')

        options = {}
        options.merge!(:width   => values.first.to_i) if values.first
        options.merge!(:height  => values.last.to_i)  if values.second
        options.merge!(:ajust   => values.second.match(/\W/).to_s) unless values.second.match(/\W/).to_s.blank? if values.second

        options = @default_grids[name.to_sym].merge(options)
      elsif options.is_a?(Hash)
        options = @default_grids[name.to_sym].merge(options)
      end

      @styles.merge!(name.to_sym => options)
    end

    def styles
      @styles.empty? ? nil : @styles
    end
  end
end
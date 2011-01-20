module AttachmentMagick
  class CustomStyle
    
    def method_missing(meth, *args, &blk)
      instance_variable_set "@#{meth}", args.first
      self.class.class_eval { attr_reader meth.to_sym }
    end
    
    def styles
      hash = {}
      instance_variables.each do |method|
        method = method.to_s.gsub("@", "")
        hash.merge!({ method.to_sym => send(method) })
      end
      
      return hash
    end
  end
end

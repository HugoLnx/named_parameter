module NamedParameter
  module NamedAbove
  private
    def above_named
      @named_above = true
    end

    def self.above_singleton_named(klass)
      klass.instance_variable_set(:@named_above, true)
    end

    def above_method_added(name)
      if @named_above
        @named_above = false
        method = self.instance_method name
        NamedMethodTransmuter.transmute method
      end
    end

    def above_singleton_method_added(name)
      if @named_above
        @named_above = false
        method = self.method name
        NamedMethodTransmuter.transmute method
      end
    end
  end
end

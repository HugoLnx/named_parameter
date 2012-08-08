module NamedParameter
  module NamedInline
  private
    def inline_named
      NamedMethodTransmuter.transmute @last_method_added
    end

    def self.inline_singleton_named(klass)
      method = klass.instance_variable_get(:@last_method_added)
      NamedMethodTransmuter.transmute method
    end

    def inline_method_added(name)
      @last_method_added = self.instance_method name
    end

    def inline_singleton_method_added(name)
      @last_method_added = self.method name
    end
  end
end

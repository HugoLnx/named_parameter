module NamedParameter
  def named(above=true)
    if above
      @become_named = true
    else
      method = @last_method_added
      NamedParameter::NamedMethodTransmuter.transmute method
    end
  end

  def self.extended(klass)
    klass.singleton_class.instance_eval do
      define_singleton_method :named do |above=true|
        if above
          klass.instance_variable_set(:@become_named, true)
        else
          method = klass.instance_variable_get(:@last_method_added)
          NamedParameter::NamedMethodTransmuter.transmute method
        end
      end
    end
  end

  def method_added(method_name)
    @last_method_added = self.instance_method(method_name)
    if @become_named
      @become_named = false
      method = @last_method_added
      NamedParameter::NamedMethodTransmuter.transmute method
    end
  end


  def singleton_method_added(method_name)
    @last_method_added = self.method(method_name)
    if @become_named
      @become_named = false
      method = @last_method_added
      NamedParameter::NamedMethodTransmuter.transmute method
    end
  end
end

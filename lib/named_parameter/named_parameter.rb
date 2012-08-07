module NamedParameter
  def named(def_return)
    method = @last_method_added
    NamedParameter::NamedMethodTransmuter.transmute method
  end

  def self.extended(klass)
    klass.singleton_class.instance_eval do
      define_singleton_method :named do |def_return|
        method = klass.instance_variable_get(:@last_method_added)
        NamedParameter::NamedMethodTransmuter.transmute method
      end
    end
  end

  def method_added(method_name)
    @last_method_added = self.instance_method(method_name)
  end


  def singleton_method_added(method_name)
    @last_method_added = self.method(method_name)
  end
end

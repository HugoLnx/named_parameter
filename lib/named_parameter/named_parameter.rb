module NamedParameter
  def named(def_return)
    method = @last_method_added
    NamedParameter::NamedMethodTransmuter.transmute method
  end

  def method_added(method_name)
    @last_method_added = self.instance_method(method_name)
  end


  def singleton_method_added(method_name)
    @last_method_added = self.method(method_name)
  end
end

module NamedParameter
  def named(def_return)
    method = self.instance_method(@last_method_added)
    NamedParameter::NamedMethodTransmuter.transmute method
  end

  def method_added(method_name)
    @last_method_added = method_name
  end
end

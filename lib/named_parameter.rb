require 'named_parameter/named_method'
require 'named_parameter/named_method_transmuter'
require 'named_parameter/errors'
require 'named_parameter/error'

class Module
  def named(def_return)
    method = self.instance_method(@last_method_added)
    NamedMethodTransmuter.transmute method
  end

  def method_added(method_name)
    @last_method_added = method_name
  end
end

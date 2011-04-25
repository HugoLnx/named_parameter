require 'named_parameter/named_method'
require 'named_parameter/named_method_transmuter'

class Class
  def named
    @naming = true
  end

  def method_added(method_name)
    return unless @naming
    @naming = false
    method = self.instance_method(method_name)
		NamedMethodTransmuter.transmute method
    @naming = true
  end
end

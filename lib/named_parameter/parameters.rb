class Parameters
  include Enumerable

  attr_reader :entries

  def initialize(parameters_array)
    @entries = parameters_array.collect do |parameter_array| 
      Parameter.new parameter_array
    end
  end

  def each(&block)
    @entries.each(&block)
  end
end

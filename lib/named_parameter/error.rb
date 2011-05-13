module NamedParameter
  class Error
    attr_reader :named_method
    attr_reader :argument_name
    attr_reader :backtrace

    def initialize(named_method,argument_name,full_backtrace)
      @named_method = named_method
      @argument_name = argument_name
      @backtrace = clean_backtrace(full_backtrace)
    end

  private

    def clean_backtrace(backtrace)
      backtrace[2..-1]
    end
  end
end

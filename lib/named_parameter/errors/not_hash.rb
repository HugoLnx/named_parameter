module NamedParameter::Errors
  class NotHash
    def self.all_when(named_method,options)
      args = options[:called_with]
      if args.is_a? Hash
        []
      else
        error = NamedParameter::Error.new(named_method,args,caller)
        [NotHash.new(error)]
      end
    end

    def initialize(error)
      @error = error
    end

    def raise_args
      [error_message,@error.backtrace]
    end

  private
    def error_message
      msg = "expected a Hash but #{@error.argument_name.inspect} received by named method '#{@error.named_method.method.name}'"
      p msg
      msg
    end
  end
end

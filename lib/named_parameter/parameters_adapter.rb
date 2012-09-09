module NamedParameter
  class ParametersAdapter
    NO_ARGUMENT = Object.new

    attr_reader :method

    def initialize(method)
      @method = method
    end

    def hash_to_args(options)
      original_parameters = []
      @method.parameters.each_with_index do |parameter, i|
        parameter_name = parameter.last
        if options.has_key? parameter_name
          original_parameters << options[parameter_name]
        else
          original_parameters << NO_ARGUMENT
        end
      end

      arguments = fill_no_arguments(original_parameters)

      return arguments
    end

    def fill_no_arguments(arguments)
      while arguments.last.equal? NO_ARGUMENT
        last_index = arguments.size - 1
        arguments.delete_at last_index
      end

      if arguments.any?{|arg| arg.equal? NO_ARGUMENT}
        filepath = @method.source_location[0]
        linenumber = @method.source_location[1]

        content = File.read(filepath).split("\n")[(linenumber-1)..-1].join.strip
        
        default_values = extract_default_values content

        arguments.map!.with_index do |arg, i|
          no_argument = arg.equal? NO_ARGUMENT
          no_argument ? default_values[i] : arg
        end
      end

      return arguments
    end

    def extract_default_values(file_fragment)
      match = file_fragment.match /^[^\(]*\(([^\)]*)\)/
      args_fragment = match[1]
      args_fragments = extract_args_fragments args_fragment
      default_values = args_fragments.map{|frag| eval(frag.gsub(/^[^=]*(=|$)/, ""))}
      return default_values
    end

    def extract_args_fragments(fragment)
      base_frags = fragment.split ","
      frags = []
      i = 0
      while i < base_frags.size
        frag = base_frags[i]
        while inconsistent_fragment?(frag)
          i += 1
          frag += ",#{base_frags[i]}"
        end
        frags << frag
        i += 1;
      end
      return frags
    end

    def inconsistent_fragment?(fragment)
      return fragment.count("([{") != fragment.count(")]}") ||
             fragment.count(%q{"'/}).odd?
    end
  end
end

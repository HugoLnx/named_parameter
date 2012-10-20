module NamedParameter
  module DefaultsExtractor
    class DefaultParametersExtractor
      def defaults_of(method)
        filepath = method.source_location[0]
        linenumber = method.source_location[1]

        if filepath.downcase == "(irb)"
            msg = NamedParameter::Errors::OnIrbException::MESSAGE
            raise NamedParameter::Errors::OnIrbException, msg
        end

        rb_content = File.read(filepath)

        extractor = SignatureExtractor.new
        signature = extractor.signature_of(rb_content, linenumber);

        created_method = method_with_signature(signature, method)

        defaults = call_with_required_params(created_method)

        defaults
      end

      def method_with_signature(signature, original)
        argnames = original.parameters.map{|(_, name)| name}
        method_code = "#{signature}; return [#{argnames.join(",")}];end"
        eval(method_code)

        method(original.name)
      end

      def call_with_required_params(method)
        required = method.parameters
          .find_all{|(tag, _)| tag == :req}
          .map{|(_, name)| name}

        args = [nil] * required.size
        method.call(*args)
      end
    end
  end
end

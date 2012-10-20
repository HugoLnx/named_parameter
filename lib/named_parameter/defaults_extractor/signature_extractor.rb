module NamedParameter
  module DefaultsExtractor
    class SignatureExtractor
      module EndLineValidators
        WITH_PARENTESIS = lambda{|line| line.strip.end_with?(")")}
        WITHOUT_PARENTESIS = lambda{|line| !line.strip.end_with?(",")}
      end

      def signature_of(content, linenumber)
        content = extract_until_signature_starts(content, linenumber)

        signature_end = find_signature_end content

        signature = content[0..signature_end].split("\n").map{|line| line.strip}.join

        signature
      end

      def extract_until_signature_starts(content, linenumber)
        content
          .split("\n")[(linenumber-1)..-1]
          .join("\n")
          .gsub(";", "\n")
          .strip
          .reverse.gsub(/ fed.*$/, " fed").reverse
      end

      def find_signature_end(signature)
        if signature =~ /^def +[A-Za-z_\?]+ *\(/
          sign_end_validator = EndLineValidators::WITH_PARENTESIS
        else
          sign_end_validator = EndLineValidators::WITHOUT_PARENTESIS
        end

        lines = signature.split("\n")
        sign_end = 0
        i = 0
        until sign_end_validator.call(lines[i])
          sign_end += lines[i].size + 1
          i += 1
        end
        sign_end += lines[i].size

        sign_end
      end
    end
  end
end

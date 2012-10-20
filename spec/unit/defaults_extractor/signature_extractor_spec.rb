require 'spec_helper'

module NamedParameter
  module DefaultsExtractor
    describe SignatureExtractor  do
      it 'extract for parameters with simple strings as defaults' do
        code =
        %q{class Teste
            def sample(a="a", b="b", c)
            end
          end}

        extractor = SignatureExtractor.new
        signature = extractor.signature_of(code, 2)

        signature.should == %q{def sample(a="a", b="b", c)}
      end

      it 'extract from no parentesis methods' do
        code =
        %q{class Teste
            def sample a="a", b="b", c
            end
          end}

        extractor = SignatureExtractor.new
        signature = extractor.signature_of(code, 2)

        signature.should == %q{def sample a="a", b="b", c}
      end

      it 'extract from methods with more than one line' do
        code =
        %q{class Teste
            def sample a="a",
              b="b",
              c
            end
          end}

        extractor = SignatureExtractor.new
        signature = extractor.signature_of(code, 2)

        signature.should == %q{def sample a="a",b="b",c}
      end

      it 'extract from methods with more than one line and parentesis' do
        code =
        %q{class Teste
            def sample(a="a",
              b="b",
              c
              )
            end
          end}

        extractor = SignatureExtractor.new
        signature = extractor.signature_of(code, 2)

        signature.should == %q{def sample(a="a",b="b",c)}
      end

      it 'extract from methods with something before def' do
        code =
        %q{class Teste
            named def sample(a="a",
              b="b",
              c
              )
            end
          end}

        extractor = SignatureExtractor.new
        signature = extractor.signature_of(code, 2)

        signature.should == %q{def sample(a="a",b="b",c)}
      end


      it 'can have an "def" in the middle of the signature' do
        code =
        %q{class Teste
            def sample(arg="default");end
          end}

        extractor = SignatureExtractor.new
        signature = extractor.signature_of(code, 2)

        signature.should == %q{def sample(arg="default")}
      end
    end
  end
end

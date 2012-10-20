require 'spec_helper'

module NamedParameter
  module DefaultsExtractor
    describe DefaultParametersExtractor do
      it 'extract for parameters with one required at right' do
        def sample(a="a", b="b", c)
        end

        extractor = DefaultParametersExtractor.new
        defaults = extractor.defaults_of(method(:sample))

        defaults.should == ["a", "b", nil]
      end

      it 'extract for parameters with ;' do
        def sample(a="a", b="b", c, d);end

        extractor = DefaultParametersExtractor.new
        defaults = extractor.defaults_of(method(:sample))

        defaults.should == ["a", "b", nil, nil]
      end

      it 'extract from 2 required at left' do
        def sample(a,b,c="c", d="d",e="e",f="f");end

        extractor = DefaultParametersExtractor.new
        defaults = extractor.defaults_of(method(:sample))

        defaults.should == [nil, nil, "c", "d", "e", "f"]
      end
    end
  end
end

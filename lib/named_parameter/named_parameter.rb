module NamedParameter
  include NamedAbove
  include NamedInline

  def named(above=true)
    if above
      above_named
    else
      inline_named
    end
  end

  def self.extended(klass)
    def_singleton_named(klass) do |above|
      if above
        NamedAbove.above_singleton_named(klass)
      else
        NamedInline.inline_singleton_named(klass)
      end
    end
  end

  def method_added(name)
    inline_method_added name
    above_method_added name
  end


  def singleton_method_added(name)
    inline_singleton_method_added name
    above_singleton_method_added name
  end

private
  def self.def_singleton_named(klass, &block)
    klass.singleton_class.instance_eval do
      define_singleton_method :named do |above=true|
        block.call(above)
      end
    end
  end
end

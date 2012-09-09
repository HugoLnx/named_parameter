module NamedParameter::Errors
  class OnIrbException < Exception
    MESSAGE = %q{This specific parameters don't work on IRB, just with ".rb" files.}
  end
end

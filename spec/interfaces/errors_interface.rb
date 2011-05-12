specify ".new(error)" do
  described_class.should respond_to(:new)
                        .with(1)
end

specify ".match?(method,arg)" do
  described_class.should respond_to(:match?)
                        .with(2)
end

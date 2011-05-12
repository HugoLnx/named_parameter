here = File.dirname(__FILE__)

interfaces_paths = Dir[File.join(here,'../interfaces/*_interface.rb')]

interfaces_paths.each do |interface_path|
  interface_filename = File.basename(interface_path)[/^[^.]+/]
  method_name = "respect_#{interface_filename}"
  context_description = method_name.gsub(/_./){|a| a.sub('_',' ').upcase}

  RSpec::Core::ExampleGroup.singleton_class.instance_eval do
    define_method method_name do
      context context_description  do
        eval File.read(interface_path)
      end
    end
  end
end

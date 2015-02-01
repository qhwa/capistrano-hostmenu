require "bundler/gem_tasks"
require 'rspec/core/rake_task'
require 'yard'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec


# Generate documentation
YARD::Rake::YardocTask.new(:doc) do |t|
  #t.files   = %w{lib/hsf.rb}
end

## Developping tasks
require "rake/extensiontask"

# `rake compile` to compile
Rake::ExtensionTask.new "hsf" do |ext|
  ext.name = "hsf_cpp"
end

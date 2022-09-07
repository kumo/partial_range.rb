require 'rake'
require 'rake/testtask'
# require 'rdoc/task'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the partial_range plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.pattern = 'test/**/test_*.rb'
  t.verbose = true
end

# desc 'Generate documentation for the partial_range plugin.'
# Rake::RDocTask.new(:rdoc) do |rdoc|
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title    = 'PartialRange'
#   rdoc.options << '--line-numbers' << '--inline-source'
#   rdoc.rdoc_files.include('README')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end

desc "Open an irb session preloaded with this library"
task :console do
  sh "irb -rubygems -r ./lib/partial_range.rb"
end

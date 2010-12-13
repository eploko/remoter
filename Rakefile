require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "remoter"
    gem.summary = %Q{Run commands on multiple remote machines over SSH easily.}
    gem.description = %Q{A tool to simplify executing of shell command on several remote machines over SSH.}
    gem.email = "andrey@subbotin.me"
    gem.homepage = "http://github.com/eploko/remoter"
    gem.authors = ["Andrey Subbotin"]
    gem.executables = ['remoter']
    gem.default_executable = ['remoter']    
    gem.add_dependency "term-ansicolor"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end
# encoding: utf-8

require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  require './lib/remoter/version.rb'
  Jeweler::Tasks.new do |gem|
    gem.name = "remoter"
    gem.version = Remoter::Version::STRING
    gem.summary = %Q{Run commands on multiple remote machines over SSH easily.}
    gem.description = %Q{A tool to simplify executing of shell command on several remote machines over SSH.}
    gem.email = "andrey@subbotin.me"
    gem.homepage = "http://github.com/eploko/remoter"
    gem.authors = ["Andrey Subbotin"]
    gem.executables = []
    gem.default_executable = []    
    gem.files =  FileList["[A-Z][A-Z]*", "lib/**/*"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

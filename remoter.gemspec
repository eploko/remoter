# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{remoter}
  s.version = "1.0.0.pre1"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1") if s.respond_to? :required_rubygems_version=
  s.authors = ["Andrey Subbotin"]
  s.date = %q{2010-12-13}
  s.default_executable = []
  s.description = %q{A tool to simplify executing of shell command on several remote machines over SSH.}
  s.email = %q{andrey@subbotin.me}
  s.extra_rdoc_files = [
    "LICENSE",
    "README.rdoc"
  ]
  s.files = [
    "LICENSE",
    "README.rdoc",
    "lib/remoter.rb",
    "lib/remoter/base.rb",
    "lib/remoter/ui.rb",
    "lib/remoter/version.rb"
  ]
  s.homepage = %q{http://github.com/eploko/remoter}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Run commands on multiple remote machines over SSH easily.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nmap-parser>, [">= 0"])
      s.add_runtime_dependency(%q<thor>, [">= 0"])
    else
      s.add_dependency(%q<nmap-parser>, [">= 0"])
      s.add_dependency(%q<thor>, [">= 0"])
    end
  else
    s.add_dependency(%q<nmap-parser>, [">= 0"])
    s.add_dependency(%q<thor>, [">= 0"])
  end
end


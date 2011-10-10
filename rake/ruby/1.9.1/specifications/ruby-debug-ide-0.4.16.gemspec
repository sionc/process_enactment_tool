# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "ruby-debug-ide"
  s.version = "0.4.16"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Markus Barchfeld, Martin Krauskopf, Mark Moseley, JetBrains RubyMine Team"]
  s.date = "2010-11-28"
  s.description = "An interface which glues ruby-debug to IDEs like Eclipse (RDT), NetBeans and RubyMine.\n"
  s.email = "rubymine-feedback@jetbrains.com"
  s.executables = ["rdebug-ide"]
  s.extensions = ["ext/mkrf_conf.rb"]
  s.files = ["bin/rdebug-ide", "ext/mkrf_conf.rb"]
  s.homepage = "http://rubyforge.org/projects/debug-commons/"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.2")
  s.rubyforge_project = "debug-commons"
  s.rubygems_version = "1.8.10"
  s.summary = "IDE interface for ruby-debug."

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rake>, [">= 0.8.1"])
    else
      s.add_dependency(%q<rake>, [">= 0.8.1"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0.8.1"])
  end
end

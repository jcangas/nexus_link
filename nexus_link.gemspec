# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "nexus_link/version"

Gem::Specification.new do |s|
  s.name        = "nexus_link"
  s.version     = NexusLink::VERSION
  s.authors     = ["Jorge L. Cangas"]
  s.email       = ["jorge.cangas@gmail.com"]
  s.homepage    = "http://github.com/jcangas/nexus_link"
  s.summary     = %q{A Ruby gem to interoperate with Nexus ERP (http://www.websie.com/)}
  s.description = %q{A Ruby gem to interoperate with Nexus ERP (http://www.websie.com/)}


  s.rubyforge_project = "nexus_link"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "activerecord"  
  s.add_dependency "version_info"  
end

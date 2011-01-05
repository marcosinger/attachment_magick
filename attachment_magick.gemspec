# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "attachment_magick/version"

Gem::Specification.new do |s|
  s.name        = "attachment_magick"
  s.version     = AttachmentMagick::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Marco Antônio Singer", "Carlos Brando"]
  s.email       = ["markaum@gmail.com", "eduardobrando@gmail.com"]
  s.homepage    = "http://github.com/marcosinger/attachment_magick"
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "attachment_magick"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  # s.add_dependency('hpricot', '>= 0.8.3')
end

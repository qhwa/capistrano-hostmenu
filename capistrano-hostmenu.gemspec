# Ensure we require the local version and not one we might have installed already
spec = Gem::Specification.new do |s| 

  s.name             = "capistrano-hostmenu"
  s.version          = '0.1.1'
  s.summary          = "Capistrano plugin that prompt a text menu to choose target host."
  s.author           = "qhwa"
  s.email            = "qhwa@163.com"
  s.homepage         = "https://github.com/qhwa/capistrano-hostmenu"
  s.has_rdoc         = false
  s.extra_rdoc_files = %w(README.md)
  s.rdoc_options     = %w(--main README.md)
  s.files            = %w(README.md Rakefile Gemfile.lock Gemfile) +
                        Dir.glob("{bin,lib}/**/*") -
                        Dir.glob("spec/**/*")

  s.require_paths << 'lib'

  s.add_runtime_dependency('capistrano','>= 3.0.0')

  s.add_development_dependency("rake")
  s.add_development_dependency("rake-compiler")
  s.add_development_dependency("bundler")
  s.add_development_dependency("yard")
  s.add_development_dependency("rspec")

end

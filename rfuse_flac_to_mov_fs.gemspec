require 'rake/gempackagetask'

gem_name = 'rfuse_flac_to_mov_fs'

spec = Gem::Specification.new do |s|
   s.name         = gem_name
   s.version      = '0.0.2'
   s.platform     = Gem::Platform::RUBY
   s.summary      = 'Ruby Fuse, Filesystem to make *.flac files look like *.mov for itunes Mac OS X.'
   s.homepage     = "http://amaras-tech.co.uk/software/#{gem_name}"
   s.authors      = "Morgan Prior"
   s.email        = "#{gem_name}_gem@amaras-tech.co.uk"
   s.description  = "Virtual Filesystem Written in Ruby Fuse, which lets *.flac look like *.mov for iTunes. Use incombination with the Xiph Component http://xiph.org/quicktime/download.html "
   s.files        = ["bin/#{gem_name}"]
   s.files        += Dir.glob("lib/*")
   s.bindir       = 'bin'   
   s.executables  = [gem_name]
   s.has_rdoc     = false
   s.add_dependency("fusefs",">= 0.7.0")

   s.post_install_message = "To use '#{gem_name}' as a standalone application your gems folder must be on your path"   
end
Rake::GemPackageTask.new(spec).define


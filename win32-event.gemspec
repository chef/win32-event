require 'rubygems'

spec = Gem::Specification.new do |gem|
   gem.name        = 'win32-event'
   gem.version     = '0.5.1'
   gem.author      = 'Daniel J. Berger'
   gem.license     = 'Artistic 2.0'
   gem.email       = 'djberg96@gmail.com'
   gem.homepage    = 'http://www.rubyforge.org/projects/win32utils'
   gem.platform    = Gem::Platform::RUBY
   gem.summary     = 'Interface to MS Windows Event objects.'
   gem.test_file   = 'test/test_win32_event.rb'
   gem.has_rdoc    = true
   gem.files       = Dir['**/*'].reject{ |f| f.include?('CVS') }

   gem.extra_rdoc_files = ['README', 'CHANGES', 'MANIFEST']
   gem.rubyforge_project = 'win32utils'

   gem.add_dependency('win32-ipc', '>= 0.5.0')

   gem.description = <<-EOF
      The win32-event library provides an interface to Windows event objects.
      An event object is a synchronization object whose state can be explicitly
      set to a signaled state. Event objects are useful in sending a signal to
      a thread indicating that a particular event has occurred.
   EOF
end

Gem::Builder.new(spec).build

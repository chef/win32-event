begin
  require_relative "lib/win32/event/version"
rescue LoadError
  puts "Warning: Could not load version file"
  module Win32; module Event; VERSION = "0.7.0".freeze; end; end
end

Gem::Specification.new do |spec|
  spec.name       = "win32-event"
  spec.version    = Win32::Event::VERSION
  spec.author     = "Daniel J. Berger"
  spec.license    = "Artistic 2.0"
  spec.email      = "djberg96@gmail.com"
  spec.homepage   = "http://github.com/djberg96/win32-event"
  spec.summary    = "Interface to MS Windows Event objects."
  spec.test_file  = "test/test_win32_event.rb"

  # Remove git dependency for files
  spec.files = Dir["lib/**/*", "README*", "CHANGES*", "MANIFEST*"]

  spec.cert_chain = ["certs/djberg96_pub.pem"]

  spec.extra_rdoc_files = %w{README CHANGES MANIFEST}
  spec.required_ruby_version = ">= 3.1"

  spec.add_dependency "win32-ipc", ">= 0.7.0"
  spec.add_dependency "fiddle", "= 1.1.6" # This is being removed from the standard library in Ruby 3.5
  spec.add_development_dependency "test-unit"

  spec.metadata = {
    "source_code_uri" => "https://github.com/chef/win32-event",
    "changelog_uri" => "https://github.com/chef/win32-event/blob/main/CHANGES",
    "homepage_uri" => "https://github.com/chef/win32-event",
  }

  spec.description = <<-EOF
    The win32-event library provides an interface to Windows event objects.
    An event object is a synchronization object whose state can be explicitly
    set to a signaled state. Event objects are useful in sending a signal to
    a thread indicating that a particular event has occurred.
  EOF
end

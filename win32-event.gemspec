

Gem::Specification.new do |spec|
  spec.name       = "win32-event"
  spec.version    = "0.6.3"
  spec.author     = "Daniel J. Berger"
  spec.license    = "Artistic 2.0"
  spec.email      = "djberg96@gmail.com"
  spec.homepage   = "http://github.com/djberg96/win32-event"
  spec.summary    = "Interface to MS Windows Event objects."
  spec.test_file  = "test/test_win32_event.rb"
  spec.files      = Dir["**/*"].reject { |f| f.include?("git") }
  spec.cert_chain = ["certs/djberg96_pub.pem"]

  spec.extra_rdoc_files = %w{README CHANGES MANIFEST}
  spec.required_ruby_version = "> 1.9.0"

  spec.add_dependency("win32-ipc", ">= 0.6.0")
  spec.add_development_dependency("test-unit")

  spec.description = <<-EOF
    The win32-event library provides an interface to Windows event objects.
    An event object is a synchronization object whose state can be explicitly
    set to a signaled state. Event objects are useful in sending a signal to
    a thread indicating that a particular event has occurred.
  EOF
end

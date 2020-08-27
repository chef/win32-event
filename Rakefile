require "rake"
require "rake/testtask"
require "rake/clean"

CLEAN.include("**/*.gem", "**/*.rbc")

namespace "gem" do
  desc "Create the win32-event gem"
  task create: [:clean] do
    require "rubygems/package" unless defined?(Gem::Package)
    spec = eval(IO.read("win32-event.gemspec"))
    spec.signing_key = File.join(Dir.home, ".ssh", "gem-private_key.pem")
    Gem::Package.build(spec)
  end

  desc "Install the win32-event gem"
  task install: %i{clean create} do
    file = Dir["*.gem"].first
    sh "gem install -l #{file}"
  end
end

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = true
end

task default: :test

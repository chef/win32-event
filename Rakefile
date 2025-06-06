require "rake"
require "rake/testtask"
require "rake/clean"

CLEAN.include("**/*.gem", "**/*.rbc")

namespace "gem" do
  desc "Create the win32-event gem"
  task create: [:clean] do
    require "rubygems/package" unless defined?(Gem::Package)
    spec = Gem::Specification.load("win32-event.gemspec")
    abort "Could not load gemspec!" unless spec
    gem_file = Gem::Package.build(spec)
    puts "Built gem: #{gem_file}"
  end

  desc "Install the win32-event gem"
  task install: %i{clean create} do
    spec = Gem::Specification.load("win32-event.gemspec")
    abort "Could not load gemspec!" unless spec
    gem_file = Dir["#{spec.name}-#{spec.version}.gem"].first
    abort "Gem file not found!" unless gem_file
    sh "gem install -l #{gem_file}"
  end
end

desc "Check Linting and code style."
task :style do
  require "rubocop/rake_task"
  require "cookstyle/chefstyle"

  if RbConfig::CONFIG["host_os"] =~ /mswin|mingw|cygwin/
    # Windows-specific command, rubocop erroneously reports the CRLF in each file which is removed when your PR is uploaeded to GitHub.
    # This is a workaround to ignore the CRLF from the files before running cookstyle.
    sh "cookstyle --chefstyle -c .rubocop.yml --except Layout/EndOfLine"
  else
    sh "cookstyle --chefstyle -c .rubocop.yml"
  end
rescue LoadError
  puts "Rubocop or Cookstyle gems are not installed. bundle install first to make sure all dependencies are installed."
end

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = true
end

# Add dependency installation to test task
task test: :ensure_dependencies

task :ensure_dependencies do
  unless system("gem list -i win32-ipc")
    puts "Installing required win32-ipc dependency..."
    system("gem install win32-ipc")
  end
end

task default: :test

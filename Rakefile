require 'rake'
require 'rake/testtask'
require 'rake/clean'

CLEAN.include("**/*.gem", "**/*.rbc")

namespace 'gem' do
  desc 'Create the win32-event gem'
  task :create => [:clean] do
    spec = eval(IO.read('win32-event.gemspec'))
    Gem::Builder.new(spec).build
  end

  desc 'Install the win32-event gem'
  task :install => [:clean, :create] do
    file = Dir['*.gem'].first
    sh "gem install #{file}"
  end
end

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = true
end

task :default => :test

require 'rake'
require 'rake/testtask'
require 'rbconfig'
include Config

namespace 'gem' do
  desc 'Remove existing .gem file from the current directory'
  task :clean do
    Dir['*.gem'].each{ |f| File.delete(f) }
  end

  desc 'Create the win32-event gem'
  task :create do
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

require "bundler/gem_tasks"
require "rake/testtask"
require "yard"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

YARD::Rake::YardocTask.new do |t|
  t.files   = ['lib/**/*.rb', '-', 'LICENSE.txt']
  #t.options = ['--any', '--extra', '--opts']
  t.stats_options = ['--list-undoc']
end

task :default => :test
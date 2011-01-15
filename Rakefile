require 'bundler'
require 'rcov/rcovtask'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

Rcov::RcovTask.new(:rcov) do |rcov|
  rcov.libs
  rcov.rcov_opts << '--rails'
  rcov.rcov_opts << '-x .gem'
  rcov.pattern    = 'test/attachment_magick/**/*_test.rb'
  rcov.output_dir = 'test/rcov'
  rcov.verbose    = true
end

task :default => :test

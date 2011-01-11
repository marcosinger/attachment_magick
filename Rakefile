require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
require 'launchy'

Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
end

task :default => :test
task :rcov => "rcov:plain"

rcov_command = "bundle exec rcov -I *_test.rb **/*_test.rb  --rails  -x '.gem|case|helper'"
namespace :rcov do
  #FIXME Tenho que entrar na pasta test senão não consigo rodar o rcov
  FileUtils.cd('test')
  
  task :plain do
     system "#{rcov_command} --no-html -T"
  end
end

namespace :rcov do
  task :web do
     system "#{rcov_command} -o dummy/public/coverage"
     Launchy.open("http://localhost:3000/coverage/index.html")
   end
end

# Rake::RDocTask.new(:rdoc) do |rdoc|
#   rdoc.rdoc_dir = 'rdoc'
#   rdoc.title    = 'GenericPages'
#   rdoc.options << '--line-numbers' << '--inline-source'
#   rdoc.rdoc_files.include('README.rdoc')
#   rdoc.rdoc_files.include('lib/**/*.rb')
# end

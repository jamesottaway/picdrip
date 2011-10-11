require 'cucumber/rake/task'

Cucumber::Rake::Task.new :acceptance do |task|
  task.cucumber_opts = ['--tag', '~@wip', '--strict', 'features']
end

Cucumber::Rake::Task.new :wip do |task|
  task.cucumber_opts = ['--tag', '@wip', '--wip', 'features']
end

task :cucumber => [:wip, :acceptance]
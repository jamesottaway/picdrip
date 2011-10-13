require 'cucumber/rake/task'

namespace :cucumber do
  Cucumber::Rake::Task.new :strict do |task|
    task.cucumber_opts = ['--tag', '~@wip', '--strict', 'features']
  end

  Cucumber::Rake::Task.new :wip do |task|
    task.cucumber_opts = ['--tag', '@wip', '--wip', 'features']
  end
end

desc 'Run all Cucumber features'
task :cucumber => ['cucumber:wip', 'cucumber:strict']

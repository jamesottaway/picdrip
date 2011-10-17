begin
  require 'cucumber/rake/task'

  namespace :cucumber do
    Cucumber::Rake::Task.new :strict do |task|
      task.cucumber_opts = '-p strict'
    end

    Cucumber::Rake::Task.new :wip do |task|
      task.cucumber_opts = '-p wip'
    end
  end

  desc 'Run all Cucumber features'
  task :cucumber => ['db:seed', 'cucumber:wip', 'cucumber:strict']
rescue LoadError
end
require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

namespace :spec do
  RSpec::Core::RakeTask.new(:unit)

  RSpec::Core::RakeTask.new(:integration) do |t|
    t.rspec_opts = '--tag integration --format progress'
  end
end
task :spec => 'spec:unit'

task :default => :spec

Dir.glob('tasks/*.rake').each { |r| import r }

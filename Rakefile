require 'bundler/gem_tasks'
require 'rspec/core/rake_task'

namespace :spec do
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = FileList['spec/**/*_spec.rb'].exclude('spec/integration/**/*_spec.rb')
  end

  RSpec::Core::RakeTask.new(:integration => :gatherer) do |t|
    t.pattern = 'spec/integration/**/*_spec.rb'
    t.rspec_opts = '--format progress'
  end
end
task :spec => 'spec:unit'

task :default => :spec

Dir.glob('tasks/*.rake').each { |r| import r }

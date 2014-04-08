require 'factory_girl'

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    FactoryGirl.lint
  end
end

Dir[File.expand_path('../../factories/', __FILE__) + '/**/*.rb'].each { |f| require f }

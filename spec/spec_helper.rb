$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'spells'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each {|f| require f }

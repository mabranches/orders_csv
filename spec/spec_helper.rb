require 'simplecov'
SimpleCov.start

require 'rspec'
require 'byebug'
Dir["./lib/*"].each {|file| require file }
Dir["./models/*"].each {|file| require file }

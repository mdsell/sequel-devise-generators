ENV["RAILS_ENV"] = "test"
DEVISE_ORM = (ENV["DEVISE_ORM"] || :sequel).to_sym

$:.unshift File.dirname(__FILE__)
puts "\n==> Devise.orm = #{DEVISE_ORM.inspect}"

require "rails"
require "rails/test_help"

# For generators
require "rails/generators/test_case"

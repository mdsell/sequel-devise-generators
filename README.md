# Sequel::Devise::Generators

This gem adds a generator for Devise models to the excellent sequel-rails (https://github.com/TalentBox/sequel-rails) via sequel-devise (https://github.com/rosenfeld/sequel-devise).

## Installation

Add this line to your application's Gemfile:

    gem 'sequel-devise-generators'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sequel-devise-generators

## Usage

* Create a devise install using the devise:install generator
* Remove or comment out `require 'devise/orm/sequel'`
* Generate your model and migration using `rails g sequel:devise model_name`
* Migrate your database

## Contributing

1. Fork it ( http://github.com/mdsell/sequel-devise-generators/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

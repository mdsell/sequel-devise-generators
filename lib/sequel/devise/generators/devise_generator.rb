require 'rails/generators'
require 'rails/generators/named_base'
require 'rails/generators/migration'
require 'rails/generators/active_model'
require 'generators/sequel'
require 'generators/devise/orm_helpers'

module Sequel
  module Generators
    class DeviseGenerator < Rails::Generators::NamedBase
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      include ::Devise::Generators::OrmHelpers
      include ::Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)

      def self.next_migration_number(path)
        Sequel::Generators::Base.next_migration_number(path)
      end

      def copy_devise_migration
        if (behavior == :invoke && model_exists?) || (behavior == :revoke && migration_exists?(table_name))
          migration_template "migration_existing.rb.erb", "db/migrate/add_devise_to_#{table_name}"
        else
          migration_template "migration.rb.erb", "db/migrate/devise_create_#{table_name}"
        end
      end

      def generate_model
        invoke "sequel:model", [name], :migration => false unless model_exists? && behavior == :invoke
      end

      def inject_devise_content
        content = ("#{sequel_plugins}#{model_contents}").split("\n").map { |line| "  " * indent_depth + line } .join("\n") << "\n"
        inject_into_class(model_path, class_parts.last, content) if model_exists?
      end

      def sequel_plugins
        [
          ':devise', 
          ':timestamps, :update_on_create => true'
        ].map { |p| "  plugin #{p}\n" }.join('')
      end

      def class_parts
        if namespaced?
          class_name.to_s.split("::")
        else
          [class_name]
        end
      end

      def indent_depth
        class_parts.size - 1
      end

      def migration_data
<<RUBY
      ## Database authenticatable
      String :email,              :null => false, :default => ""
      String :encrypted_password, :null => false, :default => ""

      ## Recoverable
      String :reset_password_token
      String :reset_password_sent_at

      ## Rememberable
      DateTime :remember_created_at

      ## Trackable
      Integer  :sign_in_count, :default => 0, :null => false
      DateTime :current_sign_in_at
      DateTime :last_sign_in_at
      String   :current_sign_in_ip
      String   :last_sign_in_ip

      ## Confirmable
      # String   :confirmation_token
      # DateTime :confirmed_at
      # DateTime :confirmation_sent_at
      # String   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # Integer  :failed_attempts, :default => 0, :null => false # Only if lock strategy is :failed_attempts
      # String   :unlock_token # Only if unlock strategy is :email or :both
      # DateTime :locked_at
RUBY
      end
    end
  end
end

require "test_helper"

if DEVISE_ORM == :sequel
  require "./lib/sequel/devise/generators/devise_generator"

  class DeviseGeneratorTest < Rails::Generators::TestCase
    tests Sequel::Generators::DeviseGenerator
    destination File.expand_path("../../tmp", __FILE__)
    setup :prepare_destination

    test "all files for namespaced model are properly created" do
      run_generator %w(admin/monster)
      assert_migration "db/migrate/devise_create_admin_monsters.rb"
    end

    test "update model migration when model exists" do
      run_generator %w(monster)
      assert_file "app/models/monster.rb"
      run_generator %w(monster)
      assert_migration "db/migrate/add_devise_to_monsters.rb"
    end

    test "model uses devise plugin" do
      run_generator %w(monster)
      assert_file "app/models/monster.rb", /plugin :devise/
    end

    test "model uses timestamps plugin" do
      run_generator %w(monster)
      assert_file "app/models/monster.rb", /plugin :timestamps/
    end

    test "all files are properly deleted" do
      run_generator %w(monster)
      run_generator %w(monster)
      assert_migration "db/migrate/devise_create_monsters.rb"
      assert_migration "db/migrate/add_devise_to_monsters.rb"
      run_generator %w(monster), :behavior => :revoke
      assert_no_migration "db/migrate/add_devise_to_monsters.rb"
      assert_migration "db/migrate/devise_create_monsters.rb"
      run_generator %w(monster), :behavior => :revoke
      assert_no_file "app/models/monster.rb"
      assert_no_migration "db/migrate/devise_create_monsters.rb"
    end
  end
end

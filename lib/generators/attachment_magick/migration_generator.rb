module AttachmentMagick
  module Generators
    class MigrationGenerator < Rails::Generators::Base
      include Rails::Generators::Migration

      source_root File.expand_path('../templates', __FILE__)

      def self.next_migration_number(dirname)
        ActiveRecord::Base.timestamped_migrations ? Time.now.utc.strftime("%Y%m%d%H%M%S") : "%.3d" % (current_migration_number(dirname) + 1)
      end

      def create_migration_file
        migration_template "attachment_magick_migration.rb", "db/migrate/attachment_magick_migration.rb"
      end
    end
  end
end
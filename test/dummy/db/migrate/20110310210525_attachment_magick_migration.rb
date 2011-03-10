class AttachmentMagickMigration < ActiveRecord::Migration
  def self.up
    create_table "amagick_images" do |t|
      t.string      :photo_uid
      t.string      :caption
      t.integer     :priority
      t.string      :source
      t.string      :image_type
      t.references  :imageable, :polymorphic => true

      t.timestamps
    end
  end

  def self.down
    drop_table "amagick_images"
  end
end
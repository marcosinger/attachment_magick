require 'rack/cache'
require 'dragonfly'

app = Dragonfly[:images]
app.configure_with(:imagemagick)
app.configure_with(:rails)

if defined? ActiveRecord::Base
  app.define_macro(ActiveRecord::Base, :image_accessor)
end

if defined? Mongoid::Document
  require 'mongoid'

  mongo_yml_path  = Rails.env.test? ? "#{File.expand_path('../../../../test/dummy/config', __FILE__)}" : "config"
  db              = YAML.load_file(File.join(mongo_yml_path, 'mongoid.yml'))[Rails.env]['database']
  app.datastore   = Dragonfly::DataStorage::MongoDataStore.new :database => db

  app.define_macro_on_include(Mongoid::Document, :image_accessor)
end
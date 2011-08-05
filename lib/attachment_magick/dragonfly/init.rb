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
  yaml_file       = YAML.load_file(File.join(mongo_yml_path, 'mongoid.yml'))[Rails.env]

  app.datastore = Dragonfly::DataStorage::MongoDataStore.new
  app.datastore.configure do |c|
    c.host      = yaml_file['host']                 # defaults to localhost
    c.port      = yaml_file['port']                 # defaults to mongo default (27017)
    c.database  = yaml_file['database']             # defaults to 'dragonfly'
    c.username  = yaml_file['username']             # only needed if mongo is running in auth mode
    c.password  = yaml_file['password']             # only needed if mongo is running in auth mode
  end

  app.define_macro_on_include(Mongoid::Document, :image_accessor)
end
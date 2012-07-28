require 'rack/cache'
require 'dragonfly'

app = Dragonfly[:images]
app.configure_with(:imagemagick)
app.configure_with(:rails)

if defined? ActiveRecord::Base
  app.define_macro(ActiveRecord::Base, :image_accessor)
end

if defined? Mongoid::Document
  app.datastore = Dragonfly::DataStorage::MongoDataStore.new :db => Mongoid.database
  app.define_macro_on_include(Mongoid::Document, :image_accessor)
end
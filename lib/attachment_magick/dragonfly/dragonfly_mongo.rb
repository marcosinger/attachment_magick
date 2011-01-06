require 'dragonfly'

app = Dragonfly[:images]
db  = YAML.load_file(Rails.root.join('config/mongoid.yml'))[Rails.env]['database']

app.configure_with(:imagemagick)
app.configure_with(:rails) do |c|
  c.datastore = Dragonfly::DataStorage::MongoDataStore.new :database => db
end

app.define_macro_on_include(Mongoid::Document, :image_accessor)
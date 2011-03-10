module AttachmentMagickTestHelper
  def assert_element_in(target, match)
    target = Nokogiri::HTML(target)
    target.xpath("//#{match}").present?
  end

  def assert_element_value(target, match, field)
    target = Nokogiri::HTML(target)
    target.xpath("//#{match}").first["#{field}"]
  end

  def create_artist(options={})
    default_options = {:name => "Johnny", :lastname => "Depp"}
    default_options.merge!(options)

    @artist = Artist.create(default_options)
    @artist.images.create(:photo => exemple_file)
    return @artist
  end

  def create_place(options={})
    default_options = {:name => "Las Vegas"}
    default_options.merge!(options)

    @place = Place.create(default_options)
    @place.images.create(:photo => exemple_file)
    return @place
  end

  def create_work(artist)
    default_options = {:name => "movie", :local => "Hollywood"}
    artist.works.create(default_options)
    artist.works.last.images.create(:photo => exemple_file)
  end

  def exemple_file
    File.expand_path('../dummy/public/images/little_girl.jpg', __FILE__)
  end

  def exemple_partial
    "layouts/custom_images_list"
  end
end
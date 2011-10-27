class Tempfile
  def original_filename
    "little_girl.jpg"
  end
end


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
    @artist.images.create(:photo => example_file)
    return @artist
  end

  def create_place(options={})
    default_options = {:name => "Las Vegas"}
    default_options.merge!(options)

    @place = Place.create(default_options)
    @place.images.create(:photo => example_file)
    return @place
  end

  def create_work(artist)
    default_options = {:name => "movie", :local => "Hollywood"}
    artist.works.create(default_options)
    artist.works.last.images.create(:photo => example_file)
  end

  def example_file
    Tempfile.new('little_girl.jpg')
  end

  def example_youtube
    'http://www.youtube.com/watch?v=FUe83k3t_0s'
  end

  def example_vimeo
    'http://vimeo.com/14051767'
  end

  def example_partial
    "layouts/custom_images_list"
  end
end
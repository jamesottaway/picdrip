module AlbumsHelper
  def setup_album(album)
      album.tap do |a|
        a.photos.build if a.photos.empty?
      end
    end
end

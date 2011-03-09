module AlbumsHelper
  def setup_album(album)
      returning(album) do |a|
        a.photos.build if a.photos.empty?
      end
    end
end

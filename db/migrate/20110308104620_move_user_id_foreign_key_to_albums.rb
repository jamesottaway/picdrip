class MoveUserIdForeignKeyToAlbums < ActiveRecord::Migration
  def self.up
    add_column :albums, :user_id, :integer
    add_column :photos, :album_id, :integer
    
    execute <<EOF
      INSERT INTO albums (id, title, user_id)
      SELECT users.id, 'Legacy album for ' + users.email, users.id
      FROM users
EOF
    
    execute <<EOF
      UPDATE photos
      SET album_id = user_id
EOF
    
    remove_column :photos, :user_id
  end

  def self.down
    add_column :photos, :user_id, :integer

    execute <<EOF
      UPDATE photos
      SET user_id = (SELECT users.id
                     FROM users INNER JOIN albums ON users.id = albums.user_id
                     WHERE photos.album_id = albums.id)
EOF
    
    remove_column :photos, :album_id
    remove_column :albums, :user_id
  end
end

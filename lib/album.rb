class Album
  attr_reader :id, :name
  attr_accessor :name
  @@albums = {}
  @@total_rows = 0
  @@sold_albums = {}

  def initialize(name, id)
    @name = name
    @id = id || @@total_rows +=1
  end

  def self.search(name)
    @@albums.each_pair do |array|
      if name.downcase == array[1].name.downcase
        return array[1]
      end
    end
  end

  def self.sort
    array_of_albums = @@albums.values
    return array_of_albums.sort_by {|obj| obj.name}
  end

  def self.all
    @@albums.values()
  end

  def save
    @@albums[self.id] = Album.new(self.name, self.id)
  end

  def ==(album_to_compare)
    self.name() == album_to_compare.name()
  end

  def self.clear
    @@albums = {}
    @@total_rows = 0
  end

  def self.find(id)
    @@albums[id]
  end

  def self.find_sold(id)
    @@sold_albums[id]
  end

  def update(name)
    self.name = name
    @@albums[self.id] = Album.new(self.name, self.id)
  end
  
  def delete
    @@albums.delete(self.id)
  end
  def delete_sold
    @@sold_albums.delete(self.id)
  end

  def sold
    @@sold_albums[self.id] = Album.new(self.name, self.id)
    @@albums.delete(self.id)
  end

  def self.sold
    @@sold_albums.values
  end

  def songs
    Song.find_by_album(self.id)
  end
end




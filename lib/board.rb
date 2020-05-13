class Board

  def cells
    coords = []
    lat = %w[A B C D]
    long = %w[1 2 3 4]
    lat.each do |latitude|
      long.each do |longitude|
        coords << latitude + longitude
      end
    end
    new_coords = {}
    coords.each do |coordinates|
      new_coords[coordinates] = Cell.new(coordinates)
    end
  end

  def valid_coordinate?(coordinate)
    self.cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinate)

    coordinate.each_cons(ship.length).all? do |lat, long|
    lat == long - 1
  end

    if coordinate.count == ship.length
      true
    elsif coordinate.count != ship.length
      false
    end
  end
end

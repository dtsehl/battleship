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
    coordinate.each_cons(ship.length).all? do |lat_ords, long_ords|
      lat_ords = ["A".ord, "B".ord, "C".ord, "D".ord]
      long_ords = ["1".ord, "2".ord, "3".ord, "4".ord]
      if lat_ords.each_cons(ship.length).all? == true && long_ords.each_cons(ship.length).all? == true && coordinate.count == ship.length
        true
      else
        false
      end
    end
    if coordinate.count == ship.length && self.consecutive_coordinates == true
      true
    elsif coordinate.count != ship.length
      false
    end
  end
end

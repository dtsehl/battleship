class Board

  def initialize
    @lat_ords = []
    @long_ords = []
  end

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
    return false if ship.length != coordinate.length
    lat_ords = coordinate.map {|coord| coord.split("").first}
    long_ords = coordinate.map {|coord| coord.split("").last}
    all_ords = coordinate.map {|coord| coord.split("")}

    lat_ords_verification = lat_ords.each_cons(2).all? do |first, second|
      first.ord + 1 == second.ord || first.ord == second.ord
      end
    long_ords_verification = long_ords.each_cons(2).all? do |first, second|
      first.ord + 1 == second.ord || first.ord == second.ord
      end
    diag_verification = all_ords.each_cons(2).all? do |first, second|
      (first[0].ord + first[1].ord) + 1 == (second[0].ord + second[1].ord) || (first[0].ord + first[1].ord) == (second[0].ord + second[1].ord)
    end

    lat_ords_verification && long_ords_verification && diag_verification
  end
end

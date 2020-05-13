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
    lat_ords_verification = true
    lat_ords = ["A".ord, "B".ord, "C".ord, "D".ord]
      lat_ords.each_cons(ship.length).all? do |first, second|
      lat_ords_verification = (coordinate.first.chop == first + 1)
      require 'pry'; binding.pry
      end
    long_ords_verification = true
    long_ords = ["1".ord, "2".ord, "3".ord, "4".ord]
        long_ords.each_cons(ship.length).all? do |first, second|
        long_ords_verification = (coordinate.last.chop == first + 1)
        end
    if lat_ords_verification == false || long_ords_verification == false
      false
    else
      true
    end
  end
end

class Board
  attr_reader :cells

  def initialize
    @lat_ords = []
    @long_ords = []
    @cells = {}
  end

  def create_cells
    coords = []
    cells = {}
    lat = %w[A B C D]
    long = %w[1 2 3 4]
    lat.each do |latitude|
      long.each do |longitude|
        coords << latitude + longitude
      end
    end
    coords.each do |coordinates|
      cells[coordinates] = Cell.new(coordinates)
    end
    @cells
  end

  def valid_coordinate?(coordinate)
    self.cells.include?(coordinate)
  end

  def valid_placement?(ship, coordinate)
    return false if ship.length != coordinate.length
    ords = coordinate.map {|coord| coord.split("")}
    verification = ords.each_cons(2).all? do |first, second|
      (first[0].ord + first[1].ord) + 1 == (second[0].ord + second[1].ord) || (first[0].ord + first[1].ord) == (second[0].ord + second[1].ord)
    end
  end

  def place(ship, coordinate)
    cells.map do |coord, cell|
      coordinate.each do |cell_1|
        @cells[cell_1].place_ship(ship)
      end
    end
  end

end

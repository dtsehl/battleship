class Board
  attr_reader :cells, :verification

  def initialize
    @lat_ords = []
    @long_ords = []
    @cells = {}
  end

  def create_cells
    coords = []
    lat = %w[A B C D]
    long = %w[1 2 3 4]
    lat.each do |latitude|
      long.each do |longitude|
        coords << latitude + longitude
      end
    end
    coords.each do |coordinates|
      @cells[coordinates] = Cell.new(coordinates)
    end
  end

  def valid_coordinate?(coordinate)
    self.cells.include?(coordinate)
  end

  def place(ship, coordinate)
    cells.map do |coord, cell|
      coordinate.each do |cell_1|
        @cells[cell_1].place_ship(ship)
      end
    end
  end

  def render
    require "pry"; binding.pry
  end
end

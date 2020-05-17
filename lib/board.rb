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

  def render(optional = false)
     # p [[" ", " 1 ", "2 ", "3 ", "4 ", "\nA "],[@cells["A1"].render, " ", @cells["A2"].render, " ", @cells["A3"].render, " ", @cells["A4"].render].join,
     # ["\nB ", @cells["B1"].render, " ", @cells["B2"].render, " ", @cells["B3"].render, " ", @cells["B4"].render].join,
     # ["\nC ", @cells["C1"].render, " ", @cells["C2"].render, " ", @cells["C3"].render, " ", @cells["C4"].render].join,
     # ["\nD ", @cells["D1"].render, " ", @cells["D2"].render, " ", @cells["D3"].render, " ", @cells["D4"].render, "\n"].join].join
    " 1 2 3 4
A #{@cells["A1"].render} #{@cells["A2"].render} #{@cells["A3"].render} #{@cells["A4"].render}
B #{@cells["B1"].render} #{@cells["B2"].render} #{@cells["B3"].render} #{@cells["B4"].render(true)}
C #{@cells["C1"].render} #{@cells["C2"].render} #{@cells["C3"].render} #{@cells["C4"].render}
D #{@cells["D1"].render} #{@cells["D2"].render} #{@cells["D3"].render} #{@cells["D4"].render}\n"
  end
end

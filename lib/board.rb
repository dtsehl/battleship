class Board
  attr_reader :cells, :verification

  def initialize
    @lat_ords = []
    @long_ords = []
    @cells = {}
    @length = 4
    @width = 4
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
    cells.include?(coordinate)
  end

  def place(ship, coordinate)
    cells.map do |coord, cell|
      coordinate.each do |cell_1|
        @cells[cell_1].place_ship(ship)
      end
    end
  end

  def render(optional = false)
    if optional == false
      rendered_array = @cells.map do |coord, data|
        data.render
      end
    else
      rendered_array = @cells.map do |coord, data|
        data.render(true)
      end
    end

    line_1 = "  1 2 3 4 \n"
    line_2 = "A #{rendered_array[0]} #{rendered_array[1]} #{rendered_array[2]} #{rendered_array[3]} \n"
    line_3 = "B #{rendered_array[4]} #{rendered_array[5]} #{rendered_array[6]} #{rendered_array[7]} \n"
    line_4 = "C #{rendered_array[8]} #{rendered_array[9]} #{rendered_array[10]} #{rendered_array[11]} \n"
    line_5 = "D #{rendered_array[12]} #{rendered_array[13]} #{rendered_array[14]} #{rendered_array[15]} \n"
    render = line_1 + line_2 + line_3 + line_4 + line_5
  end
end

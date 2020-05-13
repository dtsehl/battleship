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
end

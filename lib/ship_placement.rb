class ShipPlacement

  def initialize(board, ship, desired_coordinates)
    @board = board
    @ship = ship
    @desired_coordinates = desired_coordinates
  end

  def valid?
    if is_garbage? == true || valid_length? == false || overlapping_ships? == true || is_not_diagonal? == false
      false
    else
      true
    end
  end

  def is_garbage?
    @desired_coordinates.any? do |coord|
      @board.cells[coord] == nil
    end
  end

  def valid_length?
    @ship.length == @desired_coordinates.length
  end

  def overlapping_ships?
    @desired_coordinates.any? do |coord|
      @board.cells[coord].empty? == false
     end
   end

   def is_not_diagonal?
     ords = @desired_coordinates.map {|coord_1| coord_1.split("")}
      ords.each_cons(2).all? do |first, second|
       (first[0].ord + first[1].ord) + 1 == (second[0].ord + second[1].ord) || (first[0].ord + first[1].ord) == (second[0].ord + second[1].ord)
      end
    end

  end

class Starter



  def start_game
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    game_start_string = gets.chomp.downcase
      if game_start_string == "p"
        play
      elsif game_start_string == "q"
        return
      else "Please re-type either p to play or q to quit."
    end
  end

  def play
    @computer_board = Board.new
    @user_board = Board.new
    @computer_cruiser = Ship.new("Cruiser", 3)
    @computer_submarine = Ship.new("Submarine", 2)
    @user_cruiser = Ship.new("Cruiser", 3)
    @user_submarine = Ship.new("Submarine", 2)
    @computer_board.create_cells
    @user_board.create_cells
    computer_place_ships
  end

  def computer_place_ships
    ords = @computer_board.cells.keys.map do |coord_1|
      coord_1.split("")
    end
    placement = ords.each_cons(2).all? do |first, second|
     (first[0].ord + first[1].ord) + 1 == (second[0].ord + second[1].ord) || (first[0].ord + first[1].ord) == (second[0].ord + second[1].ord)
    end
    @computer_board.place[@computer_cruiser, placement]
  end

end

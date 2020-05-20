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

    create_computer_placements
    computer_place_ships

    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."

    player_place_ships

    play_turns
  end

  def create_computer_placements
    horiz_3 = []
    vert_3 = []
    placement_3 = @computer_board.cells.keys
    placement_3.each_cons(3) do |coords|
      horiz_3 << coords
    end

    vert_3_ords = @computer_board.cells.keys.map {|coord_1| coord_1.split("")}
     vert_3_ords.each_cons(9).all? do |first, second, third, fourth, fifth, sixth, seventh, eighth, ninth|
       if (((first[0].ord + 1) == (fifth[0].ord)) && (fifth[0].ord + 1 == ninth[0].ord)) && ((first[1].ord == fifth[1].ord) && (fifth[1].ord == ninth[1].ord))
         vert_3 << [first.join, fifth.join, ninth.join]
       end
     end

    @valid_3_coords = vert_3 + horiz_3

    horiz_2 = []
    vert_2 = []
    placement_2 = @computer_board.cells.keys
    placement_2.each_cons(2) do |coords|
      horiz_2 << coords
    end

    vert_2_ords = @computer_board.cells.keys.map {|coord_1| coord_1.split("")}
     vert_2_ords.each_cons(5).all? do |first, second, third, fourth, fifth|
       if ((first[0].ord + 1) == (fifth[0].ord)) && ((first[1].ord == fifth[1].ord))
         vert_2 << [first.join, fifth.join]
       end
     end

   @valid_2_coords = vert_2 + horiz_2
  end

  def computer_place_ships
    three_picked_coords = @valid_3_coords.sample

    valid_placement_3 = ShipPlacement.new(@computer_board, @computer_cruiser, three_picked_coords)
    while valid_placement_3.valid? == false
      three_picked_coords = @valid_3_coords.sample
      valid_placement_3 = ShipPlacement.new(@computer_board, @computer_cruiser, three_picked_coords)
    end

    @computer_board.place(@computer_cruiser, three_picked_coords)

    two_picked_coords = @valid_2_coords.sample

    valid_placement_2 = ShipPlacement.new(@computer_board, @computer_submarine, two_picked_coords)
    while valid_placement_2.valid? == false
      two_picked_coords = @valid_2_coords.sample
      valid_placement_2 = ShipPlacement.new(@computer_board, @computer_submarine, two_picked_coords)
    end

    @computer_board.place(@computer_submarine, two_picked_coords)
  end

  def player_place_ships
    puts @user_board.render

    puts "Enter the squares for the Cruiser (3 spaces):"
    puts ">"

    cruiser_spaces = gets.chomp.split(" ")

    placement = ShipPlacement.new(@user_board, @user_cruiser, cruiser_spaces)
    while placement.valid? == false
      puts "Those are invalid coordinates. Please try again:"
      puts ">"

      cruiser_spaces = gets.chomp.split(" ")
      placement = ShipPlacement.new(@user_board, @user_cruiser, cruiser_spaces)
    end

    @user_board.place(@user_cruiser, cruiser_spaces)
    puts @user_board.render(true)

    puts "Enter the squares for the Submarine (2 spaces):"
    puts ">"

    sub_spaces = gets.chomp.split(" ")

    placement = ShipPlacement.new(@user_board, @user_submarine, sub_spaces)
    while placement.valid? == false
      puts "Those are invalid coordinates. Please try again:"
      puts ">"

      sub_spaces = gets.chomp.split(" ")
      placement = ShipPlacement.new(@user_board, @user_submarine, sub_spaces)
    end

    @user_board.place(@user_submarine, sub_spaces)
    puts @user_board.render(true)
  end

  def find_winner
    if @user_cruiser.sunk? == true && @user_submarine.sunk? == true
      "I won!"
    elsif @computer_cruiser.sunk? == true && @computer_submarine.sunk? == true
      "You won!"
    else
      "No winner"
    end
  end

  def play_turns
    while find_winner == "No winner"
      turn = Turn.new(@computer_board, @user_board)
      turn.display_boards
      turn.player_shot
      turn.computer_shot
    end
    if find_winner == "I won!"
      puts "I won!"
      puts "=============COMPUTER BOARD============="
      puts @computer_board.render(true)
      puts "==============PLAYER BOARD=============="
      puts @user_board.render(true)
      start_game
    elsif find_winner == "You won!"
      puts "You won!"
      puts "=============COMPUTER BOARD============="
      puts @computer_board.render(true)
      puts "==============PLAYER BOARD=============="
      puts @user_board.render(true)
      start_game
    end
  end

end

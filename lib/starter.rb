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
    horiz_3 = []
    # vert_ords = @computer_board.cells.keys.map {|coord_1| coord_1.split("")}
    # vert_3 = []
    placement_3 = @computer_board.cells.keys
    placement_3.each_cons(3) do |coords|
      horiz_3 << coords
    end
    # vert_ords.each_cons(3) do |first, second|
    #   if (first[0].ord + first[1].ord) + 1 == (second[0].ord + second[1].ord)
    #     vert_3 << first.join
    #     vert_3 << second.join
    #   end
    # end
    horiz_2 = []
    placement_2 = @computer_board.cells.keys
    placement_2.each_cons(2) do |coords|
      horiz_2 << coords
    end
    horiz_3.delete_at(2)
    horiz_3.delete_at(2)
    horiz_3.delete_at(4)
    horiz_3.delete_at(4)
    horiz_3.delete_at(6)
    horiz_3.delete_at(6)
    horiz_2.delete_at(3)
    horiz_2.delete_at(6)
    horiz_2.delete_at(9)
    @computer_board.place(@computer_cruiser, horiz_3.sample)
    @computer_board.place(@computer_submarine, horiz_2.sample)
    require "pry"; binding.pry
  end

end

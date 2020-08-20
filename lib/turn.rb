class Turn

  def initialize(board_1, board_2)
    @board_1 = board_1
    @board_2 = board_2
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @board_1.render
    puts "==============PLAYER BOARD=============="
    puts @board_2.render
  end

  def player_shot
    puts "Enter the coordinate for your shot:"
    shot = gets.chomp
    while @board_1.cells.keys.include?(shot) == false || @board_1.cells[shot].fired_upon? == true
      puts "Please re-enter a valid coordinate. It's either invalid or you have chosen it before."
      shot = gets.chomp
    end

    @board_1.cells[shot].fire_upon

    if @board_1.cells[shot].render == "M"
      puts "Your shot on #{shot} was a miss."
    elsif @board_1.cells[shot].render == "H" || @board_1.cells[shot].render == "X"
      puts "Your shot on #{shot} was a hit."
    end
  end

  def computer_shot
    shot = @board_2.cells.keys.sample
    while @board_2.cells[shot].fired_upon?
      shot = @board_2.cells.keys.sample
    end
     puts "My turn. I choose #{shot}"
     @board_2.cells[shot].fire_upon

     if @board_2.cells[shot].render == "M"
       puts "My shot on #{shot} was a miss."
     elsif @board_2.cells[shot].render == "H" || @board_2.cells[shot].render == "X"
       puts "My shot on #{shot} was a hit."
     end
   end

end

require './lib/ship'
require './lib/cell'
require './lib/board'
require 'minitest/autorun'
require 'minitest/pride'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_board_has_cells
    board = Board.new

    board.cells

    assert_equal 16, board.cells.count
  end

  def test_board_can_validate_coordinates
    board = Board.new

    board.cells

    assert_equal true, board.valid_coordinate?("A1")
    assert_equal true, board.valid_coordinate?("D4")
    assert_equal false, board.valid_coordinate?("A5")
    assert_equal false, board.valid_coordinate?("E1")
    assert_equal false, board.valid_coordinate?("A22")
  end

  def test_board_can_validate_placements
    board = Board.new

    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    assert_equal false, board.valid_placement?(cruiser, ["A1", "A2"])
    assert_equal false, board.valid_placement?(submarine, ["A2", "A3", "A4"])
  end

end

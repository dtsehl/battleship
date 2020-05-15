require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/ship_placement'
require 'minitest/autorun'
require 'minitest/pride'

class BoardTest < Minitest::Test
  def test_it_exists
    board = Board.new

    assert_instance_of Board, board
  end

  def test_board_has_cells
    board = Board.new
    board.create_cells

    assert_equal 16, board.cells.count
    assert_instance_of Hash, board.cells
  end

  def test_board_can_validate_coordinates
    board = Board.new

    board.create_cells

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
    board.create_cells

    invalid_placement_1 = ShipPlacement.new(board, cruiser, ["A1", "A2"])

    assert_equal false, invalid_placement_1.valid?

    invalid_placement_2 = ShipPlacement.new(board, submarine, ["A2", "A3", "A4"])

    assert_equal false, invalid_placement_2.valid?
  end

  def test_if_ship_placement_coordinates_are_consecutive
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.create_cells

    invalid_placement_1 = ShipPlacement.new(board, cruiser, ["A1", "A2", "A4"])

    assert_equal false, invalid_placement_1.valid?

    invalid_placement_2 = ShipPlacement.new(board, submarine, ["A1", "C1", "A4"])

    assert_equal false, invalid_placement_2.valid?

    invalid_placement_3 = ShipPlacement.new(board, cruiser, ["A3", "A2", "A1"])

    assert_equal false, invalid_placement_3.valid?

    invalid_placement_4 = ShipPlacement.new(board, submarine, ["C1", "B1"])

    assert_equal false, invalid_placement_4.valid?
  end

  def test_ship_placement_coordinates_cannot_be_diagonal
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.create_cells

    invalid_placement_1 = ShipPlacement.new(board, cruiser, ["A1", "B2", "C3"])

    assert_equal false, invalid_placement_1.valid?

    invalid_placement_2 = ShipPlacement.new(board, submarine, ["C2", "D3"])

    assert_equal false, invalid_placement_2.valid?
  end

  def test_ship_placement_can_be_valid
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.create_cells

    valid_placement_1 = ShipPlacement.new(board, submarine, ["A1", "A2"])

    assert_equal true, valid_placement_1.valid?

    valid_placement_2 = ShipPlacement.new(board, cruiser, ["B1", "C1", "D1"])

    assert_equal true, valid_placement_2.valid?
  end

  def test_cell_on_board_has_ship_after_placing
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)

    board.create_cells

    board.place(cruiser, ["A1", "A2", "A3"])

    cell_1 = board.cells["A1"]
    cell_2 = board.cells["A2"]
    cell_3 = board.cells["A3"]

    assert_equal cruiser, cell_1.ship
    assert_equal cruiser, cell_2.ship
    assert_equal cruiser, cell_3.ship
    assert_equal true, cell_3.ship == cell_2.ship
  end

  def test_ships_cannot_overlap
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.create_cells
    board.place(cruiser, ["A1", "A2", "A3"])

    invalid_placement_1 = ShipPlacement.new(board, submarine, ["A1", "B1"])

    assert_equal false, invalid_placement_1.valid?
  end

end

require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/ship_placement'
require 'minitest/autorun'
require 'minitest/pride'

class ShipPlacementTest < Minitest::Test
  def test_it_exists
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.create_cells

    placement = ShipPlacement.new(board, cruiser, ["A1", "A2", "A3"])

    assert_instance_of ShipPlacement, placement
  end

  def test_valid_length_returns_T_F
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    valid_placement = ShipPlacement.new(board, cruiser, ["A1", "A2", "A3"])


    assert_equal true, valid_placement.valid_length?

    invalid_placement = ShipPlacement.new(board, submarine, ["A1", "A2", "A3"])

    assert_equal false, invalid_placement.valid_length?
  end

  def test_overlapping_ships_returns_T_F
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    submarine = Ship.new("Submarine", 2)
    board.create_cells
    board.place(cruiser, ["A1", "A2", "A3"])

    invalid_placement = ShipPlacement.new(board, submarine, ["A1", "A2"])

    assert_equal true, invalid_placement.overlapping_ships?

    valid_placement = ShipPlacement.new(board, submarine, ["B1", "B2"])

    assert_equal false, valid_placement.overlapping_ships?

    invalid_placement_2 = ShipPlacement.new(board, submarine, ["A1", "B1"])

    assert_equal true, invalid_placement_2.overlapping_ships?
  end

  def test_diagonal_ship_placement_doesnt_work
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.create_cells

    invalid_placement = ShipPlacement.new(board, cruiser, ["A1", "B2", "C3"])

    assert_equal false, invalid_placement.is_not_diagonal?

    valid_placement = ShipPlacement.new(board, cruiser, ["A1", "A2", "A3"])

    assert_equal true, valid_placement.is_not_diagonal?
  end

  def test_garbage_placement_is_invalid
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.create_cells

    invalid_placement = ShipPlacement.new(board, cruiser, ["Z1", "Z2", "Z3"])

    assert_equal true, invalid_placement.is_garbage?

    valid_placement = ShipPlacement.new(board, cruiser, ["A1", "A2", "A3"])

    assert_equal true, valid_placement.is_not_diagonal?
  end

  def test_valid_works
    board = Board.new
    cruiser = Ship.new("Cruiser", 3)
    board.create_cells

    valid_placement = ShipPlacement.new(board, cruiser, ["A1", "A2", "A3"])

    assert_equal true, valid_placement.valid?

    invalid_placement = ShipPlacement.new(board, cruiser, ["A1", "A2", "C3"])

    assert_equal false, invalid_placement.valid?
  end

end

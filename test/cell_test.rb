require './lib/ship'
require './lib/cell'
require 'minitest/autorun'
require 'minitest/pride'

class CellTest < Minitest::Test
  def test_it_exists
    cell = Cell.new("B4")

    assert_instance_of Cell, cell
  end

  def test_it_can_return_cell_coordinate
    cell = Cell.new("B4")

    assert_equal "B4", cell.coordinate
  end

  def test_cell_defaults_to_not_having_ship
    cell = Cell.new("B4")

    assert_nil nil, cell.ship
  end

  def test_cell_defaults_to_empty
    cell = Cell.new("B4")

    assert_equal true, cell.empty?
  end

  def test_ship_can_be_placed_on_cell
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    assert_equal cruiser, cell.ship
    assert_equal false, cell.empty?
  end

  def test_cell_defaults_to_not_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)

    assert_equal false, cell.fired_upon?
  end

  def test_cell_can_be_fired_upon
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)

    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal 2, cruiser.health
    assert_equal true, cell.fired_upon?
  end

  def test_if_cell_can_be_rendered_as_period_if_not_fired_upon
    cell = Cell.new("B4")

    assert_equal ".", cell.render
  end

  def test_if_a_cell_can_be_rendered_as_M_if_cell_fired_upon_and_missed
    cell = Cell.new("B4")

    cell.fire_upon

    assert_equal "M", cell.render
  end

  def test_if_a_cell_can_be_rendered_as_S_if_cell_fired_upon_and_has_ship_with_optional_boolean
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)

    assert_equal ".", cell.render
    assert_equal "S", cell.render(true)
  end

  def test_if_a_cell_can_be_rendered_as_H_if_ship_hit
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon

    assert_equal "H", cell.render
    assert_equal false, cruiser.sunk?
  end

  def test_if_a_cell_can_be_rendered_as_X_and_ship_sunk
    cell = Cell.new("B4")
    cruiser = Ship.new("Cruiser", 3)
    cell.place_ship(cruiser)
    cell.fire_upon
    cruiser.hit
    cruiser.hit


    assert_equal "X", cell.render
    assert_equal true, cruiser.sunk?
  end

end

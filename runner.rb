require './lib/ship'
require './lib/cell'
require './lib/board'
require './lib/ship_placement'

board = Board.new
cruiser = Ship.new("Cruiser", 3)
submarine = Ship.new("Submarine", 2)
board.create_cells
board.place(cruiser, ["A1", "A2", "A3"])
board.render

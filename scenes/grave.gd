extends TileMap


@export var cell_size = Vector2i(12, 12)

var astar_grid = AStarGrid2D.new()
var grid_size
var first_cell = Vector2i(-19,-11)
var last_cell = Vector2i(18,11)
var start = Vector2i.ZERO
var end = Vector2i(5, 5)

func _ready():
	astar_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	initialize_grid()

func initialize_grid():
	
	grid_size = Vector2i(38, 23)
	astar_grid.size = grid_size
	astar_grid.region = Rect2i(first_cell.x, first_cell.y, 38*12,23*12)
	astar_grid.cell_size = Vector2i(1,1)
	astar_grid.update()
	for i in range(39):
		for j in range(24):
			var cell = Vector2i(i,j) + first_cell
			if !is_tile_walkable(cell):
				astar_grid.set_point_solid(cell, not astar_grid.is_point_solid(cell))


func is_tile_walkable(pos):
	
	var walkable_0 = get_cell_tile_data(0,pos).get_custom_data("walkable")
	var walkable_1 = get_cell_tile_data(1,pos)
	if !walkable_0:
		return false
	if walkable_1 != null:
		if !walkable_1.get_custom_data("walkable"):
			return false
	return true
	

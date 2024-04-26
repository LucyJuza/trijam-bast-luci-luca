extends Node2D

func _draw():
	pass
	#draw_grid()
	#fill_walls()
	
func draw_grid():
	var parent = get_parent()
	for x in parent.grid_size.x + 1:
		draw_line(Vector2(x * parent.cell_size.x, 0),
			Vector2(x * parent.cell_size.x, parent.grid_size.y * parent.cell_size.y),
			Color.DARK_GRAY, 2.0)
		for y in parent.grid_size.y + 1:
			draw_line(Vector2(0, y * parent.cell_size.y),
			Vector2(parent.grid_size.x * parent.cell_size.x, y * parent.cell_size.y),
			Color.DARK_GRAY, 2.0)
			
func fill_walls():
	var parent = get_parent()
	for x in parent.grid_size.x:
		for y in parent.grid_size.y:
			if parent.astar_grid.is_point_solid(Vector2i(x, y)):
				draw_rect(Rect2(x * parent.cell_size.x, y * parent.cell_size.y, parent.cell_size.x, parent.cell_size.y), Color.DARK_GRAY)

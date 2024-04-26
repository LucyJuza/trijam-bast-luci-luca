extends Node2D

@export var linked_tile_map: TileMap
@export var player: Node2D
@export var timer : Timer

func _ready():
	timer.timeout.connect(_on_timer_timeout)

func update_path():
	return PackedVector2Array(linked_tile_map.astar_grid.get_point_path(keeper_grid_pos(), player_grid_pos()))

func keeper_grid_pos():
	return linked_tile_map.local_to_map(global_position)

func player_grid_pos():
	return linked_tile_map.local_to_map(player.global_position)

func _on_timer_timeout():
	var next_cell = update_path()
	if next_cell.size() > 1:
		global_position = linked_tile_map.map_to_local(next_cell[1])
		
func _process(delta):
	if (player.global_position + Vector2(6,6) == global_position):
		Global.game_over()

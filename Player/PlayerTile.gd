extends TileMap

export (PackedScene) var player


func setup_player():
	var player_cell = get_used_cells()
	for cell in player_cell:
		var index = get_cell(cell.x, cell.y)
		var tile_name = tile_set.tile_get_name(index)
		match tile_name:
			"Player":
				create_player_from_tilemap(cell, player)


func create_player_from_tilemap(coordinates: Vector2, prefab: PackedScene):
	if !get_parent().in_editor:
		set_cellv(coordinates, -1)
	var pf = prefab.instance()
	pf.global_position = to_global(map_to_world(coordinates))
	get_parent().get_node("PlacedPlayer").add_child(pf)


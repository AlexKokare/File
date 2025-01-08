class_name King
extends "res://class_figyr/base_figyra.gd"


func get_king_moves(position: int, rows: int, columns: int) -> Array:
	var moves = []
	var x = position % columns
	var y = position / columns

	# Соседние клетки (включая диагонали)
	var directions = [
		Vector2(-1, -1), Vector2(0, -1), Vector2(1, -1),
		Vector2(-1,  0),                Vector2(1,  0),
		Vector2(-1,  1), Vector2(0,  1), Vector2(1,  1)
	]

	for direction in directions:
		var new_x = x + direction.x
		var new_y = y + direction.y

		# Проверка границ поля
		if new_x >= 0 and new_x < columns and new_y >= 0 and new_y < rows:
			var new_position = int(new_y) * columns + int(new_x)
			moves.append(new_position)

	return moves

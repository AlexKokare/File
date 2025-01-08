

# Пешка
class_name Pawn
extends "res://class_figyr/base_figyra.gd"

var is_white: bool  # Цвет пешки, белая или чёрная

func get_valid_moves(board_size: int) -> Array:
	var moves = []
	var direction = -1 if is_white else 1
	var forward_position = position + Vector2(0, direction)
	if forward_position.x >= 0 and forward_position.x < board_size and forward_position.y >= 0 and forward_position.y < board_size:
		moves.append(forward_position)
	return moves

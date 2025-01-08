class_name Bishop
extends "res://class_figyr/base_figyra.gd"

func get_valid_moves(board_size: int) -> Array:
	return _get_diagonal_moves(board_size)

class_name Rook
extends "res://class_figyr/base_figyra.gd"

func get_valid_moves(board_size: int) -> Array:
	return _get_line_moves(board_size)

# Слон

# Общие вспомогательные методы для ладьи, ферзя и слона

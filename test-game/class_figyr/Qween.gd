# Ферзь
class_name Queen
extends "res://class_figyr/base_figyra.gd"

func get_valid_moves(board_size: int) -> Array:
	var moves = []
	moves += _get_line_moves(board_size)
	moves += _get_diagonal_moves(board_size)
	return moves

# Ладья

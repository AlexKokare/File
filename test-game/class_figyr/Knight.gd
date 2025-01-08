
# Конь
class_name Knight
extends "res://class_figyr/base_figyra.gd"

# Получение возможных ходов для коня
func get_moves(position: int, rows: int, columns: int) -> Array:
	var moves = []
	var x = position % columns
	var y = position / columns

	# Возможные смещения для хода коня
	var knight_moves = [
		Vector2(2, 1), Vector2(1, 2), Vector2(-1, 2), Vector2(-2, 1),
		Vector2(-2, -1), Vector2(-1, -2), Vector2(1, -2), Vector2(2, -1)
	]

	for move in knight_moves:
		var new_x = x + move.x
		var new_y = y + move.y

		# Проверяем, находится ли новая позиция в пределах поля
		if new_x >= 0 and new_x < columns and new_y >= 0 and new_y < rows:
			var new_position = int(new_y) * columns + int(new_x)
			moves.append(new_position)

	return moves

# Метод передвижения коня
func move_knight(position: int, new_position: int, rows: int, columns: int) -> int:
	var valid_moves = get_moves(position, rows, columns)
	
	if new_position in valid_moves:
		print("Конь перемещается с", position, "на", new_position)
		return new_position
	else:
		print("Ошибка: недопустимый ход для коня.")
		return position  # Возврат текущей позиции, если ход невозможен

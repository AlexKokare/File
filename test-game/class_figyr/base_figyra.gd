extends Object

class_name base_figyra

var position: Vector2 = Vector2(-1, -1)  # Начальная позиция (-1, -1 указывает на отсутствие установки)

# Установить позицию
func set_position(new_position: Vector2):
	position = new_position

# Получить текущую позицию
func get_position() -> Vector2:
	return position

func _get_line_moves(board_size: int) -> Array:
	var moves = []
	for i in range(1, board_size):
		for direction in [Vector2(1, 0), Vector2(-1, 0), Vector2(0, 1), Vector2(0, -1)]:
			var new_position = position + direction * i
			if new_position.x >= 0 and new_position.x < board_size and new_position.y >= 0 and new_position.y < board_size:
				moves.append(new_position)
			else:
				break
	return moves


func _get_diagonal_moves(board_size: int) -> Array:
	var moves = []
	for i in range(1, board_size):
		for direction in [Vector2(1, 1), Vector2(1, -1), Vector2(-1, 1), Vector2(-1, -1)]:
			var new_position = position + direction * i
			if new_position.x >= 0 and new_position.x < board_size and new_position.y >= 0 and new_position.y < board_size:
				moves.append(new_position)
			else:
				break
	return moves


# Метод для получения возможных ходов фигуры
func get_moves(position, rows, columns):
	return []  # Должен быть переопределен в наследниках

# Метод для проверки, находится ли позиция в пределах поля
func is_within_bounds(x, y, rows, columns):
	return x >= 0 and x < columns and y >= 0 and y < rows

# Метод для получения одномерного индекса из координат
func to_index(x, y, columns):
	return y * columns + x

# Метод для получения координат из одномерного индекса
func from_index(index, columns):
	return [index % columns, index / columns]

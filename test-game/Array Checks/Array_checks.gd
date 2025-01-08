extends Node

class_name ArrayChecks

# Проверка валидности индекса
func validate_index(index: int, size: int) -> bool:
	# Проверяет, находится ли индекс в пределах массива.
	return index >= 0 and index < size

# Преобразование одномерного индекса в двумерные координаты
func transform_index(index: int, columns: int) -> Vector2:
	# Преобразует одномерный индекс в двумерные координаты (x, y).
	return Vector2(index % columns, index / columns)

# Преобразование двумерных координат в одномерный индекс
func to_index(coords: Vector2, columns: int) -> int:
	# Преобразует двумерные координаты (x, y) в одномерный индекс.
	return int(coords.y) * columns + int(coords.x)

# Проверка, находится ли координата в пределах поля
func is_within_bounds(coords: Vector2, rows: int, columns: int) -> bool:
	# Проверяет, находится ли координата в пределах заданного поля.
	return coords.x >= 0 and coords.x < columns and coords.y >= 0 and coords.y < rows

# Генерация всех координат для массива
func generate_coords(rows: int, columns: int) -> Array:
	# Генерирует массив всех координат для заданных строк и столбцов.
	var coords = []
	for y in range(rows):
		for x in range(columns):
			coords.append(Vector2(x, y))
	return coords

# Преобразование одномерного массива в двумерный
func reshape_to_2d(array: Array, rows: int, columns: int) -> Array:
	# Преобразует одномерный массив в двумерный массив.
	var result = []
	for y in range(rows):
		var row = []
		for x in range(columns):
			var index = to_index(Vector2(x, y), columns)
			if index < array.size():
				row.append(array[index])
			else:
				row.append(null)  # Заполнение пустыми значениями, если размер массива меньше
		result.append(row)
	return result

# Преобразование двумерного массива в одномерный
func flatten_to_1d(array: Array) -> Array:
	# Преобразует двумерный массив в одномерный массив.
	var result = []
	for row in array:
		result += row
	return result

# Проверка корректности размеров массива
func validate_dimensions(rows: int, columns: int, size: int) -> bool:
	# Проверяет, соответствуют ли размеры массива указанному количеству строк и столбцов.
	return rows * columns == size
	
	
	# Проверка валидности индекса
func validate_index(index: int, size: int) -> bool:
	return index >= 0 and index < size

# Преобразование одномерного индекса в двумерные координаты
func transform_index(index: int, columns: int) -> Vector2:
	return Vector2(index % columns, index / columns)

# Преобразование двумерных координат в одномерный индекс
func to_index(coords: Vector2, columns: int) -> int:
	return int(coords.y) * columns + int(coords.x)

# Проверка, находится ли координата в пределах поля
func is_within_bounds(coords: Vector2, rows: int, columns: int) -> bool:
	return coords.x >= 0 and coords.x < columns and coords.y >= 0 and coords.y < rows

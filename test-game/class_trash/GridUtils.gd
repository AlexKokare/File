extends Object
class_name GridUtils

# Преобразование из координат в индекс массива
static func to_index(x: int, y: int, columns: int) -> int:
	return y * columns + x

# Преобразование из индекса массива в координаты
static func from_index(index: int, columns: int) -> Vector2:
	return Vector2(index % columns, index / columns)

# Проверка, находится ли позиция в пределах массива
static func is_within_bounds(x: int, y: int, rows: int, columns: int) -> bool:
	return x >= 0 and x < columns and y >= 0 and y < rows

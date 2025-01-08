extends BaseArrayManager

class_name SravnCell

# Хранение измененных индексов
var updated_indices: Array = []

func _ready() -> void:
	initialize(100, false)  # Инициализируем массив 10x10 как одномерный с 100 ячейками

# Обновление значения и индексов
func update_cell(index: int, value: Variant) -> void:
	if index >= 0 and index < grid.size():
		grid[index] = value
		if index not in updated_indices:
			updated_indices.append(index)

# Получение обновленных индексов
func get_updated_indices() -> Array:
	return updated_indices

# Очистка списка измененных индексов
func clear_updated_indices() -> void:
	updated_indices.clear()

# Пример действия: перемещение фигуры на шахматной доске
func move_piece(piece_type, current_position, new_position, rows, columns) -> void:
	pass

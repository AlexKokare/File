extends BaseArrayManager

class_name MassiveCell

var filled_indices: Array = []

func update_cell(index: int, value: Variant) -> void:
	# Проверяем, является ли value логическим значением
	if typeof(value) == TYPE_BOOL:
		self.update_cell(index, value)  # Вызов родительского метода
		if value:
			if index not in filled_indices:
				filled_indices.append(index)
		else:
			filled_indices.erase(index)
	else:
		push_error("update_cell: Expected a boolean value")

extends Node

class_name save

# Сохранение данных
func save_game(data: Dictionary, file_path: String = "user://game_state.json") -> void:
	var file = File.new()
	if file.open(file_path, File.WRITE) == OK:
		file.store_string(to_json(data))
		file.close()
		print("Данные успешно сохранены:", file_path)
	else:
		print("Ошибка: невозможно сохранить данные.")

# Загрузка данных
func load_game(file_path: String = "user://game_state.json") -> Dictionary:
	var file = File.new()
	if not file.file_exists(file_path):
		print("Ошибка: файл не найден:", file_path)
		return {}
	if file.open(file_path, File.READ) == OK:
		var data = parse_json(file.get_as_text())
		file.close()
		return data
	else:
		print("Ошибка: невозможно загрузить данные.")
		return {}

# Сохранение хода
func save_move(move_data: Dictionary, move_history: Array) -> void:
	move_history.append(move_data)
	print("Ход сохранен:", move_data)

# Сохранение раунда
func save_round(round_data: Dictionary, round_history: Array) -> void:
	round_history.append(round_data)
	print("Раунд сохранен:", round_data)

# Генерация текущего состояния игры
func generate_save_data(grid: Array, rows: int, columns: int, move_history: Array, round_history: Array) -> Dictionary:
	return {
		"grid": grid,
		"rows": rows,
		"columns": columns,
		"move_history": move_history,
		"round_history": round_history
	}

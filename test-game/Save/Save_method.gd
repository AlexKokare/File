extends Node

class_name SaveMethod

const ArrayChecks = preload("res://Array Checks/Array_checks.gd")

# Метод для сохранения текущего состояния игры
func save_game_state(grid: Array, rows: int, columns: int, file_path: String) -> void:
	var save_data = {
		"rows": rows,
		"columns": columns,
		"grid": []
	}

	for i in range(grid.size()):
		if ArrayChecks.validate_index(i, grid.size()):
			var cell_data = {
				"index": i,
				"position": ArrayChecks.transform_index(i, columns),
				"value": grid[i]
			}
			save_data["grid"].append(cell_data)

	if write_to_file(file_path, save_data):
		print("Сохранение завершено:", file_path)
	else:
		print("Ошибка: не удалось сохранить игру в файл.")

# Метод для загрузки состояния игры
func load_game_state(file_path: String) -> Dictionary:
	var save_data = read_from_file(file_path)
	if save_data.empty():
		print("Ошибка: загрузка не удалась.")
		return {}

	if save_data.has("grid") and save_data.has("rows") and save_data.has("columns"):
		print("Загрузка завершена:", file_path)
		return save_data
	else:
		print("Ошибка: файл поврежден или имеет неверный формат:", file_path)
		return {}

# Запись данных в файл
func write_to_file(file_path: String, data: Dictionary) -> bool:
	var file = File.new()
	if file.open(file_path, File.WRITE) == OK:
		file.store_line(to_json(data))
		file.close()
		return true
	return false

# Чтение данных из файла
func read_from_file(file_path: String) -> Dictionary:
	var file = File.new()
	if not file.file_exists(file_path):
		print("Ошибка: файл не найден:", file_path)
		return {}

	if file.open(file_path, File.READ) == OK:
		var data = parse_json(file.get_as_text())
		file.close()
		return data
	return {}

# Пример использования
func example_usage():
	var grid = ["0", "1", "0", "1", "1", "0"]
	var rows = 2
	var columns = 3
	var file_path = "user://save_game.json"

	save_game_state(grid, rows, columns, file_path)
	var loaded_data = load_game_state(file_path)
	print("Загруженные данные:", loaded_data)

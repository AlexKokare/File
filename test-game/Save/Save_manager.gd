extends Node

class_name Save_Manager

const ArrayChecks = preload("res://Array Checks/Array_checks.gd")

# Метод для сохранения текущего состояния
func save_state(grid: Array, rows: int, columns: int, file_path: String) -> void:
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

	var file = File.new()
	if file.open(file_path, File.WRITE) == OK:
		file.store_line(to_json(save_data))
		file.close()
		print("Сохранение завершено:", file_path)
	else:
		print("Ошибка: невозможно открыть файл для записи:", file_path)

# Метод для загрузки состояния
func load_state(file_path: String) -> Dictionary:
	var file = File.new()
	if not file.file_exists(file_path):
		print("Ошибка: файл не найден:", file_path)
		return {}

	if file.open(file_path, File.READ) == OK:
		var save_data = parse_json(file.get_as_text())
		file.close()

		if save_data.has("grid") and save_data.has("rows") and save_data.has("columns"):
			print("Загрузка завершена:", file_path)
			return save_data
		else:
			print("Ошибка: файл поврежден или имеет неправильный формат:", file_path)
			return {}
	else:
		print("Ошибка: невозможно открыть файл для чтения:", file_path)
		return {}

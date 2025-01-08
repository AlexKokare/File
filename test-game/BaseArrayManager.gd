extends "res://Save/save.gd"

class_name BaseArrayManager

const LogickAttack = preload("res://logick_attack/logick_attack.gd")
const BaseFigure = preload("res://class_figyr/base_figyra.gd")
const Bishop = preload("res://class_figyr/Bishop.gd")
const King = preload("res://class_figyr/King.gd")
const Knight = preload("res://class_figyr/Knight.gd")
const Pawn = preload("res://class_figyr/Pawn.gd")
const Queen = preload("res://class_figyr/Qween.gd")
const Rook = preload("res://class_figyr/Rook.gd")

# Счетчики для раундов и ходов
var moves_per_round = 3
var current_player = 1
var moves_made = 0

# Лог для хранения истории ходов и раундов
var move_history = []
var round_history = []

# Карта соответствия классов фигур их индексам
const FIGURE_CLASSES = {
	"base": 0,
	"king": 1,
	"queen": 2,
	"knight": 3,
	"rook": 4,
	"bishop": 5,
	"pawn": 6
}

# Основной массив данных (одноразмерный массив, представляющий доску)
var grid = []
var rows = 8
var columns = 8

# Экземпляр LogickAttack
var logick_attack_instance: LogickAttack

func _init():
	logick_attack_instance = LogickAttack.new()

# Инициализация массива
func initialize_grid(new_rows: int, new_columns: int):
	rows = new_rows
	columns = new_columns
	grid.resize(rows * columns)
	for i in range(grid.size()):
		grid[i] = "0"  # Пустая ячейка
	print("Массив инициализирован: ", grid)

# Получение размеров массива
func get_dimensions() -> Dictionary:
	return {"rows": rows, "columns": columns}

# Проверка валидности индекса
func validate_index(index: int) -> bool:
	return index >= 0 and index < grid.size()

# Преобразование индекса в координаты
func from_index(index: int) -> Dictionary:
	if not validate_index(index):
		return {}
	return {"row": index / columns, "column": index % columns}

# Преобразование координат в индекс
func to_index(row: int, column: int) -> int:
	if row < 0 or row >= rows or column < 0 or column >= columns:
		return -1
	return row * columns + column

# Обновление ячейки массива
func update_cell(index: int, value: String):
	if validate_index(index):
		grid[index] = value
		print("Ячейка обновлена: ", index, "=>", value)
	else:
		print("Ошибка: индекс за пределами массива.")

# Получение значения ячейки
func get_cell_value(index: int) -> String:
	if validate_index(index):
		return grid[index]
	print("Ошибка: индекс за пределами массива.")
	return ""

# Передача данных в LogickAttack
func process_attacks_and_defenses():
	var all_pieces = get_all_pieces()
	var involved_pieces = get_involved_pieces()
	logick_attack_instance.process_event(all_pieces, involved_pieces, rows)

# Получение всех фигур
func get_all_pieces() -> Array:
	var pieces = []
	for i in range(grid.size()):
		if grid[i] != "0":  # Проверяем, не пустая ли ячейка
			pieces.append(grid[i])
	return pieces

# Получение вовлеченных фигур
func get_involved_pieces() -> Array:
	var involved = []
	for i in range(grid.size()):
		if grid[i] != "0" and grid[i].has("involved") and grid[i]["involved"]:
			involved.append(grid[i])
	return involved

# Синхронизация состояний после атаки
func update_grid_from_logick_attack(updated_pieces: Array):
	for piece in updated_pieces:
		update_cell(piece.index, piece)

# Сохранение состояния массива
func save_grid_state() -> Dictionary:
	return {
		"grid": grid.duplicate(),
		"rows": rows,
		"columns": columns
	}

# Загрузка состояния массива
func load_grid_state(state: Dictionary):
	if state.has("grid") and state.has("rows") and state.has("columns"):
		grid = state["grid"]
		rows = state["rows"]
		columns = state["columns"]
		print("Состояние массива загружено.")
	else:
		print("Ошибка: некорректное состояние массива.")

# Логирование текущего состояния массива
func log_grid_state():
	print("Текущее состояние массива:")
	for row in range(rows):
		var line = ""
		for column in range(columns):
			var index = to_index(row, column)
			line += grid[index] + " "
		print(line.strip())

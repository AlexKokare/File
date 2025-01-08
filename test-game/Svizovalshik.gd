extends Node

class_name Svizovalshik

# Подключение всех скриптов
const Save = preload("res://Save/save.gd")
const SaveManager = preload("res://Save/Save_manager.gd")
const SaveMethod = preload("res://Save/Save_method.gd")
const BaseArrayManager = preload("res://BaseArrayManager.gd")
const MassiveCell = preload("res://Massive_cell/Massive_cell.gd")
const NodeScript = preload("res://node/node.gd")
const MoveScript = preload("res://move/move.gd")
const LogickAttack = preload("res://logick_attack/logick_attack.gd")
const ArrayChecks = preload("res://Array Checks/Array_checks.gd")


# Локальные экземпляры
var save_instance: Save
var save_manager_instance: SaveManager
var save_method_instance: SaveMethod
var base_array_manager_instance: BaseArrayManager
var massive_cell_instance: MassiveCell
var logick_attack_instance: LogickAttack
var array_checks_instance: ArrayChecks
var node_instance: NodeScript
var move_instance: MoveScript

func _ready():
	# Инициализация экземпляров
	save_instance = Save.new()
	save_manager_instance = SaveManager.new()
	save_method_instance = SaveMethod.new()
	base_array_manager_instance = BaseArrayManager.new()
	massive_cell_instance = MassiveCell.new()
	logick_attack_instance = LogickAttack.new()
	array_checks_instance = ArrayChecks.new()
	node_instance = NodeScript.new()
	move_instance = MoveScript.new()

	print("Связующий скрипт успешно инициализирован.")

# Метод для сохранения хода
func save_move_data(move_data: Dictionary):
	save_instance.save_game({"move": move_data}, "user://move_state.json")
	print("Ход сохранен:", move_data)

# Метод для сохранения состояния раунда
func save_round_data(round_data: Dictionary):
	save_instance.save_game({"round": round_data}, "user://round_state.json")
	print("Раунд сохранен:", round_data)

# Метод для объединения и сохранения всех данных
func save_all(game_data: Dictionary):
	save_instance.save_game(game_data, "user://complete_game_state.json")
	print("Все данные игры сохранены:", game_data)

# Метод для обновления всех скриптов
func update_all():
	base_array_manager_instance.save_state()
	massive_cell_instance.update_cells()
	logick_attack_instance.process_logic()
	node_instance.sync_nodes()
	move_instance.execute_moves()
	print("Все компоненты обновлены.")

# Метод для загрузки состояния игры
func load_game_state():
	var game_state = save_instance.load_game("user://complete_game_state.json")
	if game_state.size() > 0:
		print("Состояние игры загружено:", game_state)
		return game_state
	else:
		print("Ошибка: не удалось загрузить состояние игры.")
		return null

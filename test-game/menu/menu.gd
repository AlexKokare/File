extends Node2D



@onready var label = $CanvasLayer/Panel/Label2
@onready var timer = $Timer
@onready var timer_frezze = $Timer_frezze

@onready var BaseArrayManager = preload("res://BaseArrayManager.gd").new()


@onready var node = preload("res://node/node.gd").new()


@onready var move = preload("res://move/move.gd").new()


@onready var Massive_cell = preload("res://Massive_cell/Massive_cell.gd").new()


@onready var sravn_cell = preload("res://sravn_cell/sravn_cell.gd").new()

var score = 0

func _ready():
	start_timer()
	 # Инициализируем массив
	BaseArrayManager.initialize(25, 0)  # Создаем массив 5x5 с нулями

	# Генерация таблицы
	var table = BaseArrayManager.generate_table(5, 5)
	print("Сгенерированная таблица:\n", table)

	# Обновление ячейки
	BaseArrayManager.update_cell(12, 1)  # Обновляем индекс 12
	print("Обновленная таблица:\n", BaseArrayManager.generate_table(5, 5))






	
	
func _on_start_button_pressed() -> void:
	var mainscenetraningroom = load("res://level traning room/scene.tscn")
	get_tree().change_scene_to_packed(mainscenetraningroom)

func _on_button_test_pressed() -> void:
	reset_timer()
	var left = "left"
	print("ход произошел")

func _on_test() -> void:
	var on_boll_timer_freze
	start_timer_frezze()

func _button_massive_test() -> void:
	reset_timer()
	var right = "right"
	print("ход произошел")
	
func start_timer_frezze():
	timer_frezze.start()
	stop_timer()
func start_timer():
	timer.start()
	print("начало игры")
func stop_timer():
	timer.stop()
	print("пауза")
func reset_timer():
	timer.stop()
	timer.start()
	
func _on_timer_timeout() -> void:
	score = 1 + score
	print(score)
func _on_timer_frezze_timeout() -> void:
	score = 1 + score
	print(score)
	

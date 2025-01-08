extends Node2D

var maximum_length := 200  # Убедитесь, что переменная объявлена

var touch_down := false
var position_start := Vector2.ZERO
var position_end := Vector2.ZERO
var vector := Vector2.ZERO

func _ready() -> void:
	# Никакие сигналы не нужны для обработки ввода
	pass 

func _draw() -> void:
	draw_line(position_start, position_end, Color.BLUE, 8)  # Используем Color.BLUE
	draw_line(position_start, position_start + vector, Color.RED, 16)  # Используем Color.RED

func _reset() -> void:
	position_start = Vector2.ZERO
	position_end = Vector2.ZERO
	vector = Vector2.ZERO
	queue_redraw()  

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				touch_down = true
				position_start = event.position
			else:
				touch_down = false
				_reset()  # Сбрасываем после отпускания кнопки

	if touch_down and event is InputEventMouseMotion:
		position_end = event.position
		vector = (position_end - position_start).normalized() * maximum_length
		queue_redraw()
		check_direction()  # Проверяем направление вектора

func check_direction() -> void:
	var direction := Vector2.ZERO

	# Определяем направление вектора
	if vector.x > 0:
		direction.x = 1  # Вправо
	elif vector.x < 0:
		direction.x = -1  # Влево

	if vector.y > 0:
		direction.y = 1  # Вниз
	elif vector.y < 0:
		direction.y = -1  # Вверх

	# Выводим направление
	if direction.x != 0 and direction.y != 0:
		if direction.x == 1 and direction.y == 1:
			print("Направление: Вправо и Вниз")
		elif direction.x == 1 and direction.y == -1:
			print("Направление: Вправо и Вверх")
		elif direction.x == -1 and direction.y == 1:
			print("Направление: Влево и Вниз")
		elif direction.x == -1 and direction.y == -1:
			print("Направление: Влево и Вверх")
	else:
		if direction.x == 1:
			print("Направление: Вправо")
		elif direction.x == -1:
			print("Направление: Влево")
		if direction.y == 1:
			print("Направление: Вниз")
		elif direction.y == -1:
			print("Направление: Вверх")

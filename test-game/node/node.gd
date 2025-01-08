extends Node

var massive = [
	[0, 1, 2],
	[3, 4, 5],
	[6, 7, 8]
]

# Начальная позиция в центре массива
var current_position = Vector2(1, 1) # Это соответствует элементу 4 в 3x3 массиве
var massive_position = 4

# Функция для перемещения
func move(direction: String):
	match direction:
		"up":
			if current_position.y > 0 or current_position.x == 1:
				current_position.y -= 1
				massive_position = transform_value(1) # Обновление massive_position

		"down":
			if current_position.y < 2 or current_position.x == 1:
				current_position.y += 1
				massive_position = transform_value(7) # Обновление massive_position

		"left":
			if current_position.x > 0 or current_position.y == 1:
				current_position.x -= 1
				massive_position = transform_value(3) # Обновление massive_position

		"right":
			if current_position.x < 2 or current_position.y == 1:
				current_position.x += 1
				massive_position = transform_value(5) # Обновление massive_position

		"up_right":
			if current_position.x < 2 or  current_position.y > 0:
				current_position.x += 1
				current_position.y -= 1
				massive_position = transform_value(2) # Обновление massive_position

		"up_left":
			if current_position.x > 0 or current_position.y > 0:
				current_position.x -= 1
				current_position.y -= 1
				massive_position = transform_value(0) # Обновление massive_position

		"down_right":
			if current_position.x < 2 or current_position.y < 2:
				current_position.x += 1
				current_position.y += 1
				massive_position = transform_value(8) # Обновление massive_position

		"down_left":
			if current_position.x > 0 or current_position.y < 2:
				current_position.x -= 1
				current_position.y += 1
				massive_position = transform_value(6) # Обновление massive_position

		"zero":
			if current_position.x == 1 or current_position.y == 1:
				current_position.x = 1
				current_position.y = 1
				massive_position = transform_value(4) # Обновление massive_position

# Функция для преобразования 4 в 0 и обратно
func transform_value(value: int) -> int:
	if value == 4:
		return 4
	elif value > 4 and value < 4:
		return massive_position
	massive_position = 4
	return value

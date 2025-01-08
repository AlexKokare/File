extends Node

var M = 10 # Ширина псевдо-массива
var C = 10 # столбец

# Текущие координаты игрока
var current_row = 0
var current_column = 0
var current_position_move = Vector2(1, 1)
var index = 0


func move_player(direction: Vector2, C: int, M: int,):
	# Вычисляем новый индекс
	var new_row = current_row + direction.y
	var new_column = current_column + direction.x

	# Проверяем границы
	if new_row >= 0 and new_row < C and new_column >= 0 and new_column < M:
		current_row = new_row
		current_column = new_column
		var starii_index = index
		index = current_row * M + current_column
		return index
	else:
		print("Перемещение вне границ!")
	
	
	

func _king_input_event(event: String):
	var ver := event

	var upper = Vector2(0, -1)
	if ver == "up":
		var index = move_player(upper, C, M)
		return index
	var downer =  Vector2(0, 1)
	if ver == "down":
		var index = move_player(downer, C, M)
		return index
	var lefter = Vector2(-1, 0)
	if ver == "left":
		var index = move_player(lefter, C, M)
		return index
	var righter = Vector2(1, 0)
	if ver == "right":
		var index = move_player(righter, C, M)
		return index
	var up_righter = Vector2(1, -1)
	if ver == "up_right":
		var index = move_player(up_righter, C, M)
		return index
	var up_lefter = Vector2(-1, -1)
	if ver == "up_left":
		var index = move_player(up_lefter, C, M)
		return index
	var down_righter = Vector2(1, 1)
	if ver == "down_right":
		var index = move_player(down_righter, C, M)
		return index
	var down_lefter = Vector2(-1, 1)
	if ver =="down_left":
		var index = move_player(down_lefter, C, M)
		return index
	var zeroer = Vector2(0, 0)
	if ver =="zero":
		var index = move_player(zeroer, C, M)
		return index
	
	

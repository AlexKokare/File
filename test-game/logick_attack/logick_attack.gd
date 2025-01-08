extends Object
class_name EventHandler

# Обработка события
func process_event(all_pieces: Array, involved_pieces: Array, M: int):
	if not validate_pieces(involved_pieces):
		return

	var attackers = involved_pieces.filter(func(piece): return piece is Attacker)
	var defenders = involved_pieces.filter(func(piece): return piece is Defender)

	_reset_defender_states(defenders)

	for attacker in attackers:
		_process_line_attack(attacker, all_pieces, M)
		for defender in defenders:
			if attacker.index == defender.index:
				_process_attack_on_cell(attacker, defender, all_pieces)
			elif attacker.index.distance_to(defender.index) == 1:
				_process_adjacent_interaction(attacker, defender)

	_process_collisions(attackers, _process_attacker_vs_attacker)
	_process_collisions(defenders, _process_defender_vs_defender)

# Сброс состояния защитников
func _reset_defender_states(defenders: Array):
	for defender in defenders:
		if defender.has_method("reset_attack_state"):
			defender.reset_attack_state()

# Обработка атаки на клетке
func _process_attack_on_cell(attacker: Attacker, defender: Defender, all_pieces: Array):
	var original_positions = save_positions([attacker, defender])

	# Проверка на отражение атаки защитником
	if defender.can_reflect_attack(attacker):
		print("Attack reflected. Returning to original positions.")
		restore_positions(original_positions)
		return

	# Сначала урон получает нападающий
	attacker.take_damage(defender.attack_power)
	print("Attacker took damage:", defender.attack_power)

	if not attacker.is_alive():
		print("Attacker defeated before dealing damage.")
		return

	# Если нападающий выжил, урон получает защитник
	defender.take_damage(attacker.attack_power)
	print("Defender took damage:", attacker.attack_power)

	if not defender.is_alive():
		attacker.index = defender.index
		print("Defender defeated. Attacker moved to defender's position.")
		_process_secondary_defense(attacker, all_pieces)
	else:
		print("Defender survived. Returning to original positions.")
		restore_positions(original_positions)

# Обработка вторичной защиты
func _process_secondary_defense(attacker: Attacker, all_pieces: Array):
	for piece in all_pieces:
		if piece is Defender and piece.index == attacker.index and not piece.has_attacked:
			print("Secondary defender found at position:", piece.index)
			_process_attack_on_cell(attacker, piece, all_pieces)
			return

# Обработка взаимодействия на соседних клетках
func _process_adjacent_interaction(attacker: Attacker, defender: Defender):
	if not defender.has_attacked:
		defender.has_attacked = true
		attacker.take_damage(defender.attack_power)
		print("Defender attacked attacker. Attacker took damage:", defender.attack_power)

# Обработка столкновения нападающих
func _process_attacker_vs_attacker(attacker1: Attacker, attacker2: Attacker):
	attacker1.take_damage(attacker2.attack_power)
	attacker2.take_damage(attacker1.attack_power)
	print("Both attackers took damage.")

	if not attacker1.is_alive():
		print("Attacker1 defeated.")
	if not attacker2.is_alive():
		print("Attacker2 defeated.")

# Обработка столкновения защитников
func _process_defender_vs_defender(defender1: Defender, defender2: Defender):
	if defender1.attack_power > defender2.attack_power:
		defender2.take_damage(defender1.attack_power - defender2.attack_power)
		print("Defender2 took damage from Defender1.")
	elif defender2.attack_power > defender1.attack_power:
		defender1.take_damage(defender2.attack_power - defender1.attack_power)
		print("Defender1 took damage from Defender2.")
	else:
		print("No damage. Both defenders have equal attack power.")

# Обработка столкновений
func _process_collisions(pieces: Array, collision_handler: Callable):
	for i in range(pieces.size()):
		for j in range(i + 1, pieces.size()):
			collision_handler.call(pieces[i], pieces[j])

# Проверка корректности фигур
func validate_pieces(pieces: Array) -> bool:
	for piece in pieces:
		if not piece.has_method("index"):
			print("Invalid piece detected:", piece)
			return false
	return true

# Сохранение оригинальных позиций
func save_positions(pieces: Array) -> Dictionary:
	var positions = {}
	for piece in pieces:
		if piece.has_method("index"):
			positions[piece] = piece.index
	return positions

# Восстановление позиций
func restore_positions(positions: Dictionary):
	for piece in positions.keys():
		if piece.has_method("move_to"):
			piece.move_to(positions[piece])

# Атака по линии с первым препятствием
func _process_line_attack(attacker: Attacker, all_pieces: Array, M: int):
	var start_index = attacker.index
	var direction = attacker.attack_direction
	while true:
		start_index += direction
		if start_index < 0 or start_index >= M * M:
			print("Attack went out of bounds.")
			return
		for piece in all_pieces:
			if piece.index == start_index:
				if piece is Defender:
					print("Attacker at index", attacker.index, "attacking defender at index", piece.index)
					_process_attack_on_cell(attacker, piece, all_pieces)
					return
				else:
					print("Attack stopped by obstacle at index", piece.index)
					return
		print("No targets found in attack range.")

# Расчет индекса на основе строки и столбца
func calculate_index(row: int, column: int, M: int) -> int:
	return row * M + column

# Ловушки и преграды
func check_trap_or_obstacle(position: Vector2, all_pieces: Array):
	for piece in all_pieces:
		if piece.index == position and piece.has_method("is_trap") and piece.is_trap():
			print("Trap activated at position:", position)
			return true
	return false
	
	


func process_event(all_pieces: Array, involved_pieces: Array, M: int):
var conflict_map = {}  # Карта для всех индексов и конфликтов
# Создаем ConflictQueue для каждого индекса
for piece in involved_pieces:
	var queue: ConflictQueue
	if piece.index in conflict_map:
		queue = conflict_map[piece.index]
	else:
		queue = ConflictQueue.new()
		queue.index = piece.index
		conflict_map[piece.index] = queue
	queue.add_participant(piece)
# Обрабатываем конфликты
for index in conflict_map.keys():
	var queue = conflict_map[index]
	queue.sort_attackers()  # Сортируем атакеров
	queue.process_conflict()  # Обрабатываем конфликт
оверка корректности фигур
 validate_pieces(pieces: Array) -> bool:
for piece in pieces:
	if not piece.has_method("index"):
		print("Invalid piece detected:", piece)
		return false
return true
вушки и преграды
 check_trap_or_obstacle(position: Vector2, all_pieces: Array):
for piece in all_pieces:
	if piece.index == position and piece.has_method("is_trap") and piece.is_trap():
		print("Trap activated at position:", position)
		return true
return false
имер класса ConflictQueue
var index: int               # Индекс на поле
var participants: Array = [] # Участники, попавшие в очередь
# Добавление участника в очередь
func add_participant(unit: Unit):
	if unit is Defender and not has_defender():
		participants.insert(0, unit)  # Защитник всегда первый
		print("Defender added to index", index)
	elif unit is Attacker:
		participants.append(unit)  # Атакеры добавляются в конец
		print("Attacker added to index", index)
	else:
		print("Unknown unit type:", unit)
# Проверка наличия защитника
func has_defender() -> bool:
	if participants.size() > 0 and participants[0] is Defender:
		return true
	return false
# Сортировка атакеров по очередности (например, по атаке)
func sort_attackers():
	if has_defender():
		var attackers = participants.slice(1)  # Убираем защитника
		attackers.sort_custom(self, "_compare_attackers")
		participants = [participants[0]] + attackers
	else:
		participants.sort_custom(self, "_compare_attackers")
# Пользовательская сортировка атакеров
func _compare_attackers(a: Attacker, b: Attacker) -> int:
	return b.attack_power - a.attack_power  # Сначала атакеры с большей атакой
# Обработка конфликта
func process_conflict():
	if participants.size() == 0:
		print("No participants to process at index:", index)
		return
	print("Processing conflict at index:", index)
	for i in range(participants.size()):
		if i == 0 and has_defender():
			var defender = participants[i]
			print("Defender processing:", defender)
			# Логика защитника
		else:
			var attacker = participants[i]
			print("Attacker processing:", attacker)
			# Логика атакера

extends Object
class_name ConflictQueue

var index: int               # Индекс на поле
var participants: Array = [] # Участники, попавшие в очередь

# Добавление участника в очередь
func add_participant(unit: ChessPiece):
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

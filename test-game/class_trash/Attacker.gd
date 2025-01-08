extends "res://class_trash/ChessPiece.gd"
class_name Attacker


var attack_power: int
var attack_direction: int  # Направление атаки (индекс)

# Выполнение атаки
func perform_attack(target: Defender):
	if not target.is_alive():
		print("Target already defeated.")
		return

	if target.can_reflect_attack(self):
		print("Attack reflected by defender at index:", target.index)
		if not is_alive():
			die()
		return

	# Наносим урон защитнику
	target.take_damage(attack_power)
	print("Defender took damage:", attack_power)

	if target.is_alive():
		# Защитник выжил и наносит ответный урон
		take_damage(target.attack_power)
		print("Attacker took counter damage:", target.attack_power)

		if not is_alive():
			die()
	else:
		# Защитник уничтожен, перемещаем нападающего
		index = target.index
		print("Defender defeated. Attacker moved to defender's position.")

# Логика специальной атаки
func special_attack(targets: Array):
	for target in targets:
		if target is Defender:
			perform_attack(target)
	print("Special attack executed.")

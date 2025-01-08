extends "res://class_trash/ChessPiece.gd"
class_name Defender

var has_attacked: bool = false
var defense_power: int = 1
var reflect_limit: int = 2  # Лимит отражений за ход
var reflect_count: int = 0  # Текущий счетчик отражений

# Сбрасываем состояние защиты
func reset_attack_state():
	has_attacked = false
	reflect_count = 0

# Проверяем возможность отражения атаки
func can_reflect_attack(attacker: Attacker) -> bool:
	if reflect_count >= reflect_limit:
		print("Reflect limit reached. Attack not reflected.")
		return false

	if defense_power > attacker.attack_power:
		reflect_count += 1
		print("Attack reflected by defender. Reflect count:", reflect_count)
		return true

	return false

# Дополнительная логика для защитника
func special_defense_logic():
	print("Additional defense mechanics can be implemented here.")

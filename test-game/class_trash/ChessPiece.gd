extends Object
# Базовый класс для игровых фигур
class_name ChessPiece

var health: int = 100          # Здоровье юнита
var max_health: int = 100      # Максимальное здоровье юнита
var index: int = -1            # Текущая позиция юнита на поле
var team: int = 0              # Команда (0 - нейтральный, 1 - атакующий, 2 - защитник)
var attack_power: int = 10     # Сила атаки
var defense_power: int = 5     # Защита от урона
var alive: bool = true         # Статус жизни

# Получение урона
func take_damage(amount: int):
	var damage = max(amount - defense_power, 0)  # Учитываем защиту
	health -= damage
	print(self, "took damage:", damage, "Remaining health:", health)

	if health <= 0:
		health = 0
		die()

# Метод смерти
func die():
	if alive:
		alive = false
		print(self, "at index", index, "has died.")
		_on_death()

# Событие при смерти (может быть переопределено)
func _on_death():
	print("Default death behavior for", self)

# Проверка состояния
func is_alive() -> bool:
	return health > 0

# Восстановление здоровья (при необходимости)
func heal(amount: int):
	if not alive:
		print(self, "cannot be healed because it's dead.")
		return

	health = min(health + amount, max_health)
	print(self, "healed by", amount, "Current health:", health)

# Передвижение юнита
func move_to(new_index: int):
	if not alive:
		print(self, "cannot move because it's dead.")
		return

	index = new_index
	print(self, "moved to index:", new_index)

# Атака другого юнита
func attack(target: ChessPiece):
	if not alive:
		print(self, "cannot attack because it's dead.")
		return

	if not target.is_alive():
		print("Target at index", target.index, "is already dead.")
		return

	target.take_damage(attack_power)
	print(self, "attacked target at index", target.index, "with", attack_power, "damage.")
	
	

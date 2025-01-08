# CellObject.gd
extends Object

# Класс для клетки игрового поля
class_name CellObject

# Свойства
var position: Vector2
var is_occupied: bool = false
var occupant: ChessPiece = null
var is_highlighted: bool = false  # Подсвечена ли клетка для хода

# Проверка, является ли клетка ловушкой
func is_trap() -> bool:
	return false  # По умолчанию клетка не является ловушкой

# Проверка, содержит ли клетка препятствие
func has_obstacle() -> bool:
	return false  # По умолчанию клетка не содержит препятствия

# Проверка, можно ли разместить фигуру на клетке
func can_place_piece(piece: ChessPiece) -> bool:
	return not is_occupied and not has_obstacle()

# Метод для установки фигуры на клетку
func place_piece(piece: ChessPiece):
	if not can_place_piece(piece):
		print("Cannot place piece on cell at", position, "- occupied or blocked.")
		return
	occupant = piece
	is_occupied = true
	print("Placed", piece, "on cell at", position)

# Метод для удаления фигуры с клетки
func remove_piece():
	if not is_occupied:
		print("Attempted to remove piece, but cell at", position, "is already empty.")
		return
	print("Removed", occupant, "from cell at", position)
	occupant = null
	is_occupied = false

# Метод для получения объекта на клетке
func get_occupant() -> ChessPiece:
	return occupant

# Подсветка клетки
func highlight():
	is_highlighted = true
	print("Cell at", position, "is now highlighted.")

# Убрать подсветку клетки
func remove_highlight():
	is_highlighted = false
	print("Highlight removed from cell at", position)
	
	
	

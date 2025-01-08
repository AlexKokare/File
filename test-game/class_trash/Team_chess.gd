extends Object

class_name Team_chess

var name: String
var max_moves: int
var figures: Array = []
var friendly_teams: Array = []
var enemy_teams: Array = []

func _init(team_name: String, max_moves_per_turn: int):
	name = team_name
	max_moves = max_moves_per_turn

func add_figure(figure):
	figures.append(figure)

func is_friendly(team: Team_chess) -> bool:
	return friendly_teams.has(team)

func is_enemy(team: Team_chess) -> bool:
	return enemy_teams.has(team)

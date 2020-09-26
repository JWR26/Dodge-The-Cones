extends Label


func _ready():
	Gamedata.level += 1
	text = text % [Gamedata.level]

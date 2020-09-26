extends Label


func _ready():
	text = text % [Gamedata.total_score]

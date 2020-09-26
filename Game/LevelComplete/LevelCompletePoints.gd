extends Label


func _ready():
	Gamedata.level_completed = 100
	text = text % [Gamedata.level_completed] 

func _process(delta):
	pass

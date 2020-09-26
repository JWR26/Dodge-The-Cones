extends Label


func _ready():
	text = text % [Gamedata.level_points] 

func _process(delta):
	pass

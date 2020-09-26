extends Label


func _ready():
	Gamedata.total_score += Gamedata.level_points + Gamedata.level_completed
	text = text % [Gamedata.total_score] 

func _process(delta):
	pass

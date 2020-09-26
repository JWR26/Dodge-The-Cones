extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	if Gamedata.total_score > Gamedata.high_score:
		Gamedata.high_score = Gamedata.total_score
		visible = true
	else:
		visible = false
		

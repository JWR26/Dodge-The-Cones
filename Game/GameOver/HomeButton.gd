extends TextureButton

var home = "res://Menu/MainMenu.tscn"

func _ready():
	pass


func _on_HomeButton_button_up():
	if Gamedata.total_score > Gamedata.high_score:
		Gamedata.high_score = Gamedata.total_score
	get_tree().change_scene(home)

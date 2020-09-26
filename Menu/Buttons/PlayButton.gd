extends TextureButton

# this is the filepath for starting a new game stored as a variable
var new_game = "res://Game/GameScreen.tscn"

func _ready() -> void:
	Gamedata.level = 0
	Gamedata.total_score = 0

# press the button to start a new game
func _on_PlayButton_button_up() -> void:
	var _temp = get_tree().change_scene(new_game)


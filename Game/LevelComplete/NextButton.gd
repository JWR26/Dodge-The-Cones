extends TextureButton

# this is the filepath for starting a new game stored as a variable
var next = "res://Game/GameScreen.tscn"

func _ready() -> void:
	pass

# press the button to start a new level
func _on_NextButton_button_up():
	get_tree().change_scene(next)

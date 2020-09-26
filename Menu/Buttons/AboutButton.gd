extends TextureButton

var about = "res://Menu/About.tscn"

func _ready() -> void:
	pass 

# press the button to go to the about screen
func _on_AboutButton_button_up():
	var _temp = get_tree().change_scene(about)

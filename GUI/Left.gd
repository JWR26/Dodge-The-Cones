extends TextureButton


signal move_left

func _ready():
	pass # Replace with function body.


func _on_Left_pressed():
	emit_signal("move_left")

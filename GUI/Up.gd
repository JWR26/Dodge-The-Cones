extends TextureButton


signal move_up

func _ready():
	pass # Replace with function body.


func _on_Up_pressed():
	emit_signal("move_up")


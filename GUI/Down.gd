extends TextureButton


signal move_down

func _ready():
	pass # Replace with function body.


func _on_Down_pressed():
	emit_signal("move_down")

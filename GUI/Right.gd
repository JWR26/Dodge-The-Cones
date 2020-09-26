extends TextureButton


signal move_right

func _ready():
	pass # Replace with function body.


func _on_Right_pressed():
	emit_signal("move_right")

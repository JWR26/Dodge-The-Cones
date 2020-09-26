extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	bonus_points()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func bonus_points() -> void:
	$VBoxContainer/HBoxContainer/Point5.visible = true
	$VBoxContainer/HBoxContainer/Point4.visible = true
	$VBoxContainer/HBoxContainer/Point3.visible = true
	$VBoxContainer/HBoxContainer/Point2.visible = true
	$VBoxContainer/HBoxContainer/Point1.visible = true
	if Gamedata.point_count >= 1:
		$VBoxContainer/HBoxContainer/Point5.visible = false
	if Gamedata.point_count >= 2:
		$VBoxContainer/HBoxContainer/Point4.visible = false
	if Gamedata.point_count >= 3:
		$VBoxContainer/HBoxContainer/Point3.visible = false
	if Gamedata.point_count >= 4:
		$VBoxContainer/HBoxContainer/Point2.visible = false
	if Gamedata.point_count >= 5:
		$VBoxContainer/HBoxContainer/Point1.visible = false

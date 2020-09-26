extends Control


# Declare member variables here. Examples:
var collected: = 0 setget set_collected


# Called when the node enters the scene tree for the first time.
func _ready():
	collected = 0
	bonus(collected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_collected(value: int) -> void:
	bonus(collected)


func bonus(value: int) -> void:
	if value >= 1:
		$GUI_Top/Left/Bonus_Points/Point1.visible = true
	if value >= 2:
		$GUI_Top/Left/Bonus_Points/Point2.visible = true
	if value >= 3:
		$GUI_Top/Left/Bonus_Points/Point3.visible = true
	if value >= 4:
		$GUI_Top/Left/Bonus_Points/Point4.visible = true
	if value == 5:
		$GUI_Top/Left/Bonus_Points/Point5.visible = true
	if value == 0:
		$GUI_Top/Left/Bonus_Points/Point1.visible = false
		$GUI_Top/Left/Bonus_Points/Point2.visible = false
		$GUI_Top/Left/Bonus_Points/Point3.visible = false
		$GUI_Top/Left/Bonus_Points/Point4.visible = false
		$GUI_Top/Left/Bonus_Points/Point5.visible = false	


func _on_update_bonus():
	collected += 1
	bonus(collected)

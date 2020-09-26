extends Area2D

var level_complete: = "res://Game/LevelComplete/LevelComplete.tscn"

func _on_Parking_area_entered(_area) -> void:
	get_tree().change_scene(level_complete)

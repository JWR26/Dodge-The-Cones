extends Control

onready var timer = $Timer
onready var bar = $Bar
onready var game_over = "res://Game/GameOver/GameOver.tscn"


func _ready():
	bar.max_value = 25
	timer.wait_time = bar.max_value + 1
	timer.start()

func _process(delta):
	bar.value = timer.time_left


func _on_Timer_timeout():
	get_tree().change_scene(game_over)

extends Node2D


signal update_bonus
signal update_coins

var game_over: = "res://Game/GameOver/GameOver.tscn"

var available_points: = 0

export (PackedScene) var Point
export (PackedScene) var Cone
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
# offset the map from the top of the screen
	$Level_map.position = Vector2(0, 96)
# set the parking at the top right corner of the map
	$Parking.position = Vector2(608, 128)
# set the player start position at the bottom left of the map
#	$Player.position = Vector2(32, 704)
# add the points to the map
	add_points()
# set the current level points to 0.
	Gamedata.level_points = 0
# set the cone count to 0 then add the cones
	Gamedata.cones = 0
	add_cones()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func add_points() -> void:
	randomize()
	var point_1 = Point.instance()
	add_child(point_1)
	var x_1 = (randi() % 2) * 64 + 32
	var y_1 = (randi() % 6 + 2) * 64 + 128
	point_1.position = Vector2(x_1, y_1)
	point_1.connect("collected", self, "point_collected")
	connect("update_coins", point_1, "update_coins")
	available_points += 1
	
	var point_2 = Point.instance()
	add_child(point_2)
	var x_2 = (randi() % 2) * 64 + 544
	var y_2 = (randi() % 6 + 2) * 64 + 128
	point_2.position = Vector2(x_2, y_2)
	point_2.connect("collected", self, "point_collected")
	connect("update_coins", point_2, "update_coins")
	available_points += 1

	var point_3 = Point.instance()
	add_child(point_3)
	var x_3 = (randi() % 6 + 2) * 64 + 32
	var y_3 = (randi() % 2) * 64 + 128
	point_3.position = Vector2(x_3, y_3)
	point_3.connect("collected", self, "point_collected")
	connect("update_coins", point_3, "update_coins")
	available_points += 1
	
	var point_4 = Point.instance()
	add_child(point_4)
	var x_4 = (randi() % 6 + 2) * 64 + 32
	var y_4 = (randi() % 2) * 64 + 640
	point_4.position = Vector2(x_4, y_4)
	point_4.connect("collected", self, "point_collected")
	connect("update_coins", point_4, "update_coins")
	available_points += 1
	
	var point_5 = Point.instance()
	add_child(point_5)
	var x_5 = (randi() % 4 + 4) * 64 + 32
	var y_5 = (randi() % 4 + 4) * 64 + 128
	point_5.position = Vector2(x_5, y_5)
	point_5.connect("collected", self, "point_collected")
	connect("update_coins", point_5, "update_coins")
	available_points += 1

	Gamedata.point_count = 5
	emit_signal("update_coins", available_points)

func add_cones() -> void:
	Gamedata.cones += 1
	var cone_1 = Cone.instance()
	add_child(cone_1)
	Gamedata.cones += 1
	var cone_2 = Cone.instance()
	add_child(cone_2)
	Gamedata.cones += 1
	var cone_3 = Cone.instance()
	add_child(cone_3)

func point_collected():
	emit_signal("update_bonus")
	available_points -= 1
	emit_signal("update_coins", available_points)

func _on_Player_game_over() -> void:
	Gamedata.level_completed = 0
	get_tree().change_scene(game_over)

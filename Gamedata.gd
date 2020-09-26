extends Node

#this is an autoload script to hold the games different variables that are used by multiple scripts

var level_completed: = 100
var level_points: = 0 setget set_level_points # this is the score achieved at the end of a level
var total_score: = 0 # this is the total score that the player has achieved on his current game
var high_score: = 0 setget set_high_score # this is the high score that will display on the games menu screen
var level: = 0.00 # this is the level number that will display on the game screen
var point_count: = 0 setget set_point_count # the number of points avaialble to be collected in the current level
var point_value: = 0 # this is the value of the points in the level

var cones: = 0

var move_speed: = 192 # the base speed for player movement
var cone_speed: = 128 # the base speed for cone movement

func set_level_points(value: int) -> void:
	level_points = value


func set_high_score(value: int) -> void:
	high_score = value


func set_point_count (value: int) -> void:
# update the point count
	point_count = value
# add the point value to the level points
	if point_count < 5:
		level_points += point_value
# reajust the point value
	if point_count > 0:
		update_point_value()
	

func update_point_value():
#  set an array with the point values based on the number of points left
	var value = [40, 20, 20, 10, 10]
# now return the point value corresponding to the number of points remaining
	if point_count == 0:
		pass
	else:
		point_value = value[point_count - 1]
	return point_value

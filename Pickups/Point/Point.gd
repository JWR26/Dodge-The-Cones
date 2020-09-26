extends Area2D

# This is the script for the point
# The point will be bronze when there are 5, turn silver when there are 3 and the last one will turn gold
# The idea behind this is to indicate the increasing value of the point as more are collected - the greater number collected the geater the reward

# This is the signal to tell the GUI that the point has been collected
signal collected

func _ready():
# when the node enters the scene tree the collected signal needs to be linked to the GUI
	pass # Replace with function body.


# when the point is collected we will connect the function to itself
func _on_Point_area_entered(_area):
# firstly update the point count as there will be one less in the tree
	Gamedata.point_count -= 1
# secondly, emit a signal to the GUI to say that the coin has been collected
	emit_signal("collected")
# the coin then deletes itself
	queue_free()
	

func update_coins(value: int) -> void:
	if value >= 4:
		$Bronze.visible = true
		$Silver.visible = false
		$Gold.visible = false
	elif value >= 2:
		$Bronze.visible = false
		$Silver.visible = true
		$Gold.visible = false
	elif value == 1:
		$Bronze.visible = false
		$Silver.visible = false
		$Gold.visible = true

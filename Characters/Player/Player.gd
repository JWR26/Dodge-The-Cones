extends Area2D

var current_pos: = Vector2()
var target_pos: = Vector2()
var move_direction: = Vector2()

var tile_size: = Vector2(64, 64)

var speed: = 0

signal game_over


func _ready() -> void:
#	snap the player to the grid
	position = position.snapped(tile_size)
#	set the player speed (this will always be the base speed)
	speed = Gamedata.move_speed
#	set the current position and the target position to the players position
	position = Vector2(32, 704)
	current_pos = position
	target_pos = position

func _process(delta: float) -> void:

	position += move_direction * speed * delta
	
	if position.distance_to(current_pos) > tile_size.x - speed * delta:
		position = target_pos
		move_direction = Vector2.ZERO
	
	if position == target_pos:
		current_pos = position
		target_pos += move_direction * tile_size
		if $"../GUI/Keypad/Left".pressed == true:
			move_left()
		if $"../GUI/Keypad/Right".pressed == true:
			move_right()
		if $"../GUI/Keypad/U&D/Up".pressed == true:
			move_up()
		if $"../GUI/Keypad/U&D/Down".pressed == true:
			move_down()

func move_left() -> void:
	if position == target_pos:
		move_direction.x = -1
		# orient the ray to the direction in which we are moving. The cast size will be the tile size so that it checks what is in the middle of the next tile
		$Path.cast_to = move_direction * tile_size
		# then need to update the raycast immediately (see help for explication)
		$Path.force_raycast_update()
		#if there is a collision player must not move so will set the move_direction vector to Zero.
		if $Path.is_colliding():
			move_direction = Vector2.ZERO
		$Sprite.play("Left")
		target_pos += move_direction * tile_size
	
	else:
		pass


func move_up():
	if position == target_pos:
		move_direction.y = -1
		# orient the ray to the direction in which we are moving. The cast size will be the tile size so that it checks what is in the middle of the next tile
		$Path.cast_to = move_direction * tile_size
		# then need to update the raycast immediately (see help for explication)
		$Path.force_raycast_update()
		#if there is a collision player must not move so will set the move_direction vector to Zero.
		if $Path.is_colliding():
			move_direction = Vector2.ZERO
		$Sprite.play("Up")
		target_pos += move_direction * tile_size
	
	else:
		pass
		

func move_down():
	if position == target_pos:
		move_direction.y = 1
		# orient the ray to the direction in which we are moving. The cast size will be the tile size so that it checks what is in the middle of the next tile
		$Path.cast_to = move_direction * tile_size
		# then need to update the raycast immediately (see help for explication)
		$Path.force_raycast_update()
		#if there is a collision player must not move so will set the move_direction vector to Zero.
		if $Path.is_colliding():
			move_direction = Vector2.ZERO
		$Sprite.play("Down")
		target_pos += move_direction * tile_size
	
	else:
		pass
		

func move_right():
	if position == target_pos:
		move_direction.x = 1
		# orient the ray to the direction in which we are moving. The cast size will be the tile size so that it checks what is in the middle of the next tile
		$Path.cast_to = move_direction * tile_size
		# then need to update the raycast immediately (see help for explication)
		$Path.force_raycast_update()
		#if there is a collision player must not move so will set the move_direction vector to Zero.
		if $Path.is_colliding():
			move_direction = Vector2.ZERO
		$Sprite.play("Right")
		target_pos += move_direction * tile_size
	
	else:
		pass
		


func _on_Player_area_entered(area):
	if area.get_collision_layer_bit(3):
		emit_signal("game_over")
		queue_free()
	else:
		pass

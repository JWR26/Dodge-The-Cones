extends Area2D

var tile_size : = Vector2(64, 64)

# declaration of the move direction variable
var move_direction: = Vector2.ZERO
# declare a backtrack variable to prevent the cone from moving back and forth between two tiles. This will contain the inverse of the previous move direction.
var backtrack: = Vector2.ZERO
# declare the cone's current and target position as a Vector2
var current_pos: = Vector2()
var target_pos: = Vector2()

# declare the move speed of the cone
var speed: = 0.0

# declaration of the directional vectors for movement
var LEFT = Vector2(-1, 0)
var RIGHT = Vector2(1, 0)
var UP = Vector2(0, -1)
var DOWN = Vector2(0, 1)


func _ready() -> void:
# snap the cone to the grid
	position = position.snapped(tile_size)
	start_position()
	cone_speed()
# set the current position and the target position to the players position
	current_pos = position
	target_pos = position

func _process(delta):

	if position == target_pos:
		current_pos = position
		_move_direction()
		target_position()
		animation()

	position += move_direction * speed * delta

	if position.distance_to(current_pos) > tile_size.x - speed * delta:
		position = target_pos

# set the start position of the cone
func start_position() -> void:
	if Gamedata.cones == 1:
		position = Vector2(96, 192)
	if Gamedata.cones == 2:
		position = Vector2(544, 192)
	if Gamedata.cones == 3:
		position = Vector2(544, 640)

# define the function to determine the move direction
func _move_direction() -> void:
# randomise first to avoid a predicatable pattern
	randomize()
	
# define an array of vectors that will contain the possible move directions
	var moveset: = PoolVector2Array()
# create a found variable to tell the cone if it has found the player
	var found: = false
# compare each movedirection with "backtrack".
# if it is different cast the "path" raycast to check for the maze walls.
# if the ray doesn't detect a colision we will append the vector to the moveset.


	if LEFT != backtrack && found == false:
		$Path.cast_to = LEFT * tile_size
		$Path.force_raycast_update()
		if $Path.is_colliding():
			pass
		else:
			$Vision.cast_to = LEFT * tile_size * 10
			$Vision.force_raycast_update()
			$PlayerDetect.cast_to = to_local($Vision.get_collision_point())
			$PlayerDetect.force_raycast_update()
			if $PlayerDetect.is_colliding():
				move_direction = LEFT
				found = true
			else:
				moveset.append(LEFT)

	if RIGHT != backtrack && found == false:
		$Path.cast_to = RIGHT * tile_size
		$Path.force_raycast_update()
		if $Path.is_colliding():
			pass
		else:
			$Vision.cast_to = RIGHT * tile_size * 10
			$Vision.force_raycast_update()
			$PlayerDetect.cast_to = to_local($Vision.get_collision_point())
			$Vision.force_raycast_update()
			if $PlayerDetect.is_colliding():
				move_direction = RIGHT
				found = true
			else:
				moveset.append(RIGHT)

	if UP != backtrack && found == false:
		$Path.cast_to = UP * tile_size
		$Path.force_raycast_update()
		if $Path.is_colliding():
			pass
		else:
			$Vision.cast_to = UP * tile_size * 10
			$Vision.force_raycast_update()
			$PlayerDetect.cast_to = to_local($Vision.get_collision_point())
			$PlayerDetect.force_raycast_update()
			if $PlayerDetect.is_colliding():
				move_direction = UP
				found = true
			else:
				moveset.append(UP)

	if DOWN != backtrack && found == false:
		$Path.cast_to = DOWN * tile_size
		$Path.force_raycast_update()
		if $Path.is_colliding():
			pass
		else:
			$Vision.cast_to = DOWN * tile_size * 10
			$Vision.force_raycast_update()
			$PlayerDetect.cast_to = to_local($Vision.get_collision_point())
			$PlayerDetect.force_raycast_update()
			if $PlayerDetect.is_colliding():
				move_direction = DOWN
				found = true
			else:
				moveset.append(DOWN)

	if found == false:
# Now select the move direction based on the options available
		if moveset.size() == 0:
			move_direction = Vector2.ZERO
		else:
			move_direction = moveset[randi() % moveset.size()]
	else:
		pass
# finally set the backtrack direction
	backtrack = move_direction * -1

# set the cones move speed - this will increase as the levels increase
func cone_speed():
	speed = Gamedata.cone_speed + (Gamedata.level * 8)
	return speed

# this function sets the Cone's target position
func target_position():
	target_pos += move_direction * tile_size
# this function will set the animation of the cone depending on if it is chasing the player or patrolling
func animation() -> void:
	if move_direction == UP:
		$AnimatedSprite.animation = "Move_up"
	if move_direction == RIGHT:
		$AnimatedSprite.animation = "Move_right"
	if move_direction == LEFT:
		$AnimatedSprite.animation = "Move_left"
	if move_direction == DOWN:
		$AnimatedSprite.animation = "Move_down"

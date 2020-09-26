extends TileMap

# this has been taken from a youtube tutorial and adapted for the game
const U = 1
const R = 2
const D = 4
const L = 8

var cell_walls = {Vector2(0, -1):U, Vector2(1,0):R, Vector2(0,1):D, Vector2(-1,0):L}

# Define the width and height of the tile map in terms of the number of tiles
var width: = 10
var height: = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	make_map()
	remove_deadends()

func make_map():
#	firstly create four separate sections (a, b, c & d) to house a 5x5 spanning tree
	var unvisited_a = []
	var stack_a = []
	var unvisited_b = []
	var stack_b = []
	var unvisited_c = []
	var stack_c = []
	var unvisited_d = []
	var stack_d = []
	clear()
	for x in range(width):
		for y in range (height):
			if x < 5 && y < 5:
				unvisited_a.append(Vector2(x,y))
				set_cellv(Vector2(x,y), U|R|D|L)
			elif x < 10 && y < 5:
				unvisited_b.append(Vector2(x,y))
				set_cellv(Vector2(x,y), U|R|D|L)
			elif x < 5 && y < 10:
				unvisited_c.append(Vector2(x,y))
				set_cellv(Vector2(x,y), U|R|D|L)
			else:
				unvisited_d.append(Vector2(x,y))
				set_cellv(Vector2(x,y), U|R|D|L)
	var current = Vector2(2,2)
	unvisited_a.erase(current)
	while unvisited_a:
		var neighbours = check_a_neighbours(current, unvisited_a)
		if neighbours.size() > 0:
			var next = neighbours[randi() % neighbours.size()]
			stack_a.append(current)
			var dir = next - current
			var current_walls = get_cellv(current) - cell_walls[dir]
			var next_walls = get_cellv(next) - cell_walls[-dir]
			set_cellv(current, current_walls)
			set_cellv(next, next_walls)
			current = next
			unvisited_a.erase(current)
		elif stack_a:
			current = stack_a.pop_back()
	current = Vector2(7,2)
	unvisited_b.erase(current)
	while unvisited_b:
		var neighbours = check_b_neighbours(current, unvisited_b)
		if neighbours.size() > 0:
			var next = neighbours[randi() % neighbours.size()]
			stack_b.append(current)
			var dir = next - current
			var current_walls = get_cellv(current) - cell_walls[dir]
			var next_walls = get_cellv(next) - cell_walls[-dir]
			set_cellv(current, current_walls)
			set_cellv(next, next_walls)
			current = next
			unvisited_b.erase(current)
		elif stack_b:
			current = stack_b.pop_back()
	current = Vector2(2,7)
	unvisited_c.erase(current)
	while unvisited_c:
		var neighbours = check_c_neighbours(current, unvisited_c)
		if neighbours.size() > 0:
			var next = neighbours[randi() % neighbours.size()]
			stack_c.append(current)
			var dir = next - current
			var current_walls = get_cellv(current) - cell_walls[dir]
			var next_walls = get_cellv(next) - cell_walls[-dir]
			set_cellv(current, current_walls)
			set_cellv(next, next_walls)
			current = next
			unvisited_c.erase(current)
		elif stack_c:
			current = stack_c.pop_back()
	current = Vector2(7,7)
	unvisited_d.erase(current)
	while unvisited_d:
		var neighbours = check_d_neighbours(current, unvisited_d)
		if neighbours.size() > 0:
			var next = neighbours[randi() % neighbours.size()]
			stack_d.append(current)
			var dir = next - current
			var current_walls = get_cellv(current) - cell_walls[dir]
			var next_walls = get_cellv(next) - cell_walls[-dir]
			set_cellv(current, current_walls)
			set_cellv(next, next_walls)
			current = next
			unvisited_d.erase(current)
		elif stack_d:
			current = stack_d.pop_back()
	
	var horizontal_l = []
	var horizontal_r = []
	var vertical_u = []
	var vertical_d = []

	for x in range(width):
		for y in range (height):
			if y == 4 and x < 4 and x > 1:
				horizontal_l.append(Vector2(x,y))
			if y == 4 and x > 6 and x < width - 1: 
				horizontal_r.append(Vector2(x,y))
			if x == 4 and y < 4 and y > 1:
				vertical_u.append(Vector2(x,y))
			if x == 4 and y > 6 and y < height - 1:
				vertical_d.append(Vector2(x,y))
			else:
				pass

	var link_up = vertical_u [randi() % vertical_u.size()]
	var target_up = link_up + Vector2(1,0)
	var dir = target_up - link_up
	var link_up_walls = get_cellv(link_up) - cell_walls[dir]
	var target_up_walls = get_cellv(target_up) - cell_walls[-dir]
	set_cellv(link_up, link_up_walls)
	set_cellv(target_up, target_up_walls)

	var link_down = vertical_d [randi() % vertical_d.size()]
	var target_down = link_down + Vector2(1,0)
	dir = target_down - link_down
	var link_down_walls = get_cellv(link_down) - cell_walls[dir]
	var target_down_walls = get_cellv(target_down) - cell_walls[-dir]
	set_cellv(link_down, link_down_walls)
	set_cellv(target_down, target_down_walls)
	
	var link_left = horizontal_l [randi() % horizontal_l.size()]
	var target_left = link_left + Vector2(0,1)
	dir = target_left - link_left
	var link_left_walls = get_cellv(link_left) - cell_walls[dir]
	var target_left_walls = get_cellv(target_left) - cell_walls[-dir]
	set_cellv(link_left, link_left_walls)
	set_cellv(target_left, target_left_walls)

	var link_right = horizontal_r [randi() % horizontal_r.size()]
	var target_right = link_right + Vector2(0,1)
	dir = target_right - link_right
	var link_right_walls = get_cellv(link_right) - cell_walls[dir]
	var target_right_walls = get_cellv(target_right) - cell_walls[-dir]
	set_cellv(link_right, link_right_walls)
	set_cellv(target_right, target_right_walls)

func check_a_neighbours(cell, unvisited_a):
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited_a:
			list.append(cell + n)
	return list

func check_b_neighbours(cell, unvisited_b):
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited_b:
			list.append(cell + n)
	return list

func check_c_neighbours(cell, unvisited_c):
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited_c:
			list.append(cell + n)
	return list

func check_d_neighbours(cell, unvisited_d):
	var list = []
	for n in cell_walls.keys():
		if cell + n in unvisited_d:
			list.append(cell + n)
	return list

func remove_deadends():
#	need a function that removes all of the dead ends from the spanning tree
#	start the same as before, but list the cells containing dead end tiles (7, 11, 13 & 14)
	var deadends = []
	for x in range(width):
		for y in range (height):
			deadends.append(Vector2(x,y))
# 	this is the loop through of all of the dead ends on the map
	while deadends:
#		randomly select one of the tiles
		var current = deadends[randi() % deadends.size()]
#		define the target cell
		var target = Vector2.ZERO
#		define the direction to move
		var dir = Vector2.ZERO
#		check that it is still a dead end
		if get_cellv(current) != 7 and get_cellv(current) != 11 and get_cellv(current) != 13 and get_cellv(current) != 14 :	
			deadends.erase(current)
		else:
#			is the cell in the first column
			if current.x == 0:
#				& is the top cell (ie the top left corner)
				if current.y == 0:
					if get_cellv(current) == 11:
						dir = Vector2(1,0)
						target = current + dir
					if get_cellv(current) == 13:
						dir = Vector2(0,1)
						target = current + dir
#				& is the bottom cell (ie the bottom left corner)
				elif current.y == height - 1:
					if get_cellv(current) == 14:
						dir = Vector2(1,0)
						target = current + dir
					if get_cellv(current) == 13:
						dir = Vector2(0,-1)
						target = current + dir
				else:
					if get_cellv(current) == 13:
						dir = Vector2(0,1)
						target = current + dir
			elif current.x == width - 1:
				if current.y == 0:
					if get_cellv(current) == 7:
						dir = Vector2(0, 1)
						target = current + dir
					if get_cellv(current) == 11:
						dir = Vector2(-1, 0)
						target = current + dir
				elif current.y == height - 1 :
					if get_cellv(current) == 7:
						dir = Vector2(0, -1)
						target = current + dir
					if get_cellv(current) == 14:
						dir = Vector2(-1, 0)
						target = current + dir
				else:
					if get_cellv(current) == 7:
						dir = Vector2(0, -1)
						target = current + dir
			else: 
				if current.y == 0 and get_cellv(current) == 11:
					dir = Vector2(-1, 0)
					target = current + dir
				elif current.y == height - 1 and get_cellv(current) == 14:
					dir = Vector2(1,0)
					target = current + dir
				else:
					pass
# same logic as for building the maze. We will break through the joining wall between the target and the current cell
			if target != Vector2.ZERO:
				var current_walls = get_cellv(current) - cell_walls[dir]
				var target_walls = get_cellv(target) - cell_walls[-dir]
				set_cellv(current, current_walls)
				set_cellv(target, target_walls)
				deadends.erase(current)
# for all other tiles that aren't on the edges we will break through in a straight line
			else:
				if get_cellv(current) == 7:
					dir = Vector2(1,0)
					target = current + dir
				elif get_cellv(current) == 11:
					dir = Vector2(0,-1)
					target = current + dir
				elif get_cellv(current) == 13:
					dir = Vector2(-1,0)
					target = current + dir
				elif get_cellv(current) == 14:
					dir = Vector2(0,1)
					target = current + dir
				var current_walls = get_cellv(current) - cell_walls[dir]
				var target_walls = get_cellv(target) - cell_walls[-dir]
				set_cellv(current, current_walls)
				set_cellv(target, target_walls)
				deadends.erase(current)

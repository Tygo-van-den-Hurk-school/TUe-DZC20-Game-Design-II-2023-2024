extends Node2D

var rows = 13
var columns = 30
var cell_size = Vector2(64, 64)

var cell_texture = preload("res://Mechanics/Grid/Grid.png")
var woodBlock = preload("res://Assets/Game Assets/WoodSprites/wood-wall.png")
var woodBeamH = preload("res://Assets/Game Assets/WoodSprites/wood-beam-M.png")
var woodBeamV = preload("res://Assets/Game Assets/WoodSprites/wood-beam-M-vert.png")
var stoneBlock = preload("res://Assets/Game Assets/StoneSprites/stone-wall.png")
var stoneBeamH = preload("res://Assets/Game Assets/StoneSprites/stone-beam-wide.png")
var stoneBeamV = preload("res://Assets/Game Assets/StoneSprites/stone-beam-wide-vert.png")

var cells = []
var transform_done = false
var joint

var global_joint_position

func _ready():
	setup_grid()

func setup_grid():
	for row in range(rows):
		var row_cells = []
		for column in range(columns):
			var cell = create_cell(row, column)
			if is_indestructible(row, column):
				cell.texture = stoneBlock  # Set the texture for indestructible cells
			add_child(cell)
			row_cells.append(cell)
		cells.append(row_cells)

func _input(event):
	if event is InputEventMouseButton and event.pressed and not transform_done:
		handle_click(event.position)
	elif event.is_action_pressed("spacebar") and not transform_done:
		transform_grid()
		transform_done = true

#Defines the premade map
func is_indestructible(row, column):
	return false  # Example: Make every second cell in the first row indestructible

func handle_click(position):
	var row = int(position.y / cell_size.y)
	var column = int(position.x / cell_size.x)
	
	if row >= 0 and row < rows and column >= 0 and column < columns and not is_indestructible(row, column):
		var cell = cells[row][column]
		toggle_texture(cell)

func toggle_texture(cell):
	if GameData.selectedBlock == 0:
		cell.texture = cell_texture
	elif GameData.selectedBlock == 1:
		cell.texture = woodBlock
	elif GameData.selectedBlock == 2:
		cell.texture = woodBeamH
	elif GameData.selectedBlock == 3:
		cell.texture = woodBeamV
	elif GameData.selectedBlock == 4:
		cell.texture = stoneBlock
	elif GameData.selectedBlock == 5:
		cell.texture = stoneBeamH
	elif GameData.selectedBlock == 6:
		cell.texture = stoneBeamV

func transform_grid():
	var cells_to_delete = []
	var new_cells = []
	# Initialize new_cells as a 2D array
	for i in range(rows):
		new_cells.append([])
		for j in range(columns):
			new_cells[i].append(null)
	
	# Start from the bottom row and move upwards
	for row_index in range(rows - 1, -1, -1):
		for column_index in range(columns):
			var cell = cells[row_index][column_index]
			var new_cell_scene
			var is_static = false
			# Bottom row is always static
			if row_index == rows - 1:
				is_static = true
			else:
				# Check if the cell below is static
				var cell_below = new_cells[row_index + 1][column_index]
				if cell_below is StaticBody2D:
					is_static = true

			# Determine the scene to instantiate based on the cell's texture and whether it's static
			if cell.texture == woodBlock:
				if is_static:
					new_cell_scene = preload("res://Materials/Wood/staticWood.tscn")
				else:
					new_cell_scene = preload("res://Materials/Wood/Wood1.tscn")
			elif cell.texture == woodBeamH:
				if is_static:
					new_cell_scene = preload("res://Materials/Wood/staticWoodBeamH.tscn")
				else:
					new_cell_scene = preload("res://Materials/Wood/WoodBeamH.tscn") # Assuming same scene for both static and dynamic for now
			elif cell.texture == woodBeamV:
				if is_static:
					new_cell_scene = preload("res://Materials/Wood/staticWoodBeamV.tscn")
				else:
					new_cell_scene = preload("res://Materials/Wood/WoodBeamV.tscn") # Adjust as necessary
			elif cell.texture == stoneBlock:
				if is_static:
					new_cell_scene = preload("res://Materials/Stone/staticStone.tscn")
				else:
					new_cell_scene = preload("res://Materials/Stone/Stone1.tscn")
			elif cell.texture == stoneBeamH:
				if is_static:
					new_cell_scene = preload("res://Materials/Stone/staticStoneBeamH.tscn")
				else:
					new_cell_scene = preload("res://Materials/Stone/StoneBeamH.tscn") # Adjust as necessary
			elif cell.texture == stoneBeamV:
				if is_static:
					new_cell_scene = preload("res://Materials/Stone/staticStoneBeamV.tscn")
				else:
					new_cell_scene = preload("res://Materials/Stone/StoneBeamV.tscn") # Adjust as necessary
			else:
				cells_to_delete.append(cell)
				continue

			var new_cell = new_cell_scene.instantiate()
			replace_cell(cell, new_cell)
			new_cells[row_index][column_index] = new_cell
	delete_cells(cells_to_delete)
	connect_adjacent_objects_with_joints()


func replace_cell(old_cell, new_cell):
	var parent = old_cell.get_parent()
	parent.add_child(new_cell)
	new_cell.global_position = old_cell.global_position

	# Find the position of the old cell in the cells array
	var row = int(old_cell.position.y / cell_size.y)
	var column = int(old_cell.position.x / cell_size.x)
	
	# Update the cells array with the new cell
	if row >= 0 and row < rows and column >= 0 and column < columns:
		cells[row][column] = new_cell

	old_cell.queue_free()

func delete_cells(cells_to_delete):
	for cell in cells_to_delete:
		cell.queue_free()

func create_cell(row, column):
	var cell = Sprite2D.new()
	cell.texture = cell_texture
	cell.position = Vector2(column * cell_size.x, row * cell_size.y)
	cell.set_offset(cell_size / 2)
	return cell

func connect_adjacent_objects_with_joints():
	for row in range(rows):
		for column in range(columns):
			var current_cell = cells[row][column]
			# Check if current cell is a RigidBody2D and is in the scene tree
			if (current_cell is RigidBody2D or current_cell is StaticBody2D) and current_cell.is_inside_tree():
				# Connect to right neighbor if it's a valid RigidBody2D
				if column < columns - 1:
					var right_neighbor = cells[row][column + 1]
					if (right_neighbor is RigidBody2D or right_neighbor is StaticBody2D) and right_neighbor.is_inside_tree():
						create_joint(current_cell, right_neighbor)
				# Connect to bottom neighbor if it's a valid RigidBody2D
				if row < rows - 1:
					var bottom_neighbor = cells[row + 1][column]
					if (bottom_neighbor is RigidBody2D or bottom_neighbor is StaticBody2D) and bottom_neighbor.is_inside_tree():
						create_joint(current_cell, bottom_neighbor)


func create_joint(body_a, body_b):
	if not ((body_a.vertical and body_b.horizontal) or (body_b.vertical and body_a.horizontal)):
		print("A: " + str(body_a.get_path()))
		print("B: " + str(body_b.get_path()))
		
		var joint = PinJoint2D.new()
		body_a.add_child(joint)
		joint.node_a = body_a.get_path()
		joint.node_b = body_b.get_path()
		
		joint.disable_collision = false

		
		print("JointA:" + str(joint.node_a))
		print("JointB:" + str(joint.node_b))
		
		
		joint.softness = 0.5  # Makes the joint more rigid
		joint.angular_limit_enabled = true  # Enables angular limits
		#joint.angular_limit_lower = 0  # Lower limit of rotation in radians
		#joint.angular_limit_upper = 0  # Upper limit of rotation in radians




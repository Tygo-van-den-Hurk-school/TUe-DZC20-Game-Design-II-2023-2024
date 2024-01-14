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

func _ready():
	setup_grid()

func setup_grid():
	for row in range(rows):
		var row_cells = []
		for column in range(columns):
			var cell = create_cell(row, column)
			add_child(cell)
			row_cells.append(cell)
		cells.append(row_cells)

func _input(event):
	if event is InputEventMouseButton and event.pressed and not transform_done:
		handle_click(event.position)
	elif event.is_action_pressed("spacebar") and not transform_done:
		transform_grid()
		transform_done = true

func handle_click(position):
	var row = int(position.y / cell_size.y)
	var column = int(position.x / cell_size.x)
	
	if row >= 0 and row < rows and column >= 0 and column < columns:
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
	for row in cells:
		for cell in row:
			if cell.texture == woodBlock:
				var new_cell_scene = preload("res://Materials/Wood/Wood1.tscn")
				var new_cell = new_cell_scene.instantiate()
				replace_cell(cell, new_cell)
			elif cell.texture == woodBeamH:
				var new_cell_scene = preload("res://Materials/Wood/WoodBeamH.tscn")
				var new_cell = new_cell_scene.instantiate()
				replace_cell(cell, new_cell)
			elif cell.texture == woodBeamV:
				var new_cell_scene = preload("res://Materials/Wood/WoodBeamV.tscn")
				var new_cell = new_cell_scene.instantiate()
				replace_cell(cell, new_cell)
			elif cell.texture == stoneBlock:
				var new_cell_scene = preload("res://Materials/Stone/Stone1.tscn")
				var new_cell = new_cell_scene.instantiate()
				replace_cell(cell, new_cell)
			elif cell.texture == stoneBeamH:
				var new_cell_scene = preload("res://Materials/Stone/StoneBeamH.tscn")
				var new_cell = new_cell_scene.instantiate()
				replace_cell(cell, new_cell)
			elif cell.texture == stoneBeamV:
				var new_cell_scene = preload("res://Materials/Stone/StoneBeamV.tscn")
				var new_cell = new_cell_scene.instantiate()
				replace_cell(cell, new_cell)
			else:
				cells_to_delete.append(cell)
	delete_cells(cells_to_delete)

func replace_cell(old_cell, new_cell):
	old_cell.get_parent().add_child(new_cell)
	new_cell.global_position = old_cell.global_position
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


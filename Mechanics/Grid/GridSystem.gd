extends Node2D

var rows = 20
var columns = 30
var cell_size = Vector2(64, 64)

var cell_texture = preload("res://Mechanics/Grid/Grid.png")
var alternate_texture = preload("res://Mechanics/Grid/Corner.png")

var cells = []

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
	if event is InputEventMouseButton and event.pressed:
		handle_click(event.position)

func handle_click(position):
	var row = int(position.y / cell_size.y)
	var column = int(position.x / cell_size.x)
	
	if row >= 0 and row < rows and column >= 0 and column < columns:
		var cell = cells[row][column]
		toggle_texture(cell)

func toggle_texture(cell):
	if cell.texture == cell_texture:
		cell.texture = alternate_texture
	else:
		cell.texture = cell_texture

func create_cell(row, column):
	var cell = Sprite2D.new()
	cell.texture = cell_texture
	cell.position = Vector2(column * cell_size.x, row * cell_size.y)
	cell.set_offset(cell_size / 2)
	return cell

extends Control

var BUTTON1
var BUTTON2
var rect_size

func _ready():
	rect_size = get_viewport().get_visible_rect().size
	mouse_filter = Control.MOUSE_FILTER_STOP
	BUTTON1 = $HBoxContainer/Button
	BUTTON2 = $HBoxContainer/Button2
	
	BUTTON1.connect("pressed", Callable(self, "_on_Button1_pressed"))
	BUTTON2.connect("pressed", Callable(self, "_on_Button2_pressed"))

func _on_Button1_pressed():
	GameData.selectedBlock = 1
	print("Global value set to: " + str(GameData.selectedBlock))

func _on_Button2_pressed():
	GameData.selectedBlock = 2
	print("Global value set to: " + str(GameData.selectedBlock))

func _draw():
	draw_rect(Rect2(Vector2.ZERO, rect_size), Color.BLACK)

extends Control

var BUTTON0
var BUTTON1
var BUTTON2
var BUTTON3
var BUTTON4
var BUTTON5
var BUTTON6

var rect_size
var sound_delete = preload("res://Sound/sfx/error_005.ogg")
var sound_wood = preload("res://Sound/sfx/mixkit-wood-hard-hit-2182.ogg")
var sound_stone = preload("res://Sound/sfx/zapsplat_foley_rock_piece_med_large_set_down_in_cave_reverb_005_108122.mp3")
@onready var audio_player = $AudioStreamPlayer

func _ready():
	rect_size = get_viewport().get_visible_rect().size
	mouse_filter = Control.MOUSE_FILTER_STOP
	BUTTON0 = $HBoxContainer/Button0
	BUTTON1 = $HBoxContainer/Button
	BUTTON2 = $HBoxContainer/Button2
	BUTTON3 = $HBoxContainer/Button3
	BUTTON4 = $HBoxContainer/Button4
	BUTTON5 = $HBoxContainer/Button5
	BUTTON6 = $HBoxContainer/Button6
	
	BUTTON0.connect("pressed", Callable(self, "_on_Button0_pressed"))
	BUTTON1.connect("pressed", Callable(self, "_on_Button1_pressed"))
	BUTTON2.connect("pressed", Callable(self, "_on_Button2_pressed"))
	BUTTON3.connect("pressed", Callable(self, "_on_Button3_pressed"))
	BUTTON4.connect("pressed", Callable(self, "_on_Button4_pressed"))
	BUTTON5.connect("pressed", Callable(self, "_on_Button5_pressed"))
	BUTTON6.connect("pressed", Callable(self, "_on_Button6_pressed"))

func _on_Button0_pressed():
	GameData.selectedBlock = 0
	print("Global value set to: " + str(GameData.selectedBlock))
	BUTTON0.modulate = Color.RED
	BUTTON1.modulate = Color.WHITE
	BUTTON2.modulate = Color.WHITE
	BUTTON3.modulate = Color.WHITE
	BUTTON4.modulate = Color.WHITE
	BUTTON5.modulate = Color.WHITE
	BUTTON6.modulate = Color.WHITE
	
	audio_player.stream = sound_delete

func _on_Button1_pressed():
	GameData.selectedBlock = 1
	print("Global value set to: " + str(GameData.selectedBlock))
	BUTTON0.modulate = Color.WHITE
	BUTTON1.modulate = Color.RED
	BUTTON2.modulate = Color.WHITE
	BUTTON3.modulate = Color.WHITE
	BUTTON4.modulate = Color.WHITE
	BUTTON5.modulate = Color.WHITE
	BUTTON6.modulate = Color.WHITE
	
	audio_player.stream = sound_wood
	

func _on_Button2_pressed():
	GameData.selectedBlock = 2
	print("Global value set to: " + str(GameData.selectedBlock))
	BUTTON0.modulate = Color.WHITE
	BUTTON1.modulate = Color.WHITE
	BUTTON2.modulate = Color.RED
	BUTTON3.modulate = Color.WHITE
	BUTTON4.modulate = Color.WHITE
	BUTTON5.modulate = Color.WHITE
	BUTTON6.modulate = Color.WHITE
	
	audio_player.stream = sound_wood

func _on_Button3_pressed():
	GameData.selectedBlock = 3
	print("Global value set to: " + str(GameData.selectedBlock))
	BUTTON0.modulate = Color.WHITE
	BUTTON1.modulate = Color.WHITE
	BUTTON2.modulate = Color.WHITE
	BUTTON3.modulate = Color.RED
	BUTTON4.modulate = Color.WHITE
	BUTTON5.modulate = Color.WHITE
	BUTTON6.modulate = Color.WHITE
	
	audio_player.stream = sound_wood
	
	

func _on_Button4_pressed():
	GameData.selectedBlock = 4
	print("Global value set to: " + str(GameData.selectedBlock))
	BUTTON0.modulate = Color.WHITE
	BUTTON1.modulate = Color.WHITE
	BUTTON2.modulate = Color.WHITE
	BUTTON3.modulate = Color.WHITE
	BUTTON4.modulate = Color.RED
	BUTTON5.modulate = Color.WHITE
	BUTTON6.modulate = Color.WHITE
	
	audio_player.stream = sound_stone

func _on_Button5_pressed():
	GameData.selectedBlock = 5
	print("Global value set to: " + str(GameData.selectedBlock))
	BUTTON0.modulate = Color.WHITE
	BUTTON1.modulate = Color.WHITE
	BUTTON2.modulate = Color.WHITE
	BUTTON3.modulate = Color.WHITE
	BUTTON4.modulate = Color.WHITE
	BUTTON5.modulate = Color.RED
	BUTTON6.modulate = Color.WHITE
	
	audio_player.stream = sound_stone

func _on_Button6_pressed():
	GameData.selectedBlock = 6
	print("Global value set to: " + str(GameData.selectedBlock))
	BUTTON0.modulate = Color.WHITE
	BUTTON1.modulate = Color.WHITE
	BUTTON2.modulate = Color.WHITE
	BUTTON3.modulate = Color.WHITE
	BUTTON4.modulate = Color.WHITE
	BUTTON5.modulate = Color.WHITE
	BUTTON6.modulate = Color.RED
	
	audio_player.stream = sound_stone

func _draw():
	draw_rect(Rect2(Vector2.ZERO, rect_size), Color.BLACK)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		audio_player.play()

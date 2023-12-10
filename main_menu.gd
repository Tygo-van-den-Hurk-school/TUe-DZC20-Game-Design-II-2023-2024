extends Control
	
###############################################################################
#                              Helper Functions                               #
###############################################################################
func toggle() -> void: 
	# toggles this screens' visibily
	visible = !visible
	get_tree().paused = visible
	
func show_and_hide(thing_to_show, thing_to_hide) -> void:
	# shows the first parameter and hides the second
	print("showed:  " + thing_to_show)
	print("and hid: " + thing_to_hide)
	
func _process(_delta) -> void:
	# When ever ESC is pressed we toggle this menu	
	const ESC = "ui_cancel"
	if Input.is_action_just_pressed(ESC):
		toggle()
	
###############################################################################
#                                  Main Menu                                  #
###############################################################################
@onready var main_menu = $MainMenuButtonContainer
	
func _on_main_menu_button_start_pressed() -> void:
	toggle()
	get_tree().change_scene("level.tscn")
	
func _on_main_menu_button_go_to_options_pressed() -> void:
	show_and_hide(options_menu, main_menu)
	
func _on_main_menu_button_quit_pressed() -> void:
	get_tree().quit()
	
###############################################################################
#                                 Options Menu                                #
###############################################################################
@onready var options_menu = $OptionsMenu
func _on_options_menu_back_to_main_menu_button_pressed() -> void:
	show_and_hide(main_menu, options_menu)
	
func _on_options_menu_go_to_video_sub_menu_pressed() -> void:
	show_and_hide(video_options_menu, options_menu)
	
func _on_options_menu_go_to_audio_sub_menu_pressed() -> void:
	show_and_hide(audio_options_menu, options_menu)
	
###############################################################################
#                              Video Options Menu                             #
###############################################################################
@onready var video_options_menu = $OptionsSubMenuForVideo
	
func _on_video_options_menu_back_to_option_menu_button_pressed() -> void:
	show_and_hide(options_menu, video_options_menu)
	
func _on_video_setting_check_box_full_screen_toggled(toggled_on:bool) -> void:
	if toggled_on:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	
func _on_video_setting_check_box_always_on_top_toggled(toggled_on:bool) -> void:
	# DisplayServer.window_set_always_top # TODO can't seem to get this working
	pass
	
func _on_video_setting_check_box_v_sync_toggled(toggled_on:bool) -> void:
	if toggled_on:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
	
func _on_video_setting_check_box_borderless_toggled(toggled_on:bool) -> void:
	# OS.window_borderless = toggled_on # TODO can't seem to get this working
	pass 
	
###############################################################################
#                              Audio Options Menu                             #
###############################################################################
@onready var audio_options_menu = $OptionsSubMenuForAudio
	
const master_volume_bus_index:int = 0
const music_volume_bus_index:int = 1
const sound_fx_volume_bus_index:int = 2
	
func _on_audio_options_menu_back_to_option_menu_button_pressed() -> void:
	show_and_hide(audio_options_menu, options_menu)
	
func _on_audio_setting_slider_master_volume_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(master_volume_bus_index, value)
	
func _on_audio_setting_slider_music_volume_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(music_volume_bus_index, value)
	
func _on_audio_setting_slider_sound_fx_volume_value_changed(value:float) -> void:
	AudioServer.set_bus_volume_db(sound_fx_volume_bus_index, value)
	

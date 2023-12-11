extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("show_info"):
		shake(20 * delta, 3)
	pass

func shake(duration, intensity):
	var original_position = position
	var time_passed = 0.0
	while time_passed < duration:
		position = original_position + Vector2(randf_range(-intensity, intensity), randf_range(-intensity, intensity))
		await get_tree().create_timer(0.05).timeout  # Small delay
		time_passed += get_process_delta_time()
	position = original_position  # Reset to original position
	

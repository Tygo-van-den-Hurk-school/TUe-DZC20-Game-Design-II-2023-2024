extends Node2D

var on = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	if on:
		self.visible = true
		on = false
	else:
		self.visible = false
		on = true
	var value = randi_range(1,3)
	if value == 1:
		$DialogBox/LevelTitle.text = "Material Selection"
		$DialogBox/LevelInfo.text = "Choose materials suited to the building's environment and purpose. Factors like tensile strength, durability, and resistance to elements are crucial"
	elif value == 2:
		$DialogBox/LevelTitle.text = "Load Analysis"
		$DialogBox/LevelInfo.text = "Accurately calculate and distribute loads, including dead loads, live loads, and environmental pressures, to ensure stability and safety."
	elif value == 3:
		$DialogBox/LevelTitle.text = "Sustainable Materials"
		$DialogBox/LevelInfo.text = "Choose eco-friendly materials for construction, promoting environmental sustainability and long-term efficiency."
	$Timer.start()


func _on_button_label_pressed():
	self.visible = false

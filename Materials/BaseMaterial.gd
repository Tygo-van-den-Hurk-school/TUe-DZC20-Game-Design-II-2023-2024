extends RigidBody2D

# Exported variables for customizing in the Editor
@export var sprite_texture : Texture
@export var weight : float = 1.0
@export var collision_shape_size : Vector2 = Vector2(64, 64)
var is_physics_object = true

# Called when the node enters the scene tree for the first time.
func _ready():
	var sprite_node: Sprite2D = $Sprite2D
	var collision_shape_node: CollisionShape2D = $CollisionShape2D
	
	# Setup the sprite
	if sprite_texture:
		sprite_node.texture = sprite_texture
		
	# Set the mass (weight)
	mass = weight
	
	# Setup the collision shape
	if collision_shape_node.shape is RectangleShape2D:
		collision_shape_node.shape.extents = collision_shape_size / 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

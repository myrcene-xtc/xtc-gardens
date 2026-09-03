extends RigidBody2D

@export var plant: Plant

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("seed")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

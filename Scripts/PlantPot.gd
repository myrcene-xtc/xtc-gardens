extends RigidBody2D

@onready var PlantSprite: Sprite2D = $Plant/PlantSprite


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("seed"):
		print("Seed entered potting area.")
		PlantSprite.texture = body.plant.PlantSprites[0]
		print(body.plant.PlantName)
		body.queue_free()

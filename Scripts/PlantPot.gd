extends RigidBody2D

@onready var plant_sprite: Sprite2D = $Plant/PlantSprite

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("seed"):
		if !body.plant:
			pass

		print("Seed entered potting area.")
		plant_sprite.texture = body.plant.plant_sprites[0]
		print(body.plant.plant_name)
		body.queue_free()

extends RigidBody2D

@onready var plant_sprite: Sprite2D = $Plant/PlantSprite
var harvested_crop: Resource
var plant: Plant
var is_harvestable: bool = false
var is_growing: bool = false


# when the seed comes into the contact area with the pot
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("seed"):
		if !body.plant:
			pass

		print("Seed entered potting area.")
		if !is_growing:
			plant_sprite.texture = body.plant.plant_sprites[0]
			harvested_crop = body.plant.harvested_crop
			plant = body.plant
			handle_plant_growing()
			print(body.plant.plant_name)
			body.queue_free()
		else:
			print("Currently growing plant. Cannot grow another in the same pot.")


func handle_plant_growing() -> void:
	is_growing = true
	smooth_scale(plant.growth_time)
	await get_tree().create_timer(plant.growth_time).timeout
	is_harvestable = true
	on_harvest()
	print("🍃 Plant fully grown!")

func on_harvest() -> void:
	is_growing = false
	plant_sprite.texture = null
	var instance = harvested_crop.instantiate()
	add_child(instance)

func smooth_scale(duration: float = 1.0):
	plant_sprite.scale = Vector2(0.1, 0.1)
	var tween = create_tween()
	tween.tween_property(plant_sprite, "scale", Vector2(1, 1), duration)
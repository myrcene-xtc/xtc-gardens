@icon("res://Assets/Editor/cannaleaf.svg")
extends Resource
class_name Plant


@export var plant_name: String
@export var plant_sprites: Array[Texture2D]
@export var harvested_crop: Resource
@export var plant_value: int
@export var growth_time: int
@export var growth_stages: int

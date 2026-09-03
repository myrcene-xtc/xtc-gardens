extends CharacterBody2D
enum SPRITE_COLOR {RED, BLUE}

@export var speed = 300.0
@export var state: SPRITE_COLOR
@export var push_force := 0.3

@onready var sprite: Sprite2D = $Sprite2D

var color_map = {
	SPRITE_COLOR.RED: Color.RED,
	SPRITE_COLOR.BLUE: Color.BLUE
}
var damping: float = 0.3:
	get(): return (1.0 - damping)

func set_color(new_color: SPRITE_COLOR) -> void:
	sprite.modulate = color_map[new_color]

func _ready() -> void:
	set_color(state)
	
func _physics_process(delta: float) -> void:
	var direction := Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	# horizontal movement
	if direction.x:
		velocity.x = direction.x * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	# vertical movement
	if direction.y:
		velocity.y = direction.y * speed
	else:
		velocity.y = move_toward(velocity.y, 0, speed)

	var temp_velocity: Vector2 = velocity
	move_and_slide()

	for i in get_slide_collision_count():
		var coll: KinematicCollision2D = get_slide_collision(i)
		var node: Node = coll.get_collider()
		if node is RigidBody2D:
			node.apply_central_impulse(temp_velocity * push_force)

extends CharacterBody2D
enum SPRITE_COLOR {RED, BLUE}

@export var SPEED = 300.0
@export var STATE: SPRITE_COLOR
@export var PUSH_FORCE := 0.3

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
	set_color(STATE)
	
func _physics_process(delta: float) -> void:
	var direction := Vector2(Input.get_axis("move_left", "move_right"), Input.get_axis("move_up", "move_down")).normalized()
	# horizontal movement
	if direction.x:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# vertical movement
	if direction.y:
		velocity.y = direction.y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	var temp_velocity: Vector2 = velocity
	move_and_slide()

	for i in get_slide_collision_count():
		var coll: KinematicCollision2D = get_slide_collision(i)
		var node: Node = coll.get_collider()
		if node is RigidBody2D:
			node.apply_central_impulse(temp_velocity * PUSH_FORCE)

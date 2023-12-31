extends CharacterBody2D

const GRAVITY: int = 1100
const MAXHSPEED: int = 130 
const HACCELERATION: int = 2000 
const JUMPSPEED : int = 360
const JUMPTERMULT: int = 4

func _process(delta):
	var move_vector: Vector2 = get_movement_vector()
	
	velocity.x += move_vector.x * HACCELERATION * delta 
	if move_vector.x == 0:
		velocity.x =  lerp(0,  int(velocity.x), pow(2, -50 * delta ))
	velocity.x = clamp(velocity.x, -MAXHSPEED, MAXHSPEED )

	if move_vector.y < 0 and is_on_floor():
		velocity.y = move_vector.y * JUMPSPEED
		
	if velocity.y < 0 and !Input.is_action_pressed("jump"):
		velocity.y += GRAVITY * JUMPTERMULT * delta
	else:
		velocity.y += GRAVITY * delta
	move_and_slide()

func get_movement_vector() -> Vector2:
	var move_vector: Vector2 = Vector2.ZERO
	move_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	move_vector.y = -1 if Input.is_action_just_pressed("jump") else 0
	return move_vector

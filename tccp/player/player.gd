class_name Player extends CharacterBody2D
## Controla Movimentação do Jogador


var speed: float = 200
var pull_speed: float = 100.0
var acceleration: float = 0.1
var deceleration: float = 0.1
var jump_velocity: float = 400

@onready var ladder_detector: Area2D = %LadderDetector

var on_ladder: bool = false
var climbing: bool = false

var direction: Vector2 = Vector2.ZERO
var vertical_dir: float


func _physics_process(delta: float) -> void:
	_movement(delta)
	
	_jump()

	move_and_slide()


func _movement(delta: float) -> void:
	var grounded: bool = is_on_floor()
	
	direction.x = Input.get_axis("left", "right")
	
	if on_ladder:
		vertical_dir = Input.get_axis("up","down")
		if vertical_dir:
			velocity.y = vertical_dir * speed
			climbing = not grounded
		else:
			velocity.y = move_toward(velocity.y, 0.0, speed)
			
			if grounded:
				climbing = false
	
	elif not grounded:
		velocity += get_gravity() * delta
		
	if direction.x:
		if Input.is_action_pressed("grab"):
			velocity.x = direction.x * pull_speed 
		
		if on_ladder: climbing = not grounded
		else: climbing = false
		
		velocity.x = move_toward(velocity.x, direction.x * speed, speed * acceleration)
	else:
		velocity.x = move_toward(velocity.x, 0.0, speed * deceleration)
	

func _jump() -> void:
		if Input.is_action_just_pressed("jump") and self.is_on_floor():
			velocity.y = -jump_velocity
			
		elif Input.is_action_just_released("jump") and self.velocity.y < 0.0:
			velocity.y = 0


func _on_ladder_detector_body_entered(_body: Node2D) -> void:
	on_ladder = true


func _on_ladder_detector_body_exited(_body: Node2D) -> void:
	on_ladder = false

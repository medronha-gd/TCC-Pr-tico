extends Node

#const GRAB_SPEED := 200.0 # 100.0, 200 para puxar
const MAX_GRAB_DISTANCE := 60.0 #60.0

@onready var player: Player = $".."

const PULL_SPEED := 200.0 
const PUSH_SPEED := 80.0  

var body: RigidBody2D = null

@onready var l_ray: RayCast2D = %LRay
@onready var r_ray: RayCast2D = %RRay

# encontrar corpos na colisão, se possível também verificar o grupo dele
# para nao pegar qualquer RigidBody2D
func _find_body() -> RigidBody2D:
	for ray in [r_ray, l_ray]:
		if ray.is_colliding() and ray.get_collider() is RigidBody2D:
			return ray.get_collider()
	return null

func push_pull() -> void:
	# soltou o botão (ou o corpo foi destruído): solta
	if not Input.is_action_pressed("grab") or (body != null and not is_instance_valid(body)):
		body = null
		return

	# só registra o corpo na primeira vez que aperta
	if body == null:
		if Input.is_action_just_pressed("grab"):
			body = _find_body()
		if body == null:
			return

	# muito longe: solta
	if body.global_position.distance_to(r_ray.global_position) > MAX_GRAB_DISTANCE:
		body = null
		return

	var direction := Input.get_axis("left", "right")
	print(direction) # -1.0 left, 1.0 right
	
	
	# -1 se o jogador está à esquerda do corpo; +1 se está à direita.
	var side_of_player = sign(player.global_position.x - body.global_position.x)

	# Movimento na direção do jogador = puxar.
	var is_pulling = direction == side_of_player

	if direction != 0.0:
		var speed := PULL_SPEED if is_pulling else PUSH_SPEED
		body.linear_velocity.x = direction * speed
	else:
		body.linear_velocity.x = 0.0
		


func _physics_process(_delta: float) -> void:
	push_pull()

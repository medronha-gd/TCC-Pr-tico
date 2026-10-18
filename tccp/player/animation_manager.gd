extends Node
## Gerencia as animações do jogador
@export var player_body: Player

@export var sprites: AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	flip_sprite()
	update_animation()


func flip_sprite() -> void:
	if player_body.direction.x != 0:
		if player_body.direction.x > 0:
			sprites.flip_h = true
		elif player_body.direction.x < 0:
			sprites.flip_h = false

# depois que tiver as outras animações descomenta out os else
func update_animation() -> void:
	if player_body.is_on_floor():
		if player_body.direction.x != 0:
			sprites.animation = "walk"
		#else:
			#sprites.animation = "idle"
	#else:
		#sprites.animation = "jump"
		
	#if player_body.on_ladder:
		#if player_body.climbing:
			#if player_body.vertical_dir:
				#sprites.animation = "climb"
				
	sprites.play()

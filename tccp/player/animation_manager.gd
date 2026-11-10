class_name AnimationManager extends AnimatedSprite2D
## Gerencia as animações do jogador
@onready var player_body: Player = self.owner

func _physics_process(_delta: float) -> void:
	_flip_sprite()
	_update_animation()


func _flip_sprite() -> void:
	if player_body.direction.x != 0:
		if player_body.direction.x > 0:
			self.flip_h = true
		elif player_body.direction.x < 0:
			self.flip_h = false


# depois que tiver as outras animações descomenta out os else
func _update_animation() -> void:
	if player_body.is_on_floor():
		if player_body.direction.x != 0:
			self.animation = "walk"
		#else:
			#self.animation = "idle"
	#else:
		#self.animation = "jump"
		
	if Flags.on_ladder:
		if Flags.climbing:
			if player_body.vertical_dir:
				self.animation = "climb"
				
	if Flags.in_killzone:
		self.animation = "sink"
				
	self.play()

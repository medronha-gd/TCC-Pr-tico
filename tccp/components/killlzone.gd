extends Area2D
## Detecta quando jogador entra na area de morte e o posiciona numa area segura, também emite sinais de saida e entrada de area para manejar animações

@export_category("Referencia da posição de respawn")
@export var respawn_point: Marker2D # O jogador vai reaparecer na posição desse Marker2D


func _init() -> void:
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)


func _on_body_entered(body: CharacterBody2D) -> void:
	if respawn_point == null:
		return
	
	if body is Player:
		Flags.can_move = false
		Flags.in_killzone = true
		
		# Tocar fade-in
		
		body.global_position = respawn_point.global_position


func _on_body_exited(body: CharacterBody2D) -> void:
	if body is Player:
		Flags.can_move = true
		Flags.in_killzone = false

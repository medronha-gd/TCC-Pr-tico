extends Node2D

func _ready() -> void:
	SignalBus.half_timer_finished.connect(_on_half_timer_finished)
	SignalBus.main_timer_finished.connect(_on_main_timer_finished)


func _on_dialogue_actionable_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		pass
		#%DialogueActionable2D.action()

func _on_half_timer_finished() -> void:
	%L1.text = "O timer acançou o a sua metade"


func _on_main_timer_finished() -> void:
	%L2.text = "O timer acançou o final"

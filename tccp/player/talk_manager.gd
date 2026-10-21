extends Node

@onready var player: Player = self.get_parent()

@export var dialogue_detector: Area2D


func _init() -> void:
	DialogueManager.dialogue_started.connect(_on_dialog_started)
	DialogueManager.dialogue_ended.connect(_on_dialog_ended)


func _on_dialog_started(resource: DialogueResource):
	player.can_move = false
	player.velocity = Vector2.ZERO

func _on_dialog_ended(resource: DialogueResource):
	player.can_move = true


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var areas: Array[Area2D] = dialogue_detector.get_overlapping_areas()
		for area in areas:
			if area is DialogueActionable2D:
				area.action()
				break

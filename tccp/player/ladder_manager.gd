extends Node

@export var ladder_detector: Area2D

@onready var player: Player = self.get_parent()

func _ready() -> void:
	ladder_detector.body_entered.connect(_on_ladder_detector_body_entered)
	ladder_detector.body_exited.connect(_on_ladder_detector_body_exited)
	
	
func _on_ladder_detector_body_entered(_body: Node2D) -> void:
	player.on_ladder = true


func _on_ladder_detector_body_exited(_body: Node2D) -> void:
	player.on_ladder = false

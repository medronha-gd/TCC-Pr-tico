extends Area2D

func _init() -> void:
	self.body_entered.connect(_on_body_entered)
	self.body_exited.connect(_on_body_exited)


func _on_body_entered(_body: Node2D) -> void:
	Flags.on_ladder = true


func _on_body_exited(_body: Node2D) -> void:
	Flags.on_ladder = false

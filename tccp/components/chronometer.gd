@icon("res://addons/icons/alarm_clock.svg")
extends Node

@export var main_timer: Timer
@export var half_timer: Timer

@export_category("Main timer wait time")
@export var duration: float

func _ready() -> void:
	main_timer.wait_time = duration
	half_timer.wait_time = duration / 2 # Metade do main timer
	
	for timer: Timer in self.get_children():
		## Só instanciar esse Node na cena e ele começa sozinho
		timer.start()


func _on_half_timer_timeout() -> void:
	SignalBus.half_timer_finished.emit()

func _on_main_timer_timeout() -> void:
	SignalBus.main_timer_finished.emit()

extends CanvasLayer
## Responsavel pelas animações de fade, pode ser chamado globalmente.

signal finished

@export var c_rect: ColorRect

@onready var black: Color = Color(0.0, 0.0, 0.0, 1.0)
@onready var transparent: Color = Color(0.0, 0.0, 0.0, 0.0)

enum FadeType {
	FADE_IN,
	FADE_OUT,
	FADE_IN_OUT,
}

func _ready() -> void:
	c_rect.hide()
	
	c_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	c_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	


func fade(fade_type: FadeType) -> void:
	c_rect.show()
	
	match fade_type:
		FadeType.FADE_IN:
			_fade_in()
		FadeType.FADE_OUT:
			_fade_out()
		FadeType.FADE_IN_OUT:
			_fade_in_out()
	

func _fade_in() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(c_rect, "color", black, 1.0).from(transparent)
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
	await tween.finished
	tween.kill()
	
	finished.emit()
	
	c_rect.hide()
	


func _fade_out() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(c_rect, "color", transparent, 1.0).from(black)
	tween.set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	await tween.finished
	tween.kill()
	
	finished.emit()
	
	c_rect.hide()


func _fade_in_out() -> void:
	await _fade_in()
	
	c_rect.show()
	
	_fade_out()
	
	finished.emit()

extends CanvasLayer

@export var resume: Button
@export var quit: Button


func _init() -> void:
	self.hide()
	self.process_mode = Node.PROCESS_MODE_ALWAYS


func _ready() -> void:
	
	%Panel.mouse_filter = Control.MOUSE_FILTER_IGNORE
	%Panel.set_anchors_preset(Control.PRESET_FULL_RECT)
	
	%ButtonContainer.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
	for button: Button in [resume, quit]:
		button.pressed.connect(_on_button_pressed.bind(button))


func _on_button_pressed(button: Button) -> void:
	match button:
		resume:
			resume_game()
		quit:
			if OS.has_feature('web'):
				JavaScriptBridge.eval("window.history.back()")
			get_tree().quit()
			# Retornar ao menu principal aqui

func _unhandled_key_input(_event: InputEvent) -> void:
	if Input.is_action_pressed("ui_cancel"):
		match get_tree().paused:
			true:
				resume_game()
			false:
				pause_game()

func pause_game() -> void:
	get_tree().paused = true
	self.show()
	
func resume_game() -> void:
	get_tree().paused = false
	self.hide()

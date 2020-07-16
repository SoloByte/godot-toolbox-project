extends CanvasLayer

onready var pause_menu = $UIBox/Popup
onready var invisible_wall = $InvisibleWall

var is_paused = false

func _ready():
	_on_game_paused(false)
	Sgn.connect("game_paused", self, "_on_game_paused")

func _on_game_paused(pause_on):
	is_paused = pause_on
	pause_menu.visible = pause_on
	invisible_wall.visible = pause_on
	
	get_tree().paused = pause_on

func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		Sgn.emit_signal("game_paused", !is_paused)
		
	if is_paused and Input.is_action_just_pressed("ui_cancel"):
		_on_ReturnButton_pressed()

func _on_ReturnButton_pressed():
	Sgn.emit_signal("game_paused", false)

func _on_MenuButton_pressed():
	Sgn.emit_signal("game_paused", false)
	# TODO: Confirm PopUp
	ScrnMngr.pop_screen()

func _on_QuitButton_pressed():
	Sgn.emit_signal("game_paused", false)
	# TODO: Confirm PopUp
	ScrnMngr.exit_game()

func _on_InvisibleWall_pressed():
	if is_paused:
		_on_ReturnButton_pressed()


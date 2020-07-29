extends CanvasLayer
signal start
# Called when the node enters the scene tree for the first time.
func _ready():
	$Score.hide()

func update_score(score):
	$Score.text = str(score)

func _on_Button_pressed():
	$Score.show()
	$Button.hide()
	emit_signal("start")

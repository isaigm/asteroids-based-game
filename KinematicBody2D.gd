extends KinematicBody2D
export var speed = 200
export var vel = Vector2()

func _ready():
	pass # Replace with function body.
func _physics_process(delta):
	if Input.is_action_pressed("ui_right"):
		$Sprite.rotate(0.17)
	elif Input.is_action_pressed("ui_left"):
		$Sprite.rotate(-0.17)
	elif Input.is_action_pressed("ui_up"):
		var rot = $Sprite.rotation
		vel.x = cos(rot)
		vel.y =	sin(rot)
		vel = speed * vel.normalized()	
		$Sprite.position += delta * vel
	else:
		vel.x *= 1.25
		vel.y *= 1.25
	move_and_slide(vel)
	


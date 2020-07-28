extends KinematicBody2D
signal hit
export var speed = 450
export var vel = Vector2(0, 0)
export (PackedScene) var Bullet
func _ready():
	pass # Replace with function body.
func _input(event):
	if Input.is_key_pressed(KEY_SPACE):
		var bullet = Bullet.instance()
		bullet.position = position
		get_parent().add_child(bullet)
func _physics_process(delta):
	var rot = $Sprite.rotation
	if Input.is_action_pressed("ui_right"):
		$Sprite.rotate(0.17)
	elif Input.is_action_pressed("ui_left"):
		$Sprite.rotate(-0.17)
	elif Input.is_action_pressed("ui_up"):
		vel.x = cos(rot)
		vel.y = sin(rot)
		vel *= speed
	elif Input.is_action_pressed("ui_down"):
		vel.x = -cos(rot)
		vel.y = -sin(rot)
		vel *= speed
	else:
		vel.x *= 0.9
		vel.y *= 0.9
	move_and_slide(vel, Vector2( 0, 0 ), false, 4, 0.785398, false)
	if get_slide_count() > 0:
		emit_signal("hit")

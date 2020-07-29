extends KinematicBody2D
signal hit
export var speed = 450
export var vel = Vector2(0, 0)
export (PackedScene) var Bullet
var can_shoot = true
var playing = false
func _ready():
	disable()

func _input(event):
	if Input.is_key_pressed(KEY_SPACE) and can_shoot and playing:
		$Shoot.play()
		var bullet = Bullet.instance()
		bullet.position = position
		var dir = $Sprite.rotation
		bullet.rotation = dir
		bullet.linear_velocity = Vector2(600, 0)
		bullet.linear_velocity = bullet.linear_velocity.rotated(dir)
		can_shoot = false
		$Cooldown.start()
		get_parent().add_child(bullet)

func _physics_process(delta):
	if playing:
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
		
func _on_Cooldown_timeout():
	can_shoot = true

func start(pos):
	position = pos
	show()
	playing = true
	$CollisionShape2D.disabled = false

func disable():
	hide()
	playing = false
	$CollisionShape2D.set_deferred("disabled", true)

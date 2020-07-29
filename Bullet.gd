extends RigidBody2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
func _on_Bullet_body_entered(body):
	var node = get_tree().get_root().get_node("Main/HUD")
	node.update_score(int(node.get_child(0).text) + 1)
	queue_free()
	body.queue_free()

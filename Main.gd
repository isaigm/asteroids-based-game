extends Node
export (PackedScene) var Asteroid

func loadGame():
	var max_score = loadFile()
	if max_score.length() == 0:
		$HUD/MaxScore.text = "Max score: 0"
	else:
		$HUD/MaxScore.text = "Max score: " + max_score

func saveGame():
	var score = $HUD/Score.text
	var last_score = loadFile()
	if last_score.length() == 0:
		saveFile(score)
	else:
		saveFile(str(max(int(score), int(last_score))))

func saveFile(content):
	var file = File.new()
	file.open("user://max_score.dat", File.WRITE)
	file.store_string(content)
	file.close()

func loadFile():
	var file = File.new()
	file.open("user://max_score.dat", File.READ)
	var content = file.get_as_text()
	file.close()
	return content

func _notification(what):
	if (what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST):
		print ("You are quit!")
		saveGame()
		get_tree().quit() # default behavior
	
func _ready():
	randomize()
	loadGame()
	$AsteroidTimer.start()

func _on_AsteroidTimer_timeout():
	$AsteroidPath/AsteroidSpawnLocation.offset = randi()
	# Create an Asteroid instance and add it to the scene.
	var asteroid = Asteroid.instance()
	add_child(asteroid)
	# Set the asteroid's direction perpendicular to the path direction.
	var direction = $AsteroidPath/AsteroidSpawnLocation.rotation + PI / 2
	# Set the asteroid's position to a random location.
	asteroid.position = $AsteroidPath/AsteroidSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	asteroid.rotation = direction
	# Set the velocity (speed & direction).
	asteroid.linear_velocity = Vector2(rand_range(asteroid.min_speed, asteroid.max_speed), 0)
	asteroid.linear_velocity = asteroid.linear_velocity.rotated(direction)

func _on_Player_hit():
	get_tree().call_group("asteroids", "queue_free")
	$AsteroidTimer.stop()
	$HUD/Score.hide()
	$HUD/Button.show()
	$Player.disable()
	saveGame()
	loadGame()
	$HUD.update_score(0)
	
func _on_HUD_start():
	$Player.start($StartPos.position)
	$AsteroidTimer.start()
	get_tree().call_group("asteroids", "queue_free")

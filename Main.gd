extends Node
export (PackedScene) var Asteroid

func _ready():
	randomize()
	$AsteroidTimer.start()

func _on_AsteroidTimer_timeout():
	$AsteroidPath/AsteroidSpawnLocation.offset = randi()
	# Create a Mob instance and add it to the scene.
	var asteroid = Asteroid.instance()
	add_child(asteroid)
	# Set the mob's direction perpendicular to the path direction.
	var direction = $AsteroidPath/AsteroidSpawnLocation.rotation + PI / 2
	# Set the mob's position to a random location.
	asteroid.position = $AsteroidPath/AsteroidSpawnLocation.position
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	asteroid.rotation = direction
	# Set the velocity (speed & direction).
	asteroid.linear_velocity = Vector2(rand_range(asteroid.min_speed, asteroid.max_speed), 0)
	asteroid.linear_velocity = asteroid.linear_velocity.rotated(direction)



func _on_Player_hit():
	$AsteroidTimer.stop()

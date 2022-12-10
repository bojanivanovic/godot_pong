extends CharacterBody2D

# set the speed of the player's paddle
@export var playerSpeed = 600

func _physics_process(_delta):
	var playerVelocity = Vector2.ZERO

	# moving the player's paddle when pressing "w" or "s"
	if Input.is_action_pressed("LeftUp"):
		playerVelocity.y -= playerSpeed
	if Input.is_action_pressed("LeftDown"):
		playerVelocity.y += playerSpeed

	set_velocity(playerVelocity)
	move_and_slide()



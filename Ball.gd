extends KinematicBody2D

# sets the speed and initial velocity of the ball
export var ballSpeed = 800
export var ballVelocity = Vector2.ZERO

func _ready():
	# reset the randomisation seed
	randomize()

	# set a random direction for the ball
	ballVelocity.x = [-1, 1][randi() % 2]
	ballVelocity.y = [-0.8, 0.8][randi() % 2]

func _physics_process(delta):
	# gets the body or area the ball collided with (wall, goal, player paddle)
	var collision_object = move_and_collide(ballVelocity * ballSpeed * delta)
	
	if collision_object:
		# hack for the ball moving the paddle kinematics
		var playerL = get_node("/root/Court/PlayerLeft")
		var playerR = get_node("/root/Court/PlayerRight")
		var ai = get_node("/root/Court/AIOpponent")

		if collision_object.collider.name == "PlayerLeft" or collision_object.collider.name == "PlayerRight" or collision_object.collider.name == "AIOpponent":
			if Global.gameMode == 1:
				set_initial_positions(playerL, null, ai)
			if Global.gameMode == 2:
				set_initial_positions(playerL, playerR, null)

		# bounce the ball after collision
		ballVelocity = ballVelocity.bounce(collision_object.normal)

		# play the sound for the ball hitting an object
		$BallHitSound.play()
		# hacky and probably bad way of eliminating the sound playing multiple times in quick succession
		# if there are several collissions detected in a very short time frame
		$BallHitSound.stop()

# stops the ball (after score or at start of the game)
func stop_ball():
	ballSpeed = 0

# get the ball moving again after the timer runs out 
func restart_ball():
	ballSpeed = 600

	ballVelocity.x = [-1, 1][randi() % 2]
	ballVelocity.y = [-0.8, 0.8][randi() % 2]

# a hack: under certain condition, the ball hitting one of the kinematic bodies (paddles) will shift their
# position ever so slightly; this resets their x axis position on each collision which kind of solves the
# problem, despite feeling icky
func set_initial_positions(playerLeft, playerRight, aiOpponent):
	playerLeft.position = Vector2(
		45, playerLeft.position.y)

	if (playerRight):
		playerRight.position = Vector2(
			get_viewport().get_visible_rect().size.x - 45, playerRight.position.y)
	
	if (aiOpponent):
		aiOpponent.position = Vector2(
			get_viewport().get_visible_rect().size.x - 45, aiOpponent.position.y)

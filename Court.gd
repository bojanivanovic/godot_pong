extends Node

# initial score values
var playerScore = 0
var opponentScore = 0

func _ready():
	# stopping the ball initially for the start of the game, as well as setting
	# initial positions for both the ball and the paddles
	get_tree().call_group('BallGroup', 'stop_ball')
	set_initial_positions()

	# start a 3 second timer before kickoff
	$CountdownTimer.start()

	# hiding the in-game menu during the game
	$InGameMenu.visible = false
	
	# setting game mode to either 1P or 2P
	if Global.gameMode == 1:
		$PlayerRight.queue_free()
	elif Global.gameMode == 2:
		$AIOpponent.queue_free()
	else:
		print("No game mode set")

# shows the in-game menu and, indirectly, pauses the game
func _input(event):
	if event.is_action("ui_cancel"):
		$InGameMenu.visible = true

# ball entered the left "goal"
func _on_GoalLeft_body_entered(_body):
	score_achieved("playerRight")

# ball entered the right "goal"
func _on_GoalRight_body_entered(_body):
	score_achieved("playerLeft")

func _process(_delta):
	# set the countdown lable to seconds left checked the timer at the start and between scores
	var countdown = get_node("/root/Court/CountdownTimer")
	var countdownText = get_node("/root/Court/ScoreLabel/TimerLabel")

	if countdown.time_left > 0:
		countdownText.text = str(int($CountdownTimer.time_left + 1))

func _on_CountdownTimer_timeout():
	# start the round after a 3 second timeout (initial and after each score)
	get_tree().call_group('BallGroup', 'restart_ball')
	get_node("/root/Court/ScoreLabel/TimerLabel").visible = false

# ball entered one of the goals
func score_achieved(player):
	var playerLeftScoreLabel = get_node("/root/Court/ScoreLabel/PlayerLeftScore")
	var opponentScoreLabel = get_node("/root/Court/ScoreLabel/OpponentScore")
	var timerLabel = get_node("/root/Court/ScoreLabel/TimerLabel")

	if player == "playerRight":
		# increase score and update to score lable to reflect the added point
		opponentScore += 1
		opponentScoreLabel.text = str(opponentScore)
	
	if player == "playerLeft":
		# increase score and update to score lable to reflect the added point
		playerScore += 1
		playerLeftScoreLabel.text = str(playerScore)

	# stops the ball from moving after scoring
	get_tree().call_group('BallGroup', 'stop_ball')

	#reset everything to initial positions
	set_initial_positions()

	# start the 3 second timer between rounds
	$CountdownTimer.start()
	timerLabel.visible = true

	# plays the sound for achieving a score
	$ScoreSound.play()

# resets everything to initial positions checked the screen
func set_initial_positions():
	$Ball.position = Vector2(
		get_viewport().get_visible_rect().size.x / 2, get_viewport().get_visible_rect().size.y / 2)
	$PlayerLeft.position = Vector2(
		45, get_viewport().get_visible_rect().size.y / 2)

	if ($AIOpponent):
		$AIOpponent.position = Vector2(
			get_viewport().get_visible_rect().size.x - 45, get_viewport().size.y / 2)
	
	if ($PlayerRight):
		$PlayerRight.position = Vector2(
			get_viewport().get_visible_rect().size.x - 45, get_viewport().size.y / 2)

# pausing the game when the in-game menu is opened
func _on_InGameMenu_draw():
	get_tree().paused = true


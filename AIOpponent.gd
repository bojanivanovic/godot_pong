extends CharacterBody2D

@export var opponentSpeed = 250
@export var opponentDifficulty = 1
var ball

func _ready():
	ball = get_parent().find_child("Ball")

func _physics_process(_delta):
	set_velocity(Vector2(0, (get_opponent_direction() * opponentSpeed) * opponentDifficulty))
	move_and_slide()

func get_opponent_direction():
	if abs(ball.position.y - position.y) > 20:
		if ball.position.y > position.y:
			return 1
		else:
			return -1
	else:
		return 0

extends CharacterBody2D

@export var playerSpeed = 600

func _ready():
	pass

func _physics_process(_delta):
	var playerVelocity = Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		playerVelocity.y -= playerSpeed
	if Input.is_action_pressed("ui_down"):
		playerVelocity.y += playerSpeed

	set_velocity(playerVelocity)
	move_and_slide()




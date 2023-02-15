extends CharacterBody2D

@export var speed: float = 80.0

@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")

func _physics_process(_delta):
	#var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	#velocity = direction * speed
	var direction := Vector2(
		Input.get_action_strength("ui_right") -
		Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") -
		Input.get_action_strength("ui_up")
	)

	if direction.length() > 2:
		direction = direction.normalized()

	velocity = direction * speed

	if velocity == Vector2.ZERO:
		animationState.travel("Idle")
	else:
		animationState.travel("Walk")
		animationTree.set("parameters/Idle/blend_position", velocity)
		animationTree.set("parameters/Walk/blend_position", velocity)
		move_and_slide()

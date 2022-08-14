extends KinematicBody2D


var moveSpeed : int = 100
var jumpForce : int = 300
var gravity : int = 800

var vel : Vector2 = Vector2()
var grounded : bool = false

onready var sprite = $AnimatedSprite

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	#Reset Horizontal Velocity
	vel.x = 0
	
	#Movement Inputs
	
	if Input.is_action_pressed("move_left"):
		vel.x -= moveSpeed
	if Input.is_action_pressed("move_right"):
		vel.x += moveSpeed
	
	#applying the Velocity
	vel = move_and_slide(vel, Vector2.UP)
	
	#gravity
	vel.y += gravity * delta
	
	# jump inpout
	if Input.is_action_pressed("jump") and is_on_floor():
		vel.y -= jumpForce
	
	# sprite direction
	if vel.x < 0:
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false

func die ():
	get_tree().reload_current_scene()

#Restarts the Level if player falls off of the screen
func _on_VisibilityNotifier2D_screen_exited():
	get_tree().reload_current_scene()

extends RigidBody2D

# Constants
const JUMP_BUTTON = "player_jump"
enum State {STATE_NO_INPUT, STATE_IN_GAME, STATE_DEAD}


# Exports
export var jump_force = 100
export(State) var state = State.STATE_IN_GAME

# Signals
signal on_player_death

# Overrides
func _ready():
	pass

func _process(delta):
	match state:
		State.STATE_IN_GAME:
			poll_for_input()

func _on_Player_body_entered(body):
	if "Enemy" in body.get_groups():
		die()

# Functions
func jump():
	if linear_velocity.y < 0:
		linear_velocity.y = jump_force
	else:
		apply_impulse(global_position, Vector2(0, jump_force))

func poll_for_input():
	if Input.is_action_just_pressed(JUMP_BUTTON):
		jump()

func die():
	state = State.STATE_DEAD
	emit_signal("on_player_death")
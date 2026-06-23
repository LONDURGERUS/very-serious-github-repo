extends Node2D

enum WheelPEState{
	NORMAL_MODE,
	SPEED_UP_TRANSITION,
	SPEED_DOWN_TRANSITION,
	FAST_MODE
}

var state:WheelPEState = WheelPEState.NORMAL_MODE
var speed = 0;
var normal_speed = 75
var fast_speed = 750
var time = 0;
var time_until_max_time = 0;
var min_transition_time = 0.5
var max_transition_time = 1.5
var velocity_diff_multiplier = 2

func _process(delta: float) -> void:
	if time_until_max_time < time: # transition here
		if state == WheelPEState.SPEED_UP_TRANSITION:
			speed = lerp(
				normal_speed,
				fast_speed,
				time_until_max_time / time
			)
		else: # SPEED_DOWN_TRANSITION
			speed = lerp(
				fast_speed,
				normal_speed,
				time_until_max_time / time
			)
		print(speed)
		time_until_max_time += delta
		$smallPE.initial_velocity_min = speed
		$smallPE.initial_velocity_max = speed * velocity_diff_multiplier
		$bigPE.initial_velocity_min = speed
		$bigPE.initial_velocity_max = speed * velocity_diff_multiplier
	else:
		if state == WheelPEState.SPEED_UP_TRANSITION:
			state = WheelPEState.FAST_MODE
		elif state == WheelPEState.SPEED_DOWN_TRANSITION:
			state = WheelPEState.NORMAL_MODE

func start_speedup():
	state = WheelPEState.SPEED_UP_TRANSITION
	time = RandUtils.randf_range(min_transition_time, max_transition_time)
	time_until_max_time = 0

func start_slowdown():
	state = WheelPEState.SPEED_DOWN_TRANSITION
	time = RandUtils.randf_range(min_transition_time, max_transition_time)
	time_until_max_time = 0

func start_fast_pe_impact() -> void:
	match state:
		WheelPEState.NORMAL_MODE:
			start_speedup()
		WheelPEState.SPEED_DOWN_TRANSITION:
			start_speedup()

func stop_pe_impact() -> void:
	match state:
		WheelPEState.SPEED_UP_TRANSITION:
			start_slowdown()
		WheelPEState.FAST_MODE:
			start_slowdown()

func _on_check_button_toggled(toggled_on: bool) -> void:
	print(state)
	if toggled_on:
		start_fast_pe_impact()
	else:
		stop_pe_impact()

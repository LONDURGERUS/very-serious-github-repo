extends Node2D



func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	# Player takes damage from walls
	print("player health -1")


func _on_exit_area_body_entered(body: CharacterBody2D) -> void:
	# Exit to level 2 scene
	pass

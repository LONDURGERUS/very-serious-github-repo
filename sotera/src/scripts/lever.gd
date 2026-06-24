extends Node2D

@export var outline_thickness := 2.2

@onready var label: Label = $"Control/Label"
@onready var LeverSprite: Sprite2D = $"Lever"


func _on_area_2d_body_entered(body: Node2D) -> void:
	label.visible = true
	var tween = create_tween()
	tween.tween_property($Lever.material, "shader_parameter/thickness", outline_thickness, .15)

func _on_area_2d_body_exited(body: Node2D) -> void:
	label.visible = false
	var tween = create_tween()
	tween.tween_property($Lever.material, "shader_parameter/thickness", 0, .15)

func LeverPulled():
	LeverSprite.flip_h = true

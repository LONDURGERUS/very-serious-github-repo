extends Node2D

func _on_area_2d_body_entered(body: Node2D) -> void:
	print("Body Entered")
	$Button.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	print("Body Exited")
	$Button.hide()

func _on_button_pressed() -> void:
	Events.collect_contract.emit()
	SoundPool.play_sound(SoundPool.UI_PICKUP)
	SoundPool.play_sound(SoundPool.CONTRACT_PICKUP)
	Events.change_level("res://assets/scenes/FortuneWheelScene.tscn")
	

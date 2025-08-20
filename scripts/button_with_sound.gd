extends Button

class_name ButtonWithSound
@export var click_sound:AudioStream=preload("res://assets/audio/UI Pop.mp3")
@export var hover_sound:AudioStream=preload("res://assets/audio/UI Pop.mp3")



func _on_pressed() -> void:
    AudioManager.play_ui_sfx(click_sound.resource_path)


func _on_mouse_entered() -> void:
    AudioManager.play_ui_sfx(hover_sound.resource_path)

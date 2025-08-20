extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
    SceneLoader.is_switch=true

func enter():
    SceneLoader.change_scene("res://scenes/main_scene/begin_scene.tscn")

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("click_down"):
        if animation_player.is_playing():
            var anim_length=animation_player.current_animation_length
            animation_player.seek(anim_length)
    

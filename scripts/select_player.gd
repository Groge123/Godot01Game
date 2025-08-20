extends Control



func _on_enter_pressed() -> void:
    GlobalData.cur_Player=GlobalData.player_list[GlobalData.cur_player_name].instantiate()
    SceneLoader.change_scene_with_circle("res://scenes/main_scene/bg_map.tscn")


func _on_exit_pressed() -> void:
    SceneLoader.change_scene_with_circle("res://scenes/main_scene/begin_scene.tscn")
    
    

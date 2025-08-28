extends Control

@onready var punch: Button = $MarginContainer/VSplitContainer/MarginContainer/ScrollContainer/CenterContainer2/GridContainer/punch

@onready var weapon_data_card:= $MarginContainer/VSplitContainer/MarginContainer2/weapon_data_card

const WEAPON_DATA_DIR := "res://player_data/weapon_data/"

var cur_file: String
var cur_weapon: String
var cur_wp_data: Resource

func _ready() -> void:
    # 初始化时主动调用一次
    _update_weapon(punch.button_group.get_pressed_button())
    # 信号绑定
    punch.button_group.pressed.connect(_update_weapon)

# 用传入的 button 参数，避免多次查找
func _update_weapon(button: Button) -> void:
    cur_weapon = button.name
    cur_file = "%s%s.tres" % [WEAPON_DATA_DIR, cur_weapon]
    var res = load(cur_file)
    if res:
        cur_wp_data = res
        weapon_data_card.set_data(cur_wp_data)
    else:
        push_error("Failed to load weapon data: %s" % cur_file)


func _on_exit_pressed() -> void:
    SceneLoader.change_scene_with_progress("res://scenes/main_scene/bg_map.tscn")
    pass # Replace with function body.


func _on_enter_pressed() -> void:
    SceneLoader.change_scene_with_progress("res://scenes/main_scene/bg_map.tscn")
    GlobalData.cur_Player.first_weapon=cur_weapon
    pass # Replace with function body.

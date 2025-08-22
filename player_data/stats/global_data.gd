extends Node

const damage_text=preload("res://scenes/damage_text.tscn")

var boundary:Vector4
var cur_Player:Player
var cur_player_name:String="basic_player"
var player_list:Dictionary[String,Resource]=\
{"basic_player":preload("res://scenes/Character/basic_player.tscn")
,"assassin":preload("res://scenes/Character/assassin.tscn")
,"kindman":preload("res://scenes/Character/kindman.tscn")
,"rabbit":preload("res://scenes/Character/rabbit.tscn")
,"pirate":preload("res://scenes/Character/pirate.tscn")}


var Property={
    "player":
    [
    "health",
    "equip_radius",
    "shield",
    "critical_rate",
    "attack_power",
    "attack_speed",
    "move_speed"
    ],
    "enemy":[
        
    ]
    
}

signal create_map(boundary)

var quit_dialog:ExitDialog

func _ready() -> void:
    TranslationServer.set_locale("cn")
    cur_Player=player_list[cur_player_name].instantiate()
    create_map.connect(update_map)
    
    
    quit_dialog=preload("res://scenes/UI/ExitDialog.tscn").instantiate()
    get_tree().root.add_child.call_deferred(quit_dialog)
    
    
func update_map(m_size:Vector4):
    print(m_size)
    boundary=m_size

# 展示伤害数字
func show_damage_text(origin:Node2D,text:String,color:Color):
    var instance=damage_text.instantiate()
    instance.global_position=origin.global_position
    get_tree().current_scene.add_child(instance)
    instance.text=text
    instance.color=color
    
func _notification(what: int) -> void:
    if SceneLoader and SceneLoader.is_switch:
        return
    if what == NOTIFICATION_WM_GO_BACK_REQUEST:
        # 显示确认窗口，替代直接退出
        quit_dialog.show()
    elif what == NOTIFICATION_WM_CLOSE_REQUEST:
        # 处理桌面端关闭请求
        quit_dialog.show()
        
        

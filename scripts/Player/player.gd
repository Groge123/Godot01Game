extends Unit

class_name Player


var Data:UnitStats
# 玩家的移动方向向量（通常为归一化向量，如Vector2.RIGHT表示向右）
var move_dir: Vector2
# 玩家当前的移动速度向量（包含方向和速率信息）
var cur_velocity: Vector2
# 摇杆输入的方向向量（用于控制玩家移动方向）
var joystick_dir: Vector2
signal upgrade(level:int)

func _ready() -> void:
    Data=basic_data.duplicate()

func hurt(damage:int,is_critical:bool=false):
    if Data.health<=0:
        die()
        return
    if is_critical:
        damage*=2
    if Data.shield-damage>0:
        Data.shield-=damage
    else:
        Data.health=max(Data.health-damage+Data.shield,0)
        Data.shield=0
    
func die():
    print("die")
    var timer=Timer.new()
    timer.wait_time=1
    timer.start()
    await timer.timeout
    SceneLoader.change_scene_with_progress("res://scenes/main_scene/select_player.tscn")
    

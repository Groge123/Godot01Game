extends Player

class_name Basic_Player

@onready var weapons: Node2D = $Weapons
@onready var recover_shield_timer: Timer = $recover_shield_timer

var is_recover=false
var is_active=true
var all_weapon={
    "pistol":preload("res://scenes/weapon/pistol.tscn"),
    "punch":preload("res://scenes/weapon/punch.tscn")
}

    
func _ready() -> void:
    Data=basic_data.duplicate()
    #add_weapon("pistol")
    
    set_critical_rate(Data.critical_rate)
    var stick_dir=get_tree().current_scene.find_child("joystick")
    if stick_dir:
        stick_dir.connect("direction_changed",_on_direction)
    sort_weapon()
    

func _on_direction(dir:Vector2):
    joystick_dir=dir
    #print(dir)
        
func _process(delta: float) -> void:
    if is_active==false:
        return
    # 获取当前场景的根节点
    if joystick_dir!=Vector2.ZERO:
        move_dir=joystick_dir
    else:
        move_dir=Input.get_vector("move_left","move_right","move_up","move_down")
    cur_velocity=move_dir*Data.move_speed
    
    position += cur_velocity * delta
    position.x = clamp(position.x, GlobalData.boundary.x, GlobalData.boundary.z)
    position.y = clamp(position.y, GlobalData.boundary.y, GlobalData.boundary.w)
    
    update_anim()
    update_flip()
    recover_shield()
    update_level()
func recover_shield():
    if !is_recover:
        return
    var max_shield=Data.shield_base+Data.shield_add
    if Data.shield<max_shield:
        Data.shield+=1
        is_recover=false
        recover_shield_timer.wait_time=1.5
func update_level():
    if Data.cur_exp>=Data.exp_max:
        Data.level+=1
        Data.cur_exp=Data.exp_max-Data.cur_exp
        Data.exp_max*=Data.exp_increase_rate
        upgrade.emit(Data.level)


# 设置暴击率
func set_critical_rate(ct:float):
    for wp in weapons.get_children():
        wp.set_critical_rate(ct)
# 更新动画
func update_anim():
    if move_dir.length()>0:
        anim.play("move")
    else:
        sprite.rotation=0
        anim.play("idle")
# 更新翻转方向
func update_flip():
    if move_dir.x==0:
        return
    if move_dir.x>0:
        sprite.flip_h=true
    else:
        sprite.flip_h=false
# 添加武器
func add_weapon(type:String):
    if type in all_weapon.keys():
        var wp=all_weapon[type].instantiate()
        
        weapons.add_child(wp)
        sort_weapon()
        Data.cur_weapon.append(wp)
        print(wp._name)
# 整理武器position
func sort_weapon():
    var r = Data.equip_radius  # 分布半径
    if Data.cur_weapon.is_empty():
        return  # 无武器时直接返回
    var wp_num=weapons.get_child_count()
    # 计算相邻武器的角度间隔（360°均匀分布）
    var angle_step = 2 * PI / wp_num  # 例如3个武器时，间隔为120°（2π/3弧度）
    var i = 0
    for wp in weapons.get_children():
        # 核心：角度起始点为90°（Y轴正方向），向两侧均匀分布
        # 公式：初始角度（PI/2） ± 间隔角度的一半，确保Y轴对称
        var angle = PI/2 - (i * angle_step - angle_step * (wp_num - 1) / 2)
        # 极坐标转直角坐标
        wp.position = Vector2(
            r * cos(angle),  # X坐标（左右）
            r * sin(angle)   # Y坐标（上下）
        )
        i += 1

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
    recover_shield_timer.wait_time=1.5
    recover_shield_timer.start()
    is_recover=false
    
func die():
    if !is_active:
        return
    print("die")
    is_active=false
    anim.play("die")
    await anim.animation_finished
    SceneLoader.change_scene_with_progress("res://scenes/main_scene/select_player.tscn")

func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("coin"):
        area.pick_up.connect(pick_up_coins)
func pick_up_coins(val:int):
    Data.coins+=val


func _on_recover_shield_timeout() -> void:
    is_recover=true
    pass # Replace with function body.

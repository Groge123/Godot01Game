extends Player

class_name Basic_Player

@onready var weapons: Node2D = $Weapons

var all_weapon={
    "pistol":preload("res://scenes/weapon/pistol.tscn"),
    "punch":preload("res://scenes/weapon/punch.tscn")
}
var cur_weapon={
    
}


    
func _ready() -> void:
    init_data()
    
    for i in range(cur_weapon_num):
        add_weapon("pistol")
    
    set_critical_rate(cur_crit_rate)
    var stick_dir=get_tree().current_scene.find_child("joystick")
    if stick_dir:
        stick_dir.connect("direction_changed",_on_direction)
    sort_weapon()
    

func _on_direction(dir:Vector2):
    joystick_dir=dir
    #print(dir)
        
func _process(delta: float) -> void:
    # 获取当前场景的根节点
    if joystick_dir!=Vector2.ZERO:
        move_dir=joystick_dir
    else:
        move_dir=Input.get_vector("move_left","move_right","move_up","move_down")
    cur_velocity=move_dir*move_speed
    
    position += cur_velocity * delta
    position.x = clamp(position.x, GlobalData.boundary.x, GlobalData.boundary.z)
    position.y = clamp(position.y, GlobalData.boundary.y, GlobalData.boundary.w)
    
    update_anim()
    update_flip()
    
    update_level()
    
func update_level():
    if cur_exp>=cur_exp_max:
        level+=1
        cur_exp=cur_exp_max-cur_exp
        cur_exp_max*=(1+0.2)
        upgrade.emit(level)


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
        cur_weapon[type]=wp
        print(cur_weapon)
# 整理武器position
func sort_weapon():
    var r = cur_equip_radius  # 分布半径
    cur_weapon_num = weapons.get_child_count()
    
    if cur_weapon_num == 0:
        return  # 无武器时直接返回
    
    # 计算相邻武器的角度间隔（360°均匀分布）
    var angle_step = 2 * PI / cur_weapon_num  # 例如3个武器时，间隔为120°（2π/3弧度）
    var i = 0
    for wp in weapons.get_children():
        # 核心：角度起始点为90°（Y轴正方向），向两侧均匀分布
        # 公式：初始角度（PI/2） ± 间隔角度的一半，确保Y轴对称
        var angle = PI/2 - (i * angle_step - angle_step * (cur_weapon_num - 1) / 2)
        # 极坐标转直角坐标
        wp.position = Vector2(
            r * cos(angle),  # X坐标（左右）
            r * sin(angle)   # Y坐标（上下）
        )
        i += 1


func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("coin"):
        area.pick_up.connect(pick_up_coins)
        
        
func pick_up_coins(val:int):
    coin_num+=val

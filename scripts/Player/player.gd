extends Unit

class_name Player

# 玩家拥有的金币数量，初始为0
var coin_num = 0
# 玩家的移动方向向量（通常为归一化向量，如Vector2.RIGHT表示向右）
var move_dir: Vector2
# 玩家当前的移动速度向量（包含方向和速率信息）
var cur_velocity: Vector2
# 当前装备的武器编号（用于索引武器列表中的武器）
var cur_weapon_num: int
# 当前装备的作用半径（如拾取物品、攻击判定的范围）
var cur_equip_radius: int
# 最大可装备数量上限（限制同时装备的物品/武器总数）
var equip_max: int
# 当前的护盾值（优先于生命值承受伤害）
var cur_shield: int
# 最大生命值（玩家的生命上限）
var max_health: int
# 最大护盾值（护盾的容量上限）
var shield_max: int
# 当前经验值，初始为0（积累到一定值可升级）
var cur_exp: int = 0
# 升级所需的最大经验值（随等级提升而增加）
var cur_exp_max: int
# 玩家当前等级，初始为1
var level: int = 1
# 当前暴击率（触发暴击的概率，如0.05表示5%）
var cur_crit_rate: float
# 当前攻击力（基础伤害值）
var cur_attack_power: int
# 当前攻击速度（每秒攻击次数，值越大攻击越快，初始为1次/秒）
var cur_attack_speed: float = 1
# 摇杆输入的方向向量（用于控制玩家移动方向）
var joystick_dir: Vector2
signal upgrade(level:int)



func hurt(damage:int,is_critical:bool=false):
    if cur_health<=0:
        return
    if is_critical:
        damage*=2
    if cur_shield-damage>0:
        cur_shield-=damage
    else:
        cur_health=max(cur_health-damage-cur_shield,0)
        cur_shield=0
    if cur_health<=0:
        die()
func die():
    print(die)
    var timer=Timer.new()
    timer.wait_time=1
    timer.start()
    get_tree().root.add_child(timer)
    await timer.timeout
    SceneLoader.change_scene("res://scenes/main_scene/select_player.tscn")
        

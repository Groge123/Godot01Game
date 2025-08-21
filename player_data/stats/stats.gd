extends Resource

class_name UnitStats
enum UnitType
{
    PLAYER,
    ENEMY
}
# 当前属性
var attack_power:=2
var move_speed:=200
var health:=10
var critical_rate:=0.1
var shield:int=10 #护盾
var exp_max:int=10
var cur_exp:int=0
var exp_increase_rate:float=1.2
var coins:int=0
var attack_speed:float
var level:float=1
var cur_weapon:Array[Weapon]
var equip_radius:float

func _init() -> void:
    attack_power=attack_power_base
    move_speed=move_speed_base
    health=health_base
    critical_rate=critical_rate_base
    shield=shield_base
    attack_speed=attack_speed_base
    equip_radius=equip_radius_base
    
@export_category("基础信息")
@export var type: UnitType = UnitType.PLAYER  # 单位类型
@export var _name: String = "Unit"           # 正式名称
@export var nick_name: String = "Warrior"    # 昵称/简称
@export var icon: Texture2D

@export_category("基础属性")
@export var health_base: int = 10        # 基础最大生命值
@export var attack_power_base: int = 2             # 基础攻击力
@export var move_speed_base: float = 200     # 基础移动速度（像素/秒）
@export var shield_base: int = 10            # 基础护盾值
@export var critical_rate_base: float = 0.1  # 基础暴击率（0-1）
@export var attack_speed_base:float=1
@export var equip_radius_base:float=100
# 加成
var health_add: int = 0          # 最大生命值加成
var attack_power_add: int = 0              # 攻击力加成
var move_speed_add: float = 0        # 移动速度加成
var shield_add: int = 0              # 护盾值加成
var critical_rate_add: float = 0     # 暴击率加成
var attack_speed_add:float=0
var equip_radius_add:float=0

@export var equip_max:int=3


@export_category("Enemy")
@export var drop_glod=1
@export var drop_exp=2

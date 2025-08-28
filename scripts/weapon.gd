extends Node2D

class_name Weapon
var can_attack=true

@onready var sprite: Sprite2D = $Sprite
@onready var timer: Timer = $Timer
@onready var shader:ShaderMaterial=$Sprite.material

@export var weapon_data:weapon_stats
@export var attack_sound:AudioStream

@export var _name="weapon"
var target_rotation: float = 0.0
var target_enemy: Enemy = null
var init_rotation:float=0.0
var enemys_list:Array[Enemy]
var is_attacking=false

var cur_crit_rate:float # 暴击率
var interval_time:float # 冷却时间
var attack_range:float  #攻击范围
var basic_damage:int    #基础伤害 
var icon:Texture

func init_data():
    cur_crit_rate=weapon_data.critical_chance
    interval_time=weapon_data.attack_speed_base
    attack_range=weapon_data.attack_range
    basic_damage=weapon_data.basic_damage
    icon=weapon_data.icon
func _ready() -> void:
    init_data()
    set_interval_time(interval_time)


func _process(delta):
    if GlobalData.cur_Player:
        var at_speed=weapon_data.attack_speed_base/GlobalData.cur_Player.Data.attack_speed
        $Timer.wait_time=max(at_speed,0.0)
    update_rotation()
    
    update_nearest_enemy()
    

# 更新旋转动画（不阻塞_process）
func update_rotation():
    if GlobalData.cur_Player:
        sprite.flip_h=!GlobalData.cur_Player.sprite.flip_h
    if target_enemy:
        # 计算朝向目标的角度
        var direction = target_enemy.global_position - sprite.global_position
        var angle=direction.angle()
        
        if abs(angle)>PI/2:
            if angle>0:
                target_rotation = -(PI-abs(direction.angle()))
            else:
                target_rotation = (PI-abs(direction.angle()))
            sprite.flip_h=true
        else:
            sprite.flip_h=false
            target_rotation = direction.angle()
        
    else:
        # 没有目标时回到初始旋转
        target_rotation = init_rotation
    
    # 播放旋转动画（用tween的自动销毁，避免重复创建导致的问题）
    var tw = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN_OUT)
    tw.tween_property($Sprite, "rotation", target_rotation, 0.05)
func update_nearest_enemy():
    if !can_attack or enemys_list.is_empty():
        return
    var nearest_enemy: Enemy = null
    var min_distance: float = INF
    
    for enemy in enemys_list:
        if not enemy or !enemy.active:
            enemys_list.erase(enemy)
            continue
        # 计算与当前武器的距离
        var distance = global_position.distance_to(enemy.global_position)
        # 找到最近的敌人
        if distance < min_distance:
            min_distance = distance
            nearest_enemy = enemy
    
    target_enemy = nearest_enemy

func set_init_rotation(rot:float):
    init_rotation=rot

func set_critical_rate(ct:float):
    cur_crit_rate=ct+weapon_data.critical_chance
        
func set_interval_time(time:float):
    $Timer.wait_time=time
func _on_detect_area_area_entered(area: Area2D) -> void:
    if area.is_in_group("enemy"):
        enemys_list.append(area)

func _on_timer_timeout() -> void:
    can_attack=true
    $Sprite/attack_area.visible=true

func _on_detect_area_area_exited(area: Area2D) -> void:
    if area.is_in_group("enemy"):
        if area in enemys_list:
            enemys_list.erase(area)
            target_enemy=null
            #print("leave the area")
        $Sprite/attack_area.visible=false

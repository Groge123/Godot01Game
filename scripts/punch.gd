extends Weapon

class_name Punch


@onready var detect_area: Area2D = $detect_area

var attack_dir:Vector2
var attack_speed=100

func _ready() -> void:
    super._ready()
    
func _process(delta: float) -> void:
    super._process(delta)
    attack(delta)
func attack(delta:float):
    # 确保一次只执行一个攻击动画
    if not can_attack or not target_enemy:
        return
    
    is_attacking = true
    can_attack = false  # 立即禁用攻击
    
    # 创建一个完整的攻击+返回动画序列
    var tween = get_tree().create_tween()
    
    # 1. 攻击前的预备动作（可选）
    tween.tween_property(
        $Sprite, 
        "position", 
        -2 * (target_enemy.global_position - global_position).normalized(), 
        0.1
    )
    
    # 2. 攻击动作（接近敌人）
    tween.tween_property(
        $Sprite, 
        "global_position", 
        target_enemy.global_position, 
        0.1
    )
    #print("attack")
    
    # 3. 攻击后返回原点
    tween.tween_property($Sprite, "position", Vector2(0, 0), 0.2)
    
    # 动画序列完成后重置状态
    tween.finished.connect(func():
        is_attacking = false
        timer.start()  # 开始冷却计时
    )
    

func _on_attack_area_area_entered(area: Area2D) -> void:
    if area.is_in_group("enemy"):
        var rate=randf()
        if rate<cur_crit_rate:
            area.hurt(basic_damage*2,true)
            #print("暴击")
        else:
            area.hurt(basic_damage)
        AudioManager.play_sfx(attack_sound.resource_path)
        #$Sprite/attack_area.visible=false
        is_attacking=true

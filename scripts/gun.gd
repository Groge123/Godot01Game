extends Weapon

class_name Pistol
@onready var fire_pos: Node2D = $Sprite/fire_pos

@export var bullet=preload("res://scenes/weapon/bullet.tscn")
func _ready() -> void:
    super._ready()
    
func _process(delta: float) -> void:
    super._process(delta)
    shoot()


func shoot():
    if can_attack and target_enemy:
        var b=bullet.instantiate()
        b.global_position=fire_pos.global_position
        b.rotation=Vector2(target_enemy.global_position-global_position).angle()
        b.target_group=b.groups.enemy
        var is_crit=randf()<cur_crit_rate
        
        get_tree().root.add_child(b)
        b.shoot(target_enemy,basic_damage,is_crit)
        AudioManager.play_sfx(attack_sound.resource_path)
        can_attack=false
        timer.start()
        

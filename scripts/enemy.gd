extends Unit

class_name Enemy
@onready var vision_area: Area2D = $vision_area
@onready var health_bar: Control = $health_bar

@onready var enemy: Area2D = $"."
@export var push_force:int
@export var coin_scene:PackedScene

var active=true

var can_move=true
var cur_drop_glod:int
var cur_drop_exp:int

var dir:Vector2=Vector2.ZERO

func load_data():
    cur_drop_exp=basic_data.drop_exp
    cur_drop_glod=basic_data.drop_glod
    move_speed=basic_data.move_speed
    cur_health=basic_data.health
    health_max=basic_data.health
    icon=basic_data.icon

func _ready() -> void:
    load_data()
    sprite.texture=basic_data.icon
    get_direction()


func _process(delta: float) -> void:
    if active==false:
        return
    
    if can_move:
        move(delta)
    if cur_health<=0:
        die()
func move(delta):
    get_direction()
    var velocity=dir*move_speed*delta
    position+=velocity
    global_position.x = clamp(global_position.x, GlobalData.boundary.x, GlobalData.boundary.z)
    global_position.y = clamp(global_position.y, GlobalData.boundary.y, GlobalData.boundary.w)
    
func hurt(damage:int,is_critical=false):
    if cur_health<=0:
        return 
    var tween=get_tree().create_tween()
    tween.tween_property($".","position",position-dir*move_speed*0.1,0.1)
    var text_color=Color.WHITE
    if is_critical:
        text_color=Color.RED
        damage*=2
    #print('hit')
    cur_health-=damage
    if cur_health<=0:
        cur_health=0
    GlobalData.show_damage_text(self,str(damage),text_color)
    

func die():
    active=false
    anim.play("die")
    await anim.animation_finished
    
    spawn_coins()
    GlobalData.cur_Player.cur_exp+=cur_drop_exp
    
    queue_free()
# 生成金币
func spawn_coins():
    for i in cur_drop_glod:
        #print(str(i),"coin")
        var coin=coin_scene.instantiate()
        var offset=Vector2(randf_range(-5,5),randf_range(-5,5))
        coin.global_position=global_position+offset
        get_tree().current_scene.add_child(coin)

# 获取玩家方向
func get_direction():
    dir=global_position.direction_to(GlobalData.cur_Player.global_position).normalized()
    
    if dir.x>0:
        sprite.flip_h=true
    else:
        sprite.flip_h=false
    var enemys=vision_area.get_overlapping_areas()
    for e in enemys:
        if e!=self and e.is_inside_tree():
            var to_enemy=global_position-e.global_position
            dir+=push_force*to_enemy.normalized()/to_enemy.length()
            
func _on_area_entered(area: Area2D) -> void:
    if area.is_in_group("player"):
        area.hurt(basic_data.attack_power)

extends Area2D

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _ready() -> void:
    # 确保形状是圆形
    if collision_shape_2d.shape is CircleShape2D:
        # 创建新的圆形形状并设置半径
        var circle_shape = CircleShape2D.new()
        circle_shape.radius = $"..".weapon_data.attack_range
        
        # 替换原有的形状（关键！）
        collision_shape_2d.shape = circle_shape
        
        print("设置碰撞半径为:", circle_shape.radius)
    else:
        print("错误：CollisionShape2D的形状不是圆形!")

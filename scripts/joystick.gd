extends CanvasLayer

@onready var radius: Sprite2D = $radius
@onready var dragbtn: Sprite2D = $radius/dragbtn

signal direction_changed

var is_dragging = false
var radius_size = 0.0
var start_position = Vector2.ZERO
var current_direction = Vector2.ZERO

func _ready() -> void:
    radius_size = radius.texture.get_width() / 2
    dragbtn.visible = false
    radius.visible = false
    
    # 设置鼠标过滤

func _input(event: InputEvent) -> void:
    # 鼠标/触摸按下
    if event is InputEventScreenTouch and event.is_pressed():
        start_drag(event.position)
    
    # 鼠标/触摸释放
    elif event is InputEventScreenTouch and not event.is_pressed():
        end_drag()
    
    # 拖拽（在Godot 4.x中，拖拽事件包含在ScreenTouch中）
    elif event is InputEventScreenDrag:
        update_drag(event.position)


func start_drag(position: Vector2) -> void:
    # 只在左半边屏幕移动
    if position.x>get_viewport().size.x/2:
        return
    is_dragging = true
    start_position = position
    
    # 设置摇杆位置并显示
    radius.global_position = position
    radius.visible = true
    dragbtn.visible = true
    dragbtn.position = Vector2.ZERO  # 重置按钮位置到中心
    
    current_direction = Vector2.ZERO

func update_drag(position: Vector2) -> void:
    if not is_dragging:
        return
    
    # 计算从摇杆中心到拖拽点的向量
    var direction = position - start_position
    var distance = direction.length()
    
    # 如果拖拽距离超过摇杆半径，限制在圆内
    if distance > radius_size:
        direction = direction.normalized() * radius_size
    else:
        direction = direction
    
    # 设置按钮位置（相对于摇杆）
    dragbtn.position = direction
    
    # 更新当前方向（归一化向量）
    current_direction = direction.normalized()
    direction_changed.emit(current_direction)    

func end_drag() -> void:
    is_dragging = false
    radius.visible = false
    dragbtn.visible = false
    current_direction = Vector2.ZERO
    direction_changed.emit(current_direction)

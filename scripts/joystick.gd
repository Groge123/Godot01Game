extends CanvasLayer

@onready var radius: Sprite2D = $radius
@onready var dragbtn: Sprite2D = $radius/dragbtn

signal direction_changed

var is_dragging = false
var radius_size = 0.0
var start_position = Vector2.ZERO
var current_direction = Vector2.ZERO
var active_touch_id = -1  # 跟踪当前激活的触摸ID

func _ready() -> void:
    radius_size = radius.texture.get_width() / 2
    dragbtn.visible = false
    radius.visible = false

func _input(event: InputEvent) -> void:
    # 处理触摸按下事件
    if event is InputEventScreenTouch:
        if event.is_pressed():
            # 修正：使用event.position获取触摸位置，而非未定义的position
            if event.position.x < get_viewport().size.x/2 and not is_dragging:
                active_touch_id = event.index
                start_drag(event.position)
        else:
            # 只有对应的触摸ID才能结束拖拽
            if event.index == active_touch_id:
                end_drag()
                active_touch_id = -1  # 重置触摸ID
    
    # 处理触摸拖拽事件
    elif event is InputEventScreenDrag:
        # 只有对应的触摸ID才能更新拖拽
        if event.index == active_touch_id and is_dragging:
            update_drag(event.position)

func start_drag(position: Vector2) -> void:
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

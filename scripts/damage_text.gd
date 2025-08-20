extends Node2D
class_name Damage_text

@onready var label: Label = $Label

var text:String:
    set(tex):
        $Label.text=tex
    get():
        return $"Label".text
        
var color:Color:
    set(col):
        $Label.add_theme_color_override("font_color",col)
    get():
        return $"Label".get_theme_color("font_color")
func _ready() -> void:
    modulate.a=0
   # 初始化状态
    modulate = Color(modulate.r, modulate.g, modulate.b, 0)
    scale = Vector2(0.8, 0.8)
    rotation = 0
    
    var tween = get_tree().create_tween()
    tween.set_ease(Tween.EASE_OUT)
    
    # 第一阶段：快速弹出并显示
    tween.set_parallel(true)
    # 淡入
    tween.tween_property(self, "modulate:a", 1, 0.15)
    # 快速放大
    tween.tween_property(self, "scale", Vector2(2.2, 2.2), 0.2).set_ease(Tween.EASE_OUT)
    # 轻微旋转
    tween.tween_property(self, "rotation", randf_range(-0.3, 0.3), 0.1)
    tween.set_parallel(false)
    
    # 第二阶段：弹跳效果
    tween.tween_property(self, "scale", Vector2(1.8, 1.8), 0.1).set_ease(Tween.EASE_IN)
    tween.tween_property(self, "scale", Vector2(2.0, 2.0), 0.1).set_ease(Tween.EASE_OUT)
    
    # 第三阶段：缓慢消失
    tween.set_parallel(true)
    # 缓慢缩小
    tween.tween_property(self, "scale", Vector2(1.2, 1.2), 0.3)
    # 逐渐上移（增加上升效果）
    tween.tween_property(self, "position", position + Vector2(0, -20), 0.4)
    # 淡出
    tween.tween_property(self, "modulate:a", 0, 0.3).set_delay(0.1)
    
    ## 暴击特效：添加颜色变化
    #if is_critical:
        #tween.tween_property(self, "modulate", Color(1, 0.3, 0.3), 0.1)  # 变红
        #tween.tween_property(self, "modulate", Color(1, 0.7, 0.7), 0.3)  # 稍微淡化
    #
    tween.set_parallel(false)
    tween.tween_callback(self.queue_free)

func set_text(tex:String):
    label.text=tex
   


    

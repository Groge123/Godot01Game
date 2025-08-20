extends CanvasLayer

@onready var color_rect: ColorRect = $ColorRect

var is_switch = false  # 初始化为false，因为初始状态是隐藏的

func change_scene(path:String):
    layer = 1000
    color_rect.show()
    is_switch = true  # 显示时设置为true
    
    var tween = create_tween()
    tween.tween_property(color_rect,"color:a",1.0,0.2)
    await tween.finished
    
    await change_scene_async(path)
    
    var tween_out = create_tween()
    tween_out.tween_property(color_rect,"color:a",0.0,0.3)
    await tween_out.finished
    
    color_rect.hide()
    is_switch = false  # 隐藏时设置为false

func change_scene_with_circle(path:String):
    color_rect.color.a = 1
    var shader:ShaderMaterial = color_rect.material
    layer = 1000
    color_rect.show()
    is_switch = true  # 显示时设置为true
    
    print(shader.get_shader_parameter("_Radius"))
    var tween = create_tween()
    tween.set_ease(Tween.EASE_IN)
    tween.tween_method(func(value):
        shader.set_shader_parameter("_Radius", value)
    , 1.0, 0.0, 0.5)
    await tween.finished
    print(color_rect.material.get_shader_parameter("_Radius"))
    
    await change_scene_async(path)
    
    var tween_out = create_tween()
    tween_out.tween_method(func(value):
        shader.set_shader_parameter("_Radius", value)
    , 0.0, 1.0, 0.5)
    await tween_out.finished
    
    color_rect.hide()
    is_switch = false  # 隐藏时设置为false

func change_scene_async(path:String):
    ResourceLoader.load_threaded_request(path)
    
    while ResourceLoader.load_threaded_get_status(path) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
        await get_tree().create_timer(0.05).timeout
    
    if ResourceLoader.load_threaded_get_status(path) == ResourceLoader.THREAD_LOAD_LOADED:
        get_tree().change_scene_to_packed(ResourceLoader.load_threaded_get(path))

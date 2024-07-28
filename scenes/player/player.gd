class_name Player extends CharacterBody2D

## 玩家血量更新发出信号
signal player_health_update(health : int, max_health : int)
## 玩家死亡时发出信号
signal player_is_dead
## 分数更新的信号
signal count_update
## 力场护盾时间更新发出信号
signal energy_time_update(time : float)
## 减速器时间更新发出信号
signal deceleration_time_update(time : float)
## 重力消除器时间更新发出信号
signal agravity_time_update(time : float)
## 临时护甲时间更新发出信号
signal damaged_armour_time_update(time : float)
## 黑洞被激活发出信号
signal black_hole_is_enable
## 重力反转激活发出信号
signal reversal_is_update
## 边界坍塌发出信号
signal line_minification(minification : int)

## 血量模块
@onready var health_module: HealthModule = $HealthModule
## VHS效果
@onready var vhs: ColorRect = %VHS
## 力场护盾区域
@onready var force_field: Area2D = $ForceField
## 力场护盾的特效
@onready var energy_shield: Sprite2D = $EnergyShield
## 动画器
@onready var animation_player: AnimationPlayer = $AnimationPlayer
## 力场护盾的计时器
@onready var energy_timer: Timer = $EnergyTimer
## 减速器的计时器
@onready var deceleration_timer: Timer = $DecelerationTimer
## 重力消除器的计时器
@onready var agravity_timer: Timer = $AgravityTimer
## 临时护甲的计时器
@onready var damaged_armour_timer: Timer = $DamagedArmourTimer
## 减速器的区域
@onready var deceleration_zone: Area2D = %DecelerationZone
## 激光发射器的激光
@onready var ray_cast_2d: RayCast2D = $RayCast2D

## 跳跃的力
@export var jump_speed : float = -400.
## 漂浮时间
@export var suspension_time : float = 1.5

## 重力
var gravity : float = 14.7
## 是否反转重力
var up_or_down : bool = true:
	set(v):
		up_or_down = v
		reversal_is_update.emit()
## 是否开启VHS
var is_vhs : bool = false
## 是否有备用飞船
var has_spare_ship : bool = false:
	set(v):
		has_spare_ship = v
		if has_spare_ship:
			animation_player.play("idle")
		else :
			animation_player.stop()
## 是否在漂浮
var is_suspension : bool = true
## 当前漂浮时间
var current_suspension_time : float
## 是否处于无重力
var agravity : bool = false

func _ready() -> void:
	health_module.max_health = Game.health
	health_module.reset_health()
	current_suspension_time = suspension_time

func _process(delta: float) -> void:
	vhs.visible = is_vhs
	if is_suspension and velocity.y == 0 and not agravity:
		current_suspension_time -= delta
		if current_suspension_time <= 0:
			current_suspension_time = suspension_time
			is_suspension = false
			Game.count -= Game.difficulty_multiple
			count_update.emit()
	if not is_suspension:
		current_suspension_time -= delta
		if current_suspension_time <= 0:
			current_suspension_time = suspension_time
			is_suspension = true
	if up_or_down:
		if velocity.y > 0:
			rotation_degrees += (delta * 35)
		elif velocity.y < 0:
			rotation_degrees -= (delta * 20)
		rotation_degrees = clamp(rotation_degrees, -15, 15)
	else :
		if velocity.y > 0:
			rotation_degrees += (delta * 20)
		elif velocity.y < 0:
			rotation_degrees -= (delta * 35)
		rotation_degrees = clamp(rotation_degrees, -15, 15)

func _physics_process(delta: float) -> void:
	if ray_cast_2d.is_colliding():
		var body : Asteroid = ray_cast_2d.get_collider()
		if body is Asteroid:
			Game.count += Game.difficulty_multiple
			count_update.emit()
			body.destory()

	if agravity:
		velocity.y = 0
		if Input.is_action_pressed("jump"):
			var tween : Tween = create_tween()
			tween.tween_property(self, "global_position:y", get_global_mouse_position().y, .5)
	elif up_or_down:
		velocity.y += gravity

		if Input.is_action_just_pressed("jump"):
			velocity.y = jump_speed
	else :
		velocity.y -= gravity

		if Input.is_action_just_pressed("jump"):
			velocity.y = -jump_speed
	if Input.is_action_pressed("suspension") and is_suspension and Game.count > Game.difficulty_multiple and not agravity:
		velocity.y = 0


	velocity.x = 0
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Asteroid:
		health_module.health -= 1
		body.destory()

	if body is Prop:
		if body is ForceFieldGalaxy:

			if energy_shield.visible:
				print("多余的道具，进行销毁")
				Game.count += (10 * Game.difficulty_multiple)
				count_update.emit()
			else :
				energy_open()
				energy_timer.timeout.connect(energy_close)
				energy_timer.wait_time = 10
				energy_timer.start()

				energy_time_update.emit(energy_timer.wait_time)

		if body is DecelerationMachine:
			if deceleration_zone.monitoring:
				Game.count += (10 * Game.difficulty_multiple)
				count_update.emit()
			else :
				deceleration_open()
				deceleration_timer.timeout.connect(deceleration_close)
				deceleration_timer.wait_time = 5
				deceleration_timer.start()

				deceleration_time_update.emit(deceleration_timer.wait_time)

		if body is GravityEliminator:
			if agravity:
				Game.count += (10 * Game.difficulty_multiple)
				count_update.emit()
			else :
				agravity_open()
				agravity_timer.timeout.connect(agravity_close)
				agravity_timer.wait_time = 20
				agravity_timer.start()

				agravity_time_update.emit(agravity_timer.wait_time)

		if body is DamagedArmour:
			if health_module.max_health != 7 - Game.difficulty_multiple * 2:
				Game.count += 15 * Game.difficulty_multiple
				count_update.emit()
			else :
				damaged_armour_open()
				damaged_armour_timer.timeout.connect(damaged_armour_close)
				damaged_armour_timer.wait_time = 15
				damaged_armour_timer.start()

				damaged_armour_time_update.emit(damaged_armour_timer.wait_time)

		if body is SpareShip:
			if has_spare_ship:
				Game.count += 30 * Game.difficulty_multiple
				count_update.emit()
			else :
				has_spare_ship = true

		if body is BlackHole:
			black_hole_is_enable.emit()

		if body is RepairTool:
			if health_module.health != health_module.max_health:
				health_module.health += 1
			else :
				Game.count += (10 * Game.difficulty_multiple)
				count_update.emit()

		if body is BoundaryStabilizer:
			line_minification.emit(50)

		if body is LaserTransmitter:
			ray_cast_2d.show()
			ray_cast_2d.enabled = true
			var ray_disenabled : Callable = func():
				ray_cast_2d.enabled = false
				ray_cast_2d.hide()

			get_tree().create_timer(1.5).timeout.connect(ray_disenabled)

		if body is FateDice:
			body.call_deferred("create_prop")

		body.destory()

func energy_open() -> void:
	energy_shield.show()
	force_field.monitoring = true
	energy_shield.scale = Vector2.ONE
	var tween : Tween = create_tween()
	tween.tween_property(energy_shield, "scale", Vector2.ONE * 3, .5)

func energy_close() -> void:
	var tween : Tween = create_tween()
	tween.tween_property(energy_shield, "scale", Vector2.ONE, .5)
	await tween.finished
	energy_shield.hide()
	energy_timer.timeout.disconnect(energy_close)
	force_field.monitoring = false

func deceleration_open() -> void:
	deceleration_zone.get_node("ColorRect").show()
	deceleration_zone.monitoring = true

func deceleration_close() -> void:
	deceleration_zone.get_node("ColorRect").hide()
	deceleration_timer.timeout.disconnect(deceleration_close)
	deceleration_zone.monitoring = false

func agravity_open() -> void:
	agravity = true

func agravity_close() -> void:
	agravity_timer.timeout.disconnect(agravity_close)
	agravity = false

func damaged_armour_open() -> void:
	health_module.max_health += 1
	health_module.health += 1
	player_health_update.emit(health_module.health, health_module.max_health)

func damaged_armour_close() -> void:
	health_module.max_health = 7 - Game.difficulty_multiple * 2
	health_module.reset_health()
	player_health_update.emit(health_module.health, health_module.max_health)

func _on_health_module_health_update(health: int, max_health : int) -> void:
	player_health_update.emit(health, max_health)


func _on_health_module_is_dead() -> void:
	if has_spare_ship:
		health_module.health = 1
		has_spare_ship = false
	else :
		player_is_dead.emit()


func _on_force_field_body_entered(body: Node2D) -> void:
	if body is Asteroid:
		Game.count += 1 * Game.difficulty_multiple
		count_update.emit()
		body.destory()

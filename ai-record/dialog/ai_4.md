以下是一个 `config.rs` 文件的实现，定义了您所需的参数，并通过环境变量设置时间细分度（默认0.01s）：

```rust
use std::env;

pub struct Config {
    // 圆柱半径
    pub cylinder_radius: f64,
    // 圆柱中心点
    pub cylinder_center: (f64, f64, f64),
    // 圆柱高度
    pub cylinder_height: f64,
    // 导弹速度
    pub missile_speed: f64,
    // 遮挡半径
    pub shadow_radius: f64,
    // 时间细分度（秒）
    pub time_step: f64,
}

impl Config {
    pub fn new() -> Result<Self, Box<dyn std::error::Error>> {
        // 从环境变量获取时间细分度，如果没有设置则使用默认值0.01
        let time_step = match env::var("TIME_STEP") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 0.01,
        };

        Ok(Self {
            cylinder_radius: 1.0,  // 默认值，可根据需要修改
            cylinder_center: (0.0, 0.0, 0.0),  // 默认值
            cylinder_height: 10.0,  // 默认值
            missile_speed: 100.0,  // 默认值
            shadow_radius: 2.0,  // 默认值
            time_step,
        })
    }

    // 如果需要从环境变量或其他配置源设置所有参数，可以添加更多方法
    pub fn from_env() -> Result<Self, Box<dyn std::error::Error>> {
        let time_step = match env::var("TIME_STEP") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 0.01,
        };

        let cylinder_radius = match env::var("CYLINDER_RADIUS") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 1.0,
        };

        let cylinder_center_x = match env::var("CYLINDER_CENTER_X") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 0.0,
        };

        let cylinder_center_y = match env::var("CYLINDER_CENTER_Y") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 0.0,
        };

        let cylinder_center_z = match env::var("CYLINDER_CENTER_Z") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 0.0,
        };

        let cylinder_height = match env::var("CYLINDER_HEIGHT") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 10.0,
        };

        let missile_speed = match env::var("MISSILE_SPEED") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 100.0,
        };

        let shadow_radius = match env::var("SHADOW_RADIUS") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 2.0,
        };

        Ok(Self {
            cylinder_radius,
            cylinder_center: (cylinder_center_x, cylinder_center_y, cylinder_center_z),
            cylinder_height,
            missile_speed,
            shadow_radius,
            time_step,
        })
    }
}

// 为Config实现Default trait，提供默认值
impl Default for Config {
    fn default() -> Self {
        Self {
            cylinder_radius: 1.0,
            cylinder_center: (0.0, 0.0, 0.0),
            cylinder_height: 10.0,
            missile_speed: 100.0,
            shadow_radius: 2.0,
            time_step: 0.01,
        }
    }
}
```

使用方法：

1. **基本使用**：
```rust
mod config;
use config::Config;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    let config = Config::new()?;
    println!("时间细分度: {}", config.time_step);
    Ok(())
}
```

2. **从环境变量设置所有参数**：
```rust
let config = Config::from_env()?;
```

3. **设置环境变量**：
```bash
# 在运行程序前设置环境变量
export TIME_STEP=0.005
export CYLINDER_RADIUS=2.5
export CYLINDER_CENTER_X=10.0
export CYLINDER_CENTER_Y=5.0
export CYLINDER_CENTER_Z=0.0
export CYLINDER_HEIGHT=15.0
export MISSILE_SPEED=200.0
export SHADOW_RADIUS=3.0

# 然后运行程序
cargo run
```

这个实现提供了：
- 明确的参数命名避免混淆（特别是多个半径参数）
- 灵活的环境变量配置
- 默认值保证程序总能运行
- 错误处理用于解析失败的情况
- 两种构造方式：简单默认值和完整环境变量配置

您可以根据实际需要调整默认值或添加更多的配置方式。
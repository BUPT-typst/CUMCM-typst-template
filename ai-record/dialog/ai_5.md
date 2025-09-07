以下是更新后的 `config.rs` 文件，使用您指定的默认值，并同时实现 `Default` trait 和从环境变量加载的功能：

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
    /// 从环境变量创建配置，使用默认值作为回退
    pub fn from_env() -> Result<Self, Box<dyn std::error::Error>> {
        let time_step = match env::var("TIME_STEP") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 0.01,
        };

        let cylinder_radius = match env::var("CYLINDER_RADIUS") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 7.0,
        };

        let cylinder_center_x = match env::var("CYLINDER_CENTER_X") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 0.0,
        };

        let cylinder_center_y = match env::var("CYLINDER_CENTER_Y") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 200.0,
        };

        let cylinder_center_z = match env::var("CYLINDER_CENTER_Z") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 5.0,
        };

        let cylinder_height = match env::var("CYLINDER_HEIGHT") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 10.0,
        };

        let missile_speed = match env::var("MISSILE_SPEED") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 300.0,
        };

        let shadow_radius = match env::var("SHADOW_RADIUS") {
            Ok(val) => val.parse::<f64>()?,
            Err(_) => 10.0,
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

    /// 便捷方法：创建配置（使用环境变量或默认值）
    pub fn new() -> Result<Self, Box<dyn std::error::Error>> {
        Self::from_env()
    }
}

// 为Config实现Default trait，提供默认值
impl Default for Config {
    fn default() -> Self {
        Self {
            cylinder_radius: 7.0,
            cylinder_center: (0.0, 200.0, 5.0),
            cylinder_height: 10.0,
            missile_speed: 300.0,
            shadow_radius: 10.0,
            time_step: 0.01,
        }
    }
}

// 为Config实现Display trait，便于调试和输出
impl std::fmt::Display for Config {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        write!(f, "Config {{\n")?;
        write!(f, "  cylinder_radius: {},\n", self.cylinder_radius)?;
        write!(f, "  cylinder_center: ({}, {}, {}),\n", 
               self.cylinder_center.0, self.cylinder_center.1, self.cylinder_center.2)?;
        write!(f, "  cylinder_height: {},\n", self.cylinder_height)?;
        write!(f, "  missile_speed: {},\n", self.missile_speed)?;
        write!(f, "  shadow_radius: {},\n", self.shadow_radius)?;
        write!(f, "  time_step: {}\n", self.time_step)?;
        write!(f, "}}")
    }
}

// 为Config实现Debug trait
impl std::fmt::Debug for Config {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        <Self as std::fmt::Display>::fmt(self, f)
    }
}
```

使用方法：

```rust
mod config;
use config::Config;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 方法1：使用默认值
    let default_config = Config::default();
    println!("默认配置:\n{}", default_config);
    
    // 方法2：从环境变量加载（如果环境变量不存在则使用默认值）
    let env_config = Config::from_env()?;
    println!("环境变量配置:\n{}", env_config);
    
    // 方法3：便捷方法（等同于from_env）
    let config = Config::new()?;
    println!("当前配置:\n{}", config);
    
    Ok(())
}
```

环境变量设置示例：

```bash
# 设置所有参数
export CYLINDER_RADIUS=8.0
export CYLINDER_CENTER_X=5.0
export CYLINDER_CENTER_Y=250.0
export CYLINDER_CENTER_Z=3.0
export CYLINDER_HEIGHT=12.0
export MISSILE_SPEED=350.0
export SHADOW_RADIUS=12.0
export TIME_STEP=0.005

# 或者只设置部分参数，其他使用默认值
export TIME_STEP=0.002
export MISSILE_SPEED=400.0

# 运行程序
cargo run
```

这个实现提供了：

1. **明确的默认值**：使用您指定的数值作为所有参数的默认值
2. **环境变量覆盖**：可以通过环境变量灵活地覆盖任何参数
3. **统一的接口**：`Config::new()` 和 `Config::from_env()` 都提供相同的功能
4. **友好的输出**：实现了 `Display` 和 `Debug` trait 便于调试
5. **错误处理**：环境变量解析失败时会返回错误

这样您就可以灵活地在开发时使用默认值，在部署时通过环境变量进行配置。
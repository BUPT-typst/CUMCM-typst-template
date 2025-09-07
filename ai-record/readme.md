# CUMCM AI支撑材料模板

```typ
// 使用示例

// 示例1：完整的对话记录
#let example_messages = (
  user_message(
    "你好！我想了解一下CMA-ES算法的基本原理。",
    timestamp: "2024-01-15 14:30:00"
  ),
  assistant_message(
    "你好！CMA-ES（Covariance Matrix Adaptation Evolution Strategy）是一种强大的进化算法，主要用于连续优化问题。它的核心思想是自适应地调整搜索分布的协方差矩阵，以提高搜索效率。",
    timestamp: "2024-01-15 14:30:15"
  ),
  user_message(
    "能具体解释一下协方差矩阵适应的过程吗？",
    timestamp: "2024-01-15 14:31:00"
  ),
  assistant_message(
    "当然可以！协方差矩阵适应过程包括以下几个步骤：\n\n1. *采样*：根据当前的均值和协方差矩阵生成候选解\n2. *评估*：计算每个候选解的适应度\n3. *选择*：选择最优的候选解\n4. *更新*：基于选中的解更新均值、协方差矩阵和步长\n\n这个过程会自动适应问题的几何结构，使搜索更加高效。",
    timestamp: "2024-01-15 14:31:30"
  ),
  system_message(
    "对话已保存到历史记录。",
    timestamp: "2024-01-15 14:32:00"
  )
)

#ai_chat(
  example_messages,
  title: "CMA-ES 算法讨论",
  show_timestamp: true
)

#pagebreak()

// 示例2：使用简化函数
#let simple_conversations = (
  ("什么是数学建模？", "数学建模是运用数学语言、方法和工具来描述、分析和解决实际问题的过程。"),
  ("数学建模的步骤有哪些？", "通常包括：问题分析、模型假设、模型建立、模型求解、结果分析和模型检验等步骤。"),
  ("谢谢你的解答！", "不客气！如果还有其他问题，随时可以问我。")
)

#quick_chat(simple_conversations, title: "数学建模基础问答")
```


## 使用方法

### 方法1：完整配置
```/dev/null/example.typ#L1-10
#let messages = (
  user_message("你的问题", timestamp: "2024-01-15 14:30:00"),
  assistant_message("AI的回答", timestamp: "2024-01-15 14:30:15")
)

#ai_chat(messages, title: "对话标题")
```

### 方法2：简化使用
```/dev/null/example.typ#L1-6
#let conversations = (
  ("问题1", "回答1"),
  ("问题2", "回答2")
)
#quick_chat(conversations)
```

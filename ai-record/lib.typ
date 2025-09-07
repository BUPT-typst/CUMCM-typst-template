// AI对话记录函数
// 用于格式化和显示多轮AI对话
#import "@preview/cmarker:0.1.6"
#import "@preview/mitex:0.2.4": mitex
// 主要的对话记录函数
#let ai_chat(
  messages,
  title: "AI 对话记录",
  show_timestamp: true,
  user_color: blue,
  ai_color: green,
  system_color: red,
  background: true
) = {
  set text(font: "SimSun")
  // 页面标题
  align(center)[
    #text(size: 18pt, weight: "bold")[#title]
    #v(1em)
  ]

  // 遍历所有消息
  for (index, message) in messages.enumerate() {
    let role = message.at("role", default: "user")
    let content = message.at("content", default: "")
    let timestamp = message.at("timestamp", default: none)

    // 根据角色选择颜色和图标
    let (color, icon, role_name) = if role == "user" {
      (user_color, "👤", "用户")
    } else if role == "assistant" {
      (ai_color, "🤖", "AI助手")
    } else if role == "system" {
      (system_color, "⚙️", "系统")
    } else {
      (black, "💬", role)
    }

    // 消息容器
    block(
      fill: if background { color.lighten(90%) } else { none },
      stroke: (left: 3pt + color),
      inset: 12pt,
      radius: 8pt,
      width: 100%,
      spacing: 0.8em
    )[
      // 消息头部（角色和时间戳）
      #grid(
        columns: (auto, 1fr, auto),
        align: (left, left, right),
        column-gutter: 8pt,
        [
          #text(fill: color, weight: "bold")[
            #icon #role_name
          ]
        ],
        [],
        if show_timestamp and timestamp != none [
          #text(size: 9pt, fill: gray)[
            #timestamp
          ]
        ]
      )

      // 消息内容
      #v(0.5em)
      #text(content)
    ]

    // 消息间距
    if index < messages.len() - 1 {
      v(0.6em)
    }
  }
}

// 便捷函数：创建用户消息
#let user_message(content, timestamp: none) = (
  role: "user",
  content: content,
  timestamp: timestamp
)

// 便捷函数：创建AI助手消息
#let assistant_message(content, timestamp: none) = (
  role: "assistant",
  content: content,
  timestamp: timestamp
)

// 便捷函数：创建系统消息
#let system_message(content, timestamp: none) = (
  role: "system",
  content: content,
  timestamp: timestamp
)

// 简化的对话函数（自动添加时间戳）
#let quick_chat(conversations, title: "AI 对话") = {
  let messages = ()

  for conv in conversations {
    if conv.len() >= 2 {
      messages.push(user_message(conv.at(0)))
      messages.push(assistant_message(conv.at(1)))
    }
  }

  ai_chat(messages, title: title)
}
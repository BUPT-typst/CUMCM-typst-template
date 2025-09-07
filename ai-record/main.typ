#import "lib.typ": *

#let conversations = (
  (
    [#cmarker.render(read("dialog/user_1.md"),math:mitex)],
    [#cmarker.render(read("dialog/ai_1.md"),math:mitex)]
  ),
)
#quick_chat(conversations,title:"函数生成-Claude 4 Sonnet")

#let conversations = (
  (
    [#cmarker.render(read("dialog/user_2.md"),math:mitex)],
    [#cmarker.render(read("dialog/ai_2.md"),math:mitex)]
  ),
)
#quick_chat(conversations,title:"函数总结-Claude 4 Sonnet")

#let conversations = (
  (
    [#cmarker.render(read("dialog/user_3.md"),math:mitex)],
    [#cmarker.render(read("dialog/ai_3.md"),math:mitex)]
  ),
)
#quick_chat(conversations,title:"函数编写-Deepseek V3.1")

#let conversations = (
  (
    [#cmarker.render(read("dialog/user_4.md"),math:mitex)],
    [#cmarker.render(read("dialog/ai_4.md"),math:mitex)]
  ),
  (
    [#cmarker.render(read("dialog/user_5.md"),math:mitex)],
    [#cmarker.render(read("dialog/ai_5.md"),math:mitex)]
  )
)
#quick_chat(conversations,title:"函数设计-Deepseek V3.1")
#let project(
  title: "A",
  problem_chosen: "A",
  team_number: "1234",
  college_name: " ",
  member: (
    first: " ",
    second: " ",
    third: " ",
  ),
  advisor: " ",
  date: none,

  header_display: true,

  body,
) = {

  // 文本和代码的字体
  let text_font = "Times New Roman"
  let songti = "SimSun"
  let heiti = "SimHei"
  let kaiti = "SimKai"
  let noto_serif_font = "Noto Serif CJK SC"
  let code_font = "DejaVu Sans Mono"

  let 字号 = (
    四号: 14pt, 小四: 12pt,
  )

  // 设置正文和代码的字体
  set text(font: (text_font, songti), size: 12pt, lang: "zh", region: "cn")
  show strong: set text(font: (text_font, noto_serif_font), size: 11.3pt)
  show emph: set text(font: (text_font, noto_serif_font), size: 11.3pt)
  show raw: set text(font: code_font, 10pt)

  // 设置文档元数据和参考文献格式
  set document(title: title)
  set bibliography(style: "gb-7714-2015-numeric")

  // 设置页面
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),

    footer: locate(loc =>{
      if loc.page() == 1 or loc.page() == 2 {return}
      [
        #align(center)[#counter(page).display("1")]
      ]
    })
  )

  //设置标题
  set heading(numbering: "1.1 ")

  show heading: it => box(width: 100%)[
    #v(0.50em)
    #set text(font: noto_serif_font, weight: "bold")
    #if it.numbering != none { counter(heading).display() }
    #it.body
  ]

  show heading.where(
    level: 1
  ): it => box(width: 100%)[
    #v(0.5em)
    #set align(center)
    #set heading(numbering: "一、")
    #it
    #v(0.75em)
  ]

  // 配置公式的编号和间距
  set math.equation(numbering: "(1.1)")
  show math.equation: eq => {
    set block(spacing: 0.65em)
    eq
  }

  // Main body
  set par(first-line-indent: 2em)

  let fieldvalue(value) = [
    #set align(center + horizon)
    #set text(size: 字号.小四)
    #grid(
      rows: (auto, auto),
      row-gutter: 0.2em,
      value,
      line(length: 100%, stroke: 0.5pt)
    )
  ]

  // cover
  text(size: 14pt)[赛区评阅编号（由赛区组委会填写）：]
  v(-8pt)
  align(center)[#line(length: 100%, stroke: (thickness: 1pt, dash: "solid"))]

  align(center)[
    #strong(text(size: 15pt, font: heiti)[2023年高教社杯全国大学生数学建模竞赛]) \ \
    #strong(text(size: 16pt, font: songti)[承 诺 书])
    #v(10pt)
  ]
  
  text[我们仔细阅读了《全国大学生数学建模竞赛章程》和《全国大学生数学建模竞赛参赛规则》（以下简称 “竞赛章程和参赛规则”，可从http://www.mcm.edu.cn下载）。] 

  parbreak()

  text[我们完全清楚，在竞赛开始后参赛队员不能以任何方式，包括电话、电子邮件、“贴吧”、QQ群、微信群等，与队外的任何人（包括指导教师）交流、讨论与赛题有关的问题；无论主动参与讨论还是被动接收讨论信息都是严重违反竞赛纪律的行为。]

  parbreak()

  strong(text[我们以中国大学生名誉和诚信郑重承诺，严格遵守竞赛章程和参赛规则，以保证竞赛的公正、公平性。如有违反竞赛章程和参赛规则的行为，我们将受到严肃处理。])

  parbreak()

  text[我们授权全国大学生数学建模竞赛组委会，可将我们的论文以任何形式进行公开展示（包括进行网上公示，在书籍、期刊和其他媒体进行正式或非正式发表等）。] 

  parbreak()
  v(15pt)

  block(width: 100%)[
    #grid(
      columns: (315pt, auto),
      text[#h(2em)我们参赛选择的题号（从A/B/C/D/E中选择一项填写）：],
      fieldvalue(problem_chosen),
    )
    #grid(
      columns: (285pt, auto),
      text[#h(2em)我们的报名参赛队号（12位数字全国统一编号）：],
      fieldvalue(team_number)
    )
    #grid(
      columns: (255pt, auto),
      text[#h(2em)参赛学校（完整的学校全称，不含院系名）：],
      fieldvalue(college_name)
    )
    #v(15pt)
    #grid(
      columns: (175pt, auto),
      row-gutter: 2em,
      text[#h(2em)参赛队员 (打印并签名) ：1.],
      fieldvalue(member.first),
      text[#h(1fr)2.#h(0.6em)],
      fieldvalue(member.second),
      text[#h(1fr)3.#h(0.6em)],
      fieldvalue(member.third),
    )
    #grid(
      columns: (265pt, auto),
      text[#h(2em)指导教师或指导教师组负责人  (打印并签名)：],
      fieldvalue(advisor)
    )

    #text(font: kaiti)[#h(2em)（指导教师签名意味着对参赛队的行为和论文的真实性负责） ]
    #v(10pt)

    #align(right)[#grid(
      columns: (auto, 55pt, auto, 25pt, auto, 25pt, auto),
      column-gutter: 2pt,
      text[日期：],
      fieldvalue(date.display("[year]")),
      text[年],
      fieldvalue(date.display("[month padding:none]")),
      text[月],
      fieldvalue(date.display("[day padding:none]")),
      text[日],
    )]
  ]

  v(10pt)
  strong(text(font: kaiti)[（请勿改动此页内容和格式。此承诺书打印签名后作为纸质论文的封面，注意电子版论文中不得出现此页。以上内容请仔细核对，如填写错误，论文可能被取消评奖资格。）])

  pagebreak()

  block()[
    #set align(center)
    #grid(
      columns: (100pt, 130pt, 100pt, 125pt),
      text[赛区评阅编号：（由赛区填写）],
      fieldvalue(v(30pt)),
      text[全国评阅编号：（全国组委会填写）],
      fieldvalue(v(30pt)),
    )
    #v(10pt)
    #line(length: 100%, stroke: (thickness: 1.5pt, dash: "solid"))
  ]

  align(center)[
    #strong(text(size: 15pt, font: heiti)[2023年高教社杯全国大学生数学建模竞赛]) 
    #v(10pt)
    #strong(text(size: 16pt, font: songti)[编 号 专 用 页])
  ]

  block(width: 100%)[
    #v(30pt)
    #set text(size: 14pt)
    #text[#h(4em)赛区评阅记录（可供赛区评阅时使用）：]
    #v(-10pt)

    #align(center)[#table(
      columns: (40pt, 55pt, 55pt, 55pt, 55pt, 55pt, 55pt),
      stroke: 0.75pt,
      inset: (y: 14pt),
      text[评 \ 阅 \ 人], "", "", "", "", "", "",
      text[备 \ 注]
    )]

    #v(75pt)
    #text[#h(3em)送全国评阅统一编号: ] \
    #text[#h(3em)（赛区组委会填写）]

  ]

  v(125pt)
  strong(text(font: kaiti)[（请勿改动此页内容和格式。此承诺书打印签名后作为纸质论文的封面，注意电子版论文中不得出现此页。以上内容请仔细核对，如填写错误，论文可能被取消评奖资格。）])
  
  pagebreak()

  body


}
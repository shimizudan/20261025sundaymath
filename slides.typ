// 1〜9で2026を作る — make 2026 puzzle を全部調べる（5分LT）
// touying + metropolisテーマ / A4横スライド
#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

// --- カラー定義（Juliaのロゴカラーを差し色に） ---
#let jl-blue   = rgb("#4063D8")
#let jl-green  = rgb("#389826")
#let jl-red    = rgb("#CB3C33")
#let jl-purple = rgb("#9558B2")
#let ink       = rgb("#1B1B1F")
#let sub-ink   = rgb("#5B5B66")
#let bg-soft   = rgb("#F4F5F9")
#let rule-col  = rgb("#D9DBE6")

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  align: top,
  footer: [1〜9で2026を作る],
  config-page(paper: "a4", flipped: true, margin: (top: 2.6em, bottom: 1.6em, x: 2.2em)),
  config-info(
    title: [1〜9 で 2026 を作る],
    subtitle: [make 2026 puzzle を Julia で全部調べてみた],
    author: [城北中学校・高等学校　数学科・校長　清水 団（X: \@dannchu）],
    date: [2026年10月25日],
    institution: [日曜数学会 \#37],
  ),
  config-colors(
    primary: jl-blue,
    primary-light: rgb("#AEC0F5"),
    secondary: jl-purple,
    neutral-lightest: rgb("#FDFDFE"),
    neutral-dark: sub-ink,
    neutral-darkest: ink,
  ),
)

#set text(font: "Hiragino Sans", lang: "ja", size: 19pt)
#set par(justify: false, leading: 0.85em)
#set list(marker: [#box(width: 7pt, height: 7pt, radius: 3.5pt, fill: jl-blue)])

// ============================================================
// タイトル
// ============================================================
#title-slide(extra: [
  #v(4pt)
  #grid(columns: (auto, auto), align: horizon, column-gutter: 12pt)[
    #box(
      width: 44pt, height: 44pt, radius: 22pt, clip: true,
      stroke: 1pt + rule-col,
      image("dannchu.jpg", width: 44pt, height: 44pt),
    )
  ][
    #box(width: 26pt, height: 26pt, radius: 13pt, fill: jl-purple)
    #h(5pt)
    #box(width: 26pt, height: 26pt, radius: 13pt, fill: jl-green)
    #h(5pt)
    #box(width: 26pt, height: 26pt, radius: 13pt, fill: jl-red)
    #h(5pt)
    #box(width: 26pt, height: 26pt, radius: 13pt, fill: jl-blue)
  ]
])

// ============================================================
// 1. 本の紹介（宣伝）
// ============================================================
#slide(title: [宣伝：Zennで本を書きました], composer: (1fr, 0.62fr))[
  #text(size: 20pt)[
    高校数学Bの統計的な推測を，#text(weight: "bold", fill: jl-blue)[数式による導出]と
    #text(weight: "bold", fill: jl-green)[Juliaによる数値実験]の両面から確かめる本です。
  ]
  #v(6mm)
  #set list(marker: [#box(width: 7pt, height: 7pt, radius: 3.5pt, fill: jl-purple)], spacing: 5mm)
  #text(size: 18pt)[
  - 全12章＋付録／プログラミング経験不要
  - 教える側・学ぶ側，どちらにもおすすめ
  ]
  #v(6mm)
  #block(fill: bg-soft, radius: 6pt, inset: 14pt, breakable: false)[
    #grid(columns: (auto, 1fr), align: horizon, column-gutter: 14pt)[
      #image("images/qr.png", width: 32mm)
    ][
      #text(size: 19pt, weight: "bold", fill: ink)[QRからZennの本のページへ]
      #v(3mm)
      #text(size: 15pt, fill: jl-blue)[zenn.dev/dannchu/books/statistical-inference-julia]
      #v(3mm)
      #text(size: 16pt, fill: sub-ink)[¥1,000 ／ 著者: \@dannchu]
    ]
  ]
][
  #align(center + horizon)[
    #box(
      stroke: 0.6pt + rule-col,
      radius: 4pt,
      clip: true,
      image("images/cover.png", height: 90mm),
    )
  ]
]

// 式の表示用（等幅数字）
#let ex(body) = text(font: ("Menlo", "Hiragino Sans"), body)
#let hl(body) = text(weight: "bold", fill: jl-red, body)

// ============================================================
// 2. 出題：SEIR62さんの make 2026 puzzle
// ============================================================
#slide(title: [きっかけ：make 2026 puzzle！])[
  // 出題画像は許諾をいただいてから表示する（show-tweet: true にする）
  #let show-tweet = true
  #align(center)[
    #if show-tweet {
      box(stroke: 0.6pt + rule-col, radius: 4pt, clip: true,
        image("images/seir62_2026.jpg", width: 82%))
    } else {
      block(fill: bg-soft, radius: 8pt, inset: (x: 28pt, y: 22pt), width: 82%)[
        #set align(left)
        #set par(leading: 1.1em)
        #text(size: 24pt)[
          1〜9 をこの順で用いて，\
          +，×，( )，数をつなげる操作のみで\
          #text(weight: "bold", fill: jl-red)[2026] を作って下さい。
        ]
        #v(4mm)
        #text(size: 20pt, fill: sub-ink)[例）#ex[100 = 1×(2+3)×4+56+7+8+9]]
      ]
    }
  ]
  #v(6mm)
  #align(center)[
    #text(size: 16pt, fill: sub-ink)[出典：SEIR62 さん（\@seir62）の X への投稿（2026年10月4日）\
    x.com/seir62/status/2106646993196204424]
  ]
]

// ============================================================
// 2a. 2026・2027 の作り方の例
// ============================================================
// 年の数と，式＋計算の流れのカード
#let yearcard(year, c, items) = block(fill: bg-soft, radius: 6pt, inset: 14pt, width: 100%)[
  #text(size: 34pt, weight: "bold", fill: c)[#ex[#year]]
  #v(2mm)
  #for (e, s) in items [
    #text(size: 19pt)[#ex[#e]] \
    #text(size: 15pt, fill: sub-ink)[#ex[#s]]
    #v(3mm)
  ]
]

#slide(title: [たとえば 2026・2027 はこう作れる])[
  #grid(columns: (1fr, 1fr), column-gutter: 8mm,
    yearcard("2026", jl-blue, (
      ("1+2+34×56+7×(8+9)", "= 3 + 1904 + 119"),
      ("1+(234+5+6+7)×8+9", "= 1 + 252×8 + 9 = 1 + 2016 + 9"),
      ("(12×3×4+5)×(6+7)+89", "= 149×13 + 89 = 1937 + 89"),
    )),
    yearcard("2027", jl-green, (
      ("123+(45+67)×(8+9)", "= 123 + 112×17 = 123 + 1904"),
      ("1×2+3×(4+56+7+8)×9", "= 2 + 3×75×9 = 2 + 2025"),
      ("(1+2×3×4+5)×67+8+9", "= 30×67 + 17 = 2010 + 17"),
    )),
  )
  #v(5mm)
  #set list(spacing: 5mm)
  #text(size: 18pt)[
  - #ex[1904 = 34×56 = 112×17] が 2026 にも 2027 にも登場
  - 2027 は #ex[2025 = 45#super[2]] に 2 を足すだけ
  ]
]

// ============================================================
// 3. 問い
// ============================================================
#slide(title: [2026 以外はどうなる？], composer: (1fr, 1fr))[
  #text(size: 20pt)[解けたあとに気になったこと：]
  #v(5mm)
  #set list(marker: [#box(width: 7pt, height: 7pt, radius: 3.5pt, fill: jl-red)], spacing: 7mm)
  - 2026 を作る式は#text(weight: "bold")[全部で何通り]？
  - そもそも#text(weight: "bold")[どんな数が作れる]？
  - #text(weight: "bold")[作れない数]はある？
  - 来年・再来年は大丈夫？
][
  #block(fill: bg-soft, radius: 6pt, inset: 14pt, width: 100%)[
    #text(weight: "bold", fill: ink, size: 19pt)[Julia で全部調べる]
    #v(4mm)
    #text(size: 17pt)[
      かっこの付け方まで含めて，#text(weight: "bold")[すべての式]を調べたい。
      #v(3mm)
      でも1つずつ式を作ると数が多すぎる…
      #v(3mm)
      → #text(weight: "bold", fill: jl-blue)[区間DP]（動的計画法）で，
      #text(weight: "bold")[値の集合]を区間ごとに積み上げる
    ]
  ]
]

// 区間DPの図用：数字の箱
#let dg(d, c) = box(width: 30pt, height: 34pt, radius: 4pt, fill: c.lighten(75%), stroke: 1pt + c,
  align(center + horizon, text(size: 20pt, weight: "bold", fill: ink, ex[#d])))
#let dgrow(ds, c) = ds.map(d => dg(d, c)).join(h(3pt))

// Juliaロゴ風の3つの丸
#let jl-dots(r) = {
  let dot(c) = circle(radius: r, fill: c)
  grid(columns: 2, column-gutter: r * 0.2, row-gutter: r * 0.05, align: center,
    grid.cell(colspan: 2, dot(jl-green)), dot(jl-red), dot(jl-purple))
}

// ============================================================
// 3-1. Julia 言語の紹介
// ============================================================
#slide(title: [使った言語：Julia], composer: (1.25fr, 1fr))[
  #set list(marker: [#box(width: 7pt, height: 7pt, radius: 3.5pt, fill: jl-purple)], spacing: 6mm)
  #text(size: 19pt)[
  - 2012年に公開された#text(weight: "bold")[科学技術計算向け]のプログラミング言語（無料・オープンソース）
  - #text(weight: "bold", fill: jl-green)[速い]：書きやすいのに C や Fortran に近い速さで動く
  - #text(weight: "bold", fill: jl-blue)[数式に近い]書き方ができる
  - 数学・統計・物理・機械学習などで使われている
  ]
  #v(6mm)
  #block(fill: bg-soft, radius: 6pt, inset: 12pt, width: 100%)[
    #text(size: 17pt)[今回の 1〜9 の全式の計算も #text(weight: "bold", fill: jl-green)[1秒未満]！]
  ]
][
  #align(center)[#jl-dots(28pt)]
  #v(6mm)
  #block(fill: bg-soft, radius: 6pt, inset: 14pt, width: 100%)[
    #set text(size: 17pt)
    #ex[julia> x = 2026] \
    #ex[julia> 2x + 1] \
    #text(fill: sub-ink)[#ex[4053]] \
    #v(2mm)
    #ex[julia> √2 + π] \
    #text(fill: sub-ink)[#ex[4.555806215962888]] \
    #v(2mm)
    #ex[julia> sum(1:9)] \
    #text(fill: sub-ink)[#ex[45]]
  ]
]

// ============================================================
// 3-2. JuliaCon Local Tokyo 2026 の紹介
// ============================================================
#slide(title: [JuliaCon Local Tokyo 2026], composer: (1.35fr, 1fr))[
  #text(size: 20pt)[#text(weight: "bold", fill: jl-purple)[日本初の JuliaCon Local] が開催！]
  #v(5mm)
  #set text(size: 19pt)
  #table(
    columns: (auto, 1fr),
    align: (left, left),
    stroke: (x, y) => (bottom: 0.4pt + rule-col),
    inset: (x: 8pt, y: 7pt),
    [*日程*], [2026年 #text(weight: "bold")[12月4日（金）・5日（土）]],
    [*会場*], [#text(weight: "bold")[東京大学 柏キャンパス]（千葉県柏市）],
    [*言語*], [日本語・英語],
    [*内容*], [基調講演・講演・チュートリアル・\ ポスターセッション・交流会],
  )
  #v(4mm)
  #text(size: 16pt, fill: sub-ink)[
    発表の募集（CfP）を受付中。チケット情報は今後公開予定。
  ]
][
  #align(center + horizon)[
    #jl-dots(18pt)
    #v(4mm)
    #image("images/juliacon_qr.png", width: 42mm)
    #v(2mm)
    #text(size: 15pt, fill: jl-blue)[juliacon.org/local/tokyo2026]
  ]
]

// ============================================================
// 3a. 区間DP① 最後の演算で分ける
// ============================================================
#slide(title: [区間DP①：式は「最後の演算」で2つに分かれる])[
  #text(size: 18pt)[どんな式でも，#text(weight: "bold")[最後に行う演算]で数字の列は左右の#text(weight: "bold")[連続した区間]に分かれる]
  #v(4mm)
  #align(center)[
    #text(size: 22pt)[#ex[12+3×(4+56)+7] #text(fill: jl-red, weight: "bold")[#ex[ \+ ]] #ex[89]]
    #v(2mm)
    #grid(columns: (auto, auto, auto), column-gutter: 10pt, align: horizon,
      [#dgrow(range(1, 8), jl-blue) \ #v(1mm) #text(size: 15pt, fill: jl-blue)[左：$d_1 dots.c d_7$]],
      text(size: 26pt, weight: "bold", fill: jl-red)[+],
      [#dgrow((8, 9), jl-green) \ #v(1mm) #text(size: 15pt, fill: jl-green)[右：$d_8 d_9$]],
    )
  ]
  #v(4mm)
  #block(fill: bg-soft, radius: 6pt, inset: 12pt, width: 100%)[
    #text(size: 17pt)[
      $S(i,j)$ ＝「数字 $d_i, dots, d_j$ から作れる値の集合」とすると
      $ S(i,j) = underbrace({d_i d_(i+1) dots.c d_j}, "全部つなげた数") union union.big_(k=i)^(j-1) underbrace({a+b, thin a times b | a in S(i,k), thin b in S(k+1,j)}, "区切り位置 " k " で左右に分けて結合") $
      区切り位置 $k$ をすべて試せば，入れ子のかっこも含めて#text(weight: "bold")[すべての式]を網羅できる
    ]
  ]
]

// ============================================================
// 3b. 区間DP② 1,2,3 の例
// ============================================================
#slide(title: [区間DP②：1, 2, 3 で表を作ってみる], composer: (1.45fr, 1fr))[
  #set text(size: 17pt)
  #table(
    columns: (auto, auto),
    align: (left, left),
    stroke: (x, y) => if y == 0 { (bottom: 1pt + sub-ink) } else { (bottom: 0.4pt + rule-col) },
    inset: (x: 8pt, y: 6pt),
    [*区間*], [*作れる値*],
    [$S(1,1), S(2,2), S(3,3)$], [$\{1\}, \{2\}, \{3\}$],
    [$S(1,2)$：#ex[12, 1+2, 1×2]], [$\{2, 3, 12\}$],
    [$S(2,3)$：#ex[23, 2+3, 2×3]], [$\{5, 6, 23\}$],
    table.cell(colspan: 2, fill: bg-soft)[
      $S(1,3)$：#ex[123] \ 
      #h(1em)$k=1$：$\{1\}$ と $S(2,3)$ → #ex[6, 23, 7, 6, 24, 23] \ 
      #h(1em)$k=2$：$S(1,2)$ と $\{3\}$ → #ex[5, 6, 6, 9, 15, 36] \ 
      #h(1em)→ $\{5, 6, 7, 9, 15, 23, 24, 36, 123\}$ の #text(weight: "bold", fill: jl-blue)[9 種類]
    ],
  )
][
  #text(weight: "bold", fill: ink, size: 19pt)[なぜ速い？]
  #v(3mm)
  #set list(spacing: 6mm)
  #text(size: 16pt)[
  - #text(weight: "bold")[短い区間から順に]計算するので，必要な部分の答えはいつも完成済み
  - 区間は 1〜9 で $9 times 10 slash 2 = 45$ 個だけ。一度作った表は#text(weight: "bold")[使い回す]
  - 同じ値になる式は#text(weight: "bold")[1つにまとめる]\ （式は約19万通り → 値は約4万種類）
  ]
  #v(3mm)
  #block(fill: bg-soft, radius: 6pt, inset: 10pt, width: 100%)[
    #text(size: 13pt)[
```julia
for len in 1:n, i in 1:n-len+1
    j = i + len - 1
    push!(S[i,j], つなげた数)
    for k in i:j-1
        for a in S[i,k], b in S[k+1,j]
            push!(S[i,j], a+b, a*b)
        end
    end
end
```
    ]
  ]
]

// ============================================================
// 4. 2026 は 14 通り
// ============================================================
#slide(title: [2026 を作る式は全部で 14 通り])[
  #set text(size: 21pt)
  #grid(columns: (1fr, 1fr), row-gutter: 5mm, column-gutter: 8mm,
    ex[1+2+34×56+7×(8+9)],             ex[1+(234+5+6+7)×8+9],
    ex[(12×3×4+5)×(6+7)+89],           ex[1+2×(3+4+5+6)×7×8+9],
    ex[1×2×(3×4×(5+6)×7+89)],          ex[1+2×(3+45)×(6+7+8)+9],
    ex[1+2×(3+4+5)×(6+78)+9],          ex[1+(2+3+4×(5+6×7+8))×9],
    ex[1+((2+3+4×5+6)×7+8)×9],         ex[1+2×(3+4)×(5+6+7)×8+9],
    ex[1+(2+3×4)×(5+6+7)×8+9],         ex[1+(2+3)×(45×6+(7+8)×9)],
    ex[1+((23+4)×5+6×(7+8))×9],        ex[1+(((2+3)×4+5+6)×7+8)×9],
  )
  #v(5mm)
  #block(fill: bg-soft, radius: 6pt, inset: 12pt, width: 100%)[
    #text(size: 15pt, fill: sub-ink)[
      数え方：#ex[(1+2)+3] と #ex[1+(2+3)] のように，結合法則でかっこの位置が違うだけの式は同じとみなす。
      （#ex[1×] をつけるだけの式は別に数える）
    ]
  ]
]

// ============================================================
// 5. 全体像
// ============================================================
#slide(title: [1〜9 で作れる数は 43,350 種類], composer: (1fr, 1fr))[
  #set text(size: 17pt)
  #table(
    columns: (auto, auto, auto),
    align: (left, right, right),
    stroke: (x, y) => if y == 0 { (bottom: 1pt + sub-ink) } else { (bottom: 0.4pt + rule-col) },
    inset: (x: 10pt, y: 5pt),
    [*使う数字*], [*値の種類*], [*式の数*],
    [1〜3], [9], [11],
    [1〜4], [32], [47],
    [1〜5], [133], [223],
    [1〜6], [532], [1,135],
    [1〜7], [2,285], [6,063],
    [1〜8], [9,874], [33,535],
    table.cell(fill: bg-soft)[*1〜9*], table.cell(fill: bg-soft)[*43,350*], table.cell(fill: bg-soft)[*190,399*],
  )
][
  #v(4mm)
  #set list(spacing: 8mm)
  #text(size: 19pt)[
  - 最小値は #ex[44 = 1×(2+3+…+9)]
  - 最大値は #ex[123456789]
  - 数字が1つ増えると，値も式も約4〜5倍
  - 全部の計算が #text(weight: "bold", fill: jl-green)[1秒未満] で終わる
  ]
]

// ============================================================
// 6. 作れない数
// ============================================================
#slide(title: [作れない数はどこにある？])[
  #text(size: 19pt)[44 以上で作れないのは，最初は次の5つだけ：]
  #v(3mm)
  #align(center)[#text(size: 30pt, weight: "bold", fill: ink)[#ex[47, 51, 52, 53, 58]]]
  #v(4mm)
  #text(size: 19pt)[そのあと #ex[59] から #ex[2037] までは#text(weight: "bold")[すべて作れる]。次に作れないのは…]
  #v(4mm)
  #align(center)[
    #block(fill: bg-soft, radius: 8pt, inset: (x: 30pt, y: 14pt))[
      #text(size: 40pt, weight: "bold", fill: jl-red)[#ex[2038]]
      #h(16pt)
      #text(size: 22pt, fill: sub-ink)[その次は #ex[2062]]
    ]
  ]
  #v(4mm)
  #text(size: 18pt, fill: sub-ink)[
    → このパズルは #text(weight: "bold", fill: ink)[2037年まで毎年遊べる]けど，2038年は出題できない（奇しくも「2038年問題」の年）
  ]
  #v(4mm)
  #block(fill: bg-soft, radius: 6pt, inset: 10pt, width: 100%)[
    #text(size: 14pt, fill: sub-ink)[
      #text(weight: "bold", fill: ink)[2038年問題]：コンピュータは時刻を「1970年1月1日からの秒数」で数えることが多い。
      これを符号付き32ビット整数で持つと，最大値 $2^31 - 1 = 2147483647$ 秒は
      #text(weight: "bold", fill: ink)[2038年1月19日 12:14:07（日本時間）]。その1秒後にあふれて1901年に戻ってしまう。
    ]
  ]
]

// ============================================================
// 7. ランキングと今日の数
// ============================================================
#slide(title: [式がいちばん多い数は？], composer: (1.1fr, 1fr))[
  #set text(size: 19pt)
  #table(
    columns: (auto, auto, auto),
    align: (right, right, left),
    stroke: (x, y) => if y == 0 { (bottom: 1pt + sub-ink) } else { (bottom: 0.4pt + rule-col) },
    inset: (x: 8pt, y: 5pt),
    [*値*], [*式*], [*例*],
    [945], [116], text(size: 15pt, ex[1×(2+3)×(45+6×(7+8+9))]),
    [864], [109], text(size: 15pt, ex[1×2×3×(45+6×(7+8)+9)]),
    [163], [105], text(size: 15pt, ex[1×(2+3+4+5×(6+7)+89)]),
    [164], [100], text(size: 15pt, ex[1+2+3+4+5×(6+7)+89]),
    [729], [96],  text(size: 15pt, ex[1+2×(3×4+5×67+8+9)]),
  )
][
  #block(fill: bg-soft, radius: 6pt, inset: 14pt, width: 100%)[
    #text(weight: "bold", fill: ink, size: 19pt)[今日（10月25日）の 1025 は？]
    #v(4mm)
    #text(size: 18pt)[#ex[1025] を作る式は #text(weight: "bold", fill: jl-blue)[41 通り]]
    #v(3mm)
    #text(size: 16pt)[
      #ex[(12+34)×5+6+789] \
      #ex[(1+23)×4×5+67×8+9] \
      #ex[1+2+(3+4)×(5+6+(7+8)×9)] \
      #text(fill: sub-ink)[など]
    ]
  ]
  #v(4mm)
  #text(size: 16pt, fill: sub-ink)[ちなみに 100 は 47 通り，2027 は 14 通り]
]

// ============================================================
// 8. まとめ
// ============================================================
#slide(title: [まとめ])[
  #set list(spacing: 7mm)
  #text(size: 20pt)[
  - 1〜9 で作れる数は #text(weight: "bold")[43,350 種類]，式は #text(weight: "bold")[190,399 通り]
  - 2026 を作る式は #text(weight: "bold", fill: jl-blue)[14 通り]
  - 44 以上で作れないのは #ex[47, 51, 52, 53, 58]，そして #hl[2038]
  - make 20XX puzzle は #text(weight: "bold")[2037年まで]続けられる！
  ]
  #v(10mm)
  #grid(columns: (1fr, auto), column-gutter: 10mm, align: horizon)[
    #block(fill: bg-soft, radius: 6pt, inset: 14pt, width: 100%)[
      #text(size: 17pt)[
        素敵な問題を出題してくださった #text(weight: "bold")[SEIR62 さん（\@seir62）]に感謝します。
      ]
    ]
    #v(6mm)
    #text(size: 18pt, weight: "bold", fill: ink)[スライド・Julia ノートブックを公開しています]
    #v(2mm)
    #text(size: 16pt, fill: jl-blue)[github.com/shimizudan/20261025sundaymath]
  ][
    #image("images/github_qr.png", width: 38mm)
  ]
]

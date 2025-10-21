#let xbar = $overline(x)$

#let header(title, name) = {
  align(center, text(
    size: 17pt,
    weight: "bold",
    title,
  ))

  align(center, text(name))
}

#let ans(block) = {
  rect(stroke: black, inset: 0.75em)[#block]
}

// #grid(fill: rgb("e4e5ea"), columns: (1fr,) * columns, inset: 1em, align: center, [
// // #grid(gutter: 2pt, align: center, [
// $overline(x)_"men" = 1$
// ], [
// $s_"men"           = 1$
// ], [
//   hi
// ])

// #let given(columns: 1, ..cells) = {
//   text("Given:", weight: "bold")
//   grid(fill: rgb("e4e5ea"), columns: (1fr,) * columns, inset: 0.75em, align: center, ..cells)
// }

/*
#given(columns: 2, (x_m: (10, [$$]))
*/

// #let given-in(columns: 1, bindings, block) = {
//   text("Given:", weight: "bold")
//
//   let cells = ()
//   for (_, binding) in bindings {
//     cells.push([$binding.at(#1) = #(binding.at(0))$])
//   }
//   grid(fill: rgb("e4e5ea"), columns: (1fr,) * columns, inset: 0.75em, align: center, ..cells)
//
//   let bindings = bindings
//     .pairs()
//     .map(((key, value)) => (key, value.at(0)))
//     .to-dict()
//   block(bindings)
// }

#let given(numbering: "(1)", ..blocks) = {
  set math.equation(numbering: numbering, supplement: "Given")
  counter(math.equation).update(0)

  block(breakable: false)[
    *Given: *
    #for b in blocks.pos() {
     [#b]
    }
  ]
}

#let lap = $cal(L)$

#let qed = [#v(0.2em)#h(1fr)$square.big$]

#let proof(content) = {
  block(breakable: false)[
    #underline[Proof:]

    #content

    #qed
  ]
}

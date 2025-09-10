local lines = {
  "[info] compiling 1 Scala source to /home/composer3/Documents/programming/scala/connect4/connect4-server/target/scala-3.7.2/classes ...",
  "[error] -- [E040] Syntax Error: /home/composer3/Documents/programming/scala/connect4/connect4-server/src/main/scala/Main.scala:5:0 ",
  "[error] 5 |def msg = \"I was compiled by Scala 3. :)\"",
  "[error]   |^^^",
  "[error]   |')' expected, but 'def' found",
  "[error] -- [E006] Not Found Error: /home/composer3/Documents/programming/scala/connect4/connect4-server/src/main/scala/Main.scala:3:10 ",
  "[error] 3 |  println(msg",
  "[error]   |          ^^^",
  "[error]   |          Not found: msg",
  "[error]   |",
  "[error]   | longer explanation available when compiling with `-explain`",
  "[error] two errors found",
  "[error] Total time: 0 s, completed Aug 14, 2025, 8:26:07 PM",
}

-- vim.cmd.compiler("sbt")

-- local efm = "%E%f:%l:%m,%C%m,%Z%.%#"
-- local efm = "%E[error] line %l,%Z%m"
-- vim.opt.efm = {
--   "%E[error] %#-%# [E%\\d%#] %m %f:%l:%c ",
--   "%C[error] %#%l %#|%.%#",
--   "%C[error] %#| %#^%#",
--   "%Z[error] %#| %#%m",
--   "%-G[error]%.%#",
--   "%-G[info]%.%#",
-- }

vim.fn.setqflist({}, "r", { lines = lines, title = "test" })

if exists("current_compiler")
	finish
endif
let current_compiler = "v"

let s:cpo_save = &cpo
set cpo&vim

if exists(":CompilerSet") != 2
	command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=v\ $*

CompilerSet errorformat=
      \%E%f:%l:%c:\ error:\ %m,
      \%W%f:%l:%c:\ warning:\ %m,
      \%C\ %.%#,
      \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

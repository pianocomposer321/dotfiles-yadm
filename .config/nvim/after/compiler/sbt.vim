if exists(':CompilerSet') != 2
	command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=sbt\ $*

" CompilerSet errorformat=
" 			\%f:%l:%c:\ %t%*[^:]:\ %m,
" 			\%f:%l:%c:\ %*\\d:%*\\d\ %t%*[^:]:\ %m,
" 			\%-G%f:%l\ %s,
" 			\%-G%*[\ ]^,
" 			\%-G%*[\ ]^%*[~],
" 			\%-G%*[\ ]...

" CompilerSet errorformat=\
"   %A%f:%l:\ %t%*[^:]:\ %m,\
"   %A%f:%l:\ %t%*[^:]:\ %m,%Z\ %p^,\
"   %A%f:%l:%c:\ %t%*[^:]:\ %m,\
"   %A%f:%l:%c:\ %t%*[^:]:\ %m,%Z\ %p^,\
"   %A%f:%l:\ %m,\
"   %A%f:%l:\ %m,%Z\ %p^,\
"   %E%f:%l:\ %m,\
"   %W%f:%l:\ %m,\
"   %C%.%#

CompilerSet errorformat=
			\%E[error]\ %#-%#\ [E%\\d%#]\ %m\ %f:%l:%c\ ,
			\%C[error]\ %#%l\ %#\|%.%#,
			\%C[error]\ %#\|\ %#^%#,
			\%Z[error]\ %#\|\ %#%m,
			\%-G[error]%.%#,
			\%-G[info]%.%#,
			\%-G%.%#

" Vim compiler file
" Compiler:         Rust Compiler
" Maintainer:       Chris Morgan <me@chrismorgan.info>
" Latest Revision:  2013 Jul 12
" For bugs, patches and license go to https://github.com/rust-lang/rust.vim

if exists(':CompilerSet') != 2
	command -nargs=* CompilerSet setlocal <args>
endif

" Old errorformat (before nightly 2016/08/10)
CompilerSet errorformat=
			\%f:%l:%c:\ %t%*[^:]:\ %m,
			\%f:%l:%c:\ %*\\d:%*\\d\ %t%*[^:]:\ %m,
			\%-G%f:%l\ %s,
			\%-G%*[\ ]^,
			\%-G%*[\ ]^%*[~],
			\%-G%*[\ ]...

" New errorformat (after nightly 2016/08/10)
CompilerSet errorformat+=
			\%-G,
			\%-G%.%#\ generated\ 1\ warning,
			\%-Gerror:\ aborting\ %.%#,
			\%-Gerror:\ Could\ not\ compile\ %.%#,
			\%Eerror:\ %m,
			\%Eerror[E%n]:\ %m,
			\%Wwarning:\ %m,
			\%Inote:\ %m,
			\%C\ %#-->\ %f:%l:%c,
			\%-G%.%#

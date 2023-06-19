if get(b:, 'current_compiler', '') ==# ''
  if strlen(findfile('package.json', '.;')) > 0
    let &makeprg="npm $*"
    " compiler! cargo
  else
    let &makeprg="node $*"
    " compiler rustc
  endif
endif

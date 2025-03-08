setlocal commentstring=//%s

if get(b:, 'current_compiler', '') ==# ''
  compiler swift
endif

if get(b:, 'current_compiler', '') ==# ''
    if strlen(findfile('Cargo.toml', '.;')) > 0
        compiler! cargo
    else
        compiler rustc
    endif
endif

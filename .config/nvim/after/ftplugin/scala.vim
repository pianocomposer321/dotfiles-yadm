if get(b:, 'current_compiler', '') ==# ''
    if strlen(findfile('build.sbt', '.;')) > 0
        compiler! sbt
    else
        " compiler scala
        set makeprg=scala\ $*
    endif
endif

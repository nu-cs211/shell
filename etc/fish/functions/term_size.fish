function _term_size_default
    set requested $argv[1]
    set default   $argv[2]

    switch $requested
    case '='
        echo
    case '+'
        echo 0
    case ''
        echo $default
    case '*'
        echo $requested
    end
end

function _raw_term_size
    printf '\e[8;%s;%st' $argv[2] $argv[1]
end

function term_size --description 'Adjust the size of the terminal'
    switch $argv[1]
    case left
        _raw_term_size 80 31
    case right
        _raw_term_size 56 36
    case '*'
        _raw_term_size (_term_size_default $argv[1] 80) \
                       (_term_size_default $argv[2]  0)
    end
end

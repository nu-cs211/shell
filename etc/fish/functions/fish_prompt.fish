# From /usr/local/Cellar/fish/3.1.0_1/share/fish/functions/__fish_print_pipestatus.fish
function __fish_print_pipestatus_VENDORED --description 'Print pipestatus for prompt'
    set -l left_brace $argv[1]
    set -l right_brace $argv[2]
    set -l separator $argv[3]
    set -l brace_sep_color $argv[4]
    set -l status_color $argv[5]
    set -e argv[1 2 3 4 5]

    # only output status codes if some process in the pipe failed
    # SIGPIPE (141 = 128 + 13) is usually not a failure, see #6375.
    if string match -qvr '^(0|141)$' $argv
        set -l sep (set_color normal){$brace_sep_color}{$separator}(set_color normal){$status_color}
        set -l last_pipestatus_string (string join "$sep" (__fish_pipestatus_with_signal $argv))
        printf "%s%s%s%s%s%s%s%s%s%s" (set_color normal )$brace_sep_color $left_brace \
            (set_color normal) $status_color $last_pipestatus_string (set_color normal) \
            $brace_sep_color $right_brace (set_color normal)
    end
end

function fish_prompt --description 'Write out the prompt'
    set -l last_pipestatus $pipestatus
    set -l normal (set_color normal)

    set -l suffix '%'

    set -l color_cwd cyan
    if set -q fish_color_cwd && [ $fish_color_cwd != normal ]
        set color_cwd $fish_color_cwd
    end

    set -l color_host cyan
    if set -q fish_color_host && [ $fish_color_host != normal ]
        set color_host $fish_color_host
    end

    set -l color_user cyan
    if set -q fish_color_user && [ $fish_color_user != normal ]
        set color_user $fish_color_user
    end

    # Change the suffix and colors when we're root
    if contains -- $USER root toor
        set suffix '#'

        if set -q fish_color_cwd_root
            set color_cwd $fish_color_cwd_root
        else
            set color_cwd red
        end
        if set -q fish_color_user_root
            set color_user $fish_color_user_root
        else
            set color_user red
        end
    end

    # Change colors in non-insert mode:
    switch $fish_key_bindings:$fish_bind_mode
        case fish_vi_key_bindings:default fish_hybrid_key_bindings:default
            set color_cwd  normal
            set color_host normal
            set color_user normal
        case '*':replace_one
            set color_cwd  magenta
            set color_host magenta
            set color_user magenta
        case '*':visual
            set color_cwd  green
            set color_host green
            set color_user green
        case '*':insert '*'
    end

    # Write pipestatus
    set -l prompt_status (
        __fish_print_pipestatus_VENDORED " [" "]" "|" \
            (set_color $fish_color_status) \
            (set_color --bold $fish_color_status) \
            $last_pipestatus)

    echo -n -s \
        (set_color $color_user) "$USER" \
        $normal @ \
        (set_color $color_host) (prompt_hostname) \
        $normal ':' \
        (set_color $color_cwd) (prompt_pwd) \
        $normal $prompt_status \
        $suffix ' '
end

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
        __fish_print_pipestatus " [" "]" "|" \
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

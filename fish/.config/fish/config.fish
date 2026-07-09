if status is-interactive
    set fish_greeting
    set fish_cursor_default block
    set -gx TERM xterm-256color

    if [ -s "/etc/grc.fish" ]; source /etc/grc.fish; end
    ./PokeTerm/pokeTerm

    function fish_user_key_bindings
        fish_vi_key_bindings
    end

    function fish_prompt
        echo -n  "┏ "

        set_color normal

        prompt_mode

        set_color --bold cyan 
        echo  "" (prompt_pwd)
        set_color normal
        echo  "┗ "
    end

    function prompt_mode
        switch $fish_bind_mode
            case default
                set_color --bold magenta
                echo -n '[N]'
            case insert
                set_color --bold green
                echo -n '[I]'
            case replace_one
                set_color --bold green
                echo -n '[R]'
            case visual
                set_color --bold brmagenta
                echo -n '[V]'
            case '*'
                set_color --bold red
                echo '[?]'
        end
    end

    function fish_mode_prompt
        echo ""
    end

    function fish_right_prompt
        set last_status $status
        set_color --bold magenta 
        if test $last_status -ne 0
            echo [$last_status]" "
        end

        set_color --bold blue 
        echo (fish_git_prompt) ""

        set_color normal
    end


    alias ls="lsd --group-directories-first"
    alias bat="batcat"
    alias wn="bash ~/Wallpapers/imageSetter.sh"
    alias botany="python3 ~/botany/botany.py"
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

zoxide init fish --cmd cd | source

function 211
    if set -q PUB211
        echo 'You’re in the 211 development environment already!'
        return 211
    else
        exec /home/cs211/pub/bin/env211
    end
end

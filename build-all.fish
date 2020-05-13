#!/usr/bin/env fish
set PYTHON python3.8

function build -a file variant template
    $PYTHON utils/evaluate_template.py selenized_$variant utils/templates/$template.template \
        | awk '/Result written to/ { print $4 }' \
        | xargs -IRESULT mv -v RESULT $file
end
function build_set -a file template
    for v in black dark white light
        build (string replace VARIANT $v $file) $v $template
    end
end

build_set terminals/blinksh/selenized-VARIANT.js blinksh
build_set terminals/iterm/selenized-VARIANT.itermcolors iTerm.itermcolors

# terminals/blinksh/selenized-black.js: utils/palettes/selenized_dark.py utils/templates/blinksh.template
# 	file=$$($(PYTHON) utils/evaluate_template.py selenized_dark utils/templates/blinksh.template | awk '/Result written to/{print $$4}'); \
# 		 mv $$file [terminals/blinksh/selenized-black.js],[dark],[blinksh.template]



# terminals/iterm/selenized-black.itermcolors: utils/palettes/selenized_dark.py utils/templates/iTerm.itermcolors.template
# 	file=$$($(PYTHON) utils/evaluate_template.py selenized_dark utils/templates/iTerm.itermcolors.template | awk '/Result written to/{print $$4}'); \
# 		 mv $$file [terminals/iterm/selenized-black.itermcolors],[dark],[iTerm.itermcolors.template]



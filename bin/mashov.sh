#!/bin/bash

if [[ -f ~/.pyenv/bin/pyenv ]]; then
	export PATH="${home_dir}/.pyenv/bin:$PATH"
	eval "$(~/.pyenv/bin/pyenv init -)"
fi

# python ~/bin/mashov.py mashov --school 442046 --user 031406036 --pw 1z2x3c4V --email nir.tzachar@gmail.com &
# sleep 5

# python ~/bin/mashov.py mashov --school 380022 --user 29635646 --pw Itai22 --email ziv.ayalon@gmail.com &
# sleep 5
# python ~/bin/mashov.py mashov --school 770073 --user L329245153 --pw Cutedog12 --email ziv.ayalon@gmail.com &
# sleep 5
# python ~/bin/mashov.py mashov --school 384248 --user 029635646 --pw Nadav711 --email ziv.ayalon@gmail.com &
# sleep 5


python ~/bin/mashov.py ishurim --target gali --email nir.tzachar@gmail.com &
sleep 5

python ~/bin/mashov.py ishurim --target ron --email nir.tzachar@gmail.com &
sleep 5

wait

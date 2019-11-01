#!/bin/bash

pushd ~/dev/tools/nerd-fonts

for font in src/unpatched-fonts/InputMono/InputMono-*; do 
  fontforge \
    -script font-patcher \
    -out ~/Library/Fonts/InputMono \
    --careful \
    --no-progressbars \
    --fontawesome \
    --fontawesomeextension \
    --fontlinux \
    --fontlogos \
    --octicons \
    --powersymbols \
    --pomicons \
    --powerline \
    --powerlineextra \
    --weather \
    $font
done

popd

#!/bin/bash

pushd ~/dev/tools/nerd-fonts

for font in src/unpatched-fonts/InputMono/InputMono-*; do 
  fontforge \
    -script font-patcher \
    -out ~/Library/Fonts/InputMono \
    --careful \
    --progressbars \
    --fontawesome \
    --fontawesomeextension \
    --fontlinux \
    --fontlogos \
    --material \
    --octicons \
    --powersymbols \
    --pomicons \
    --powerline \
    --powerlineextra \
    --weather \
    $font
done

popd

#!/bin/bash

INDIR="free-icons/svgs"
DESTDIR="free-icons/svelte-svgs"

# Define an array
types=("brands" "thin" "light" "regular" "solid" "sharp-light" "sharp-regular" "sharp-solid")

# #clone svelte-free-icons https://github.com/free-icons/free-icons
git clone https://github.com/free-icons/free-icons 

# #create split svelte components dirs
for type in "${types[@]}"; do
    mkdir -p ${DESTDIR}/${type}/svg
done

# #move the svgs into proper split svelte dirs
for type in "${types[@]}"; do
    mv -v ${INDIR}/${type}-* ${DESTDIR}/${type}/svg
done

# #perform the conversion from svg to svelte components icons
for type in "${types[@]}"; do
    ./scripts/svg2svelte.sh ${DESTDIR}/${type}
done

# #populate icons into sveelte projects
for type in "${types[@]}"; do
   mv -v ${DESTDIR}/${type}/svelte/* svelte-free-icons-${type}/src/lib
done

#build the icon packages
for type in "${types[@]}"; do
    cd svelte-free-icons-${type}
    npm i --loglevel verbose
    npm run build
    cd ..
done


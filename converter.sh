#!/bin/bash
target=$( find -name *.$1 | wc -l )
completed=0

function convert_videos {
    for file in *; do
        filename=${file%%.*}
        extension=${file##*.}
        if [ $extension = "$1" ]; then
            original=$file
            converted="${filename}.$2"
            ffmpeg -i "$original" "$converted" 2>> /dev/null 
            mv "$converted" ../Converted/
            let completed++
            echo $((100*$completed/$target))% complete
        fi
    done;
}

echo "Total files to convert: $target"
mkdir Converted
for d in */; do
    cd "$d"
    echo "converting files in $d"
    convert_videos "$@"
    cd ..
    echo "Files converted: $( find -name *.$2 | wc -l )"
done;

echo "Done. Total files converted: $( find -name *.$2 | wc -l )"

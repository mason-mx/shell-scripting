#!/bin/bash
function lookthrough_dir(){
    for img in `find $1 -iname '*.png' -o -iname '*.jpg' -o -name "thumbs" -prune -type f`
    do
        echo "$img"
        filename="$img"
        convert "$img" -resize "100x" "$1/thumbs/$filename"
        echo "<a href=\"$img\" ><img src=\"thumbs/$filename\" title=\"$filename\" /></a>" >> $1"/"index.html
    done
}

echo "Creating album.."
mkdir -p $1"/"thumbs
cat <<EOF1 > $1"/"index.html
<html>
<head>
<style>
body
{
width:auto;
margin:auto;
border: 1px dashed grey;
padding:10px;
}
img
{
margin:5px;
border: 1px solid black;
}
</style>
</head>
<body>
<center><h1> #Album title </h1></center>
<p>
EOF1
lookthrough_dir $1
cat <<EOF2 >> $1"/"index.html
</p>
</body>
</html>
EOF2
echo Album generated to $1"/"index.html

#!/bin/bash
work_dir=$1

function lookthrough_dir(){
    cd $1
    echo "<p class=\"style2\">---$1---</p>" >> $work_dir"/"index.html
    for img in *.jpeg *.png;
    do
        if [ -e $img ]
        then
            echo $img
            convert "$img" -resize "100x" "$work_dir/thumbs/$img"
            echo "<a href=\"$img\" ><img src=\"thumbs/$img\" title=\"$img\" /></a>" >> $work_dir"/"index.html
        fi
    done    
    for dir in `ls $1`
    do
        if [[ -d $1"/"$dir ]] && [[ $1"/"$dir != $work_dir"/"thumbs ]]
        then
            echo $1"/"$dir
            lookthrough_dir $1"/"$dir 
        fi
    done
    cd ..
}

echo "Creating album.."
mkdir -p $1"/"thumbs
cat <<EOF1 > $1"/"index.html
<html>
<head>
<style type="text/css">
<!--
body,td,th {
	color: #000000;
}
body {
	background-color: #ECE9D8;
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
.style1 {
	font-size: 20px;
	color: #6666FF;
}
.style2 {
	font-size: 18px;
	color: #FF33CC;
}
.style3 {font-size: 16px}
.style4 {
	font-size: 16px;
	color: #ECE9D8;
}
a:link {
	text-decoration: none;
}
a:visited {
	text-decoration: none;
}
a:hover {
	text-decoration: underline;
}
a:active {
	text-decoration: none;
}
}
-->
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

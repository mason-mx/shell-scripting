#!/bin/bash
function lookthrough_dir(){
    alpha="0"
    #for htm in `ls *.htm | sort -k 1,1 -t .`
    for htm in $(ls *.htm | sort -k 1,1 -t .)
    #for htm in `find $1 -maxdepth 1 -name 'index.html' -prune -o -type f -name '*.htm' -print | sort -k 1,1 -t h`
    do
        echo "$htm"		
        filename=$(basename "$htm" .htm)
	cur_alpha=`echo ${filename:0:1}`
	if [ $cur_alpha != $alpha ]; then
	    alpha=$cur_alpha
	    subtitle=`echo "${alpha^^}"`
	    echo "<h2> $subtitle </h2>" >> $1"/"index.html
	fi
        echo "<a href=\"$htm\">$filename</a><br>" >> $1"/"index.html
    done
}

echo "Creating index html ..."
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
</style>
</head>
<body>
<center><h1> Longman 3000 </h1></center>
<p>
EOF1
lookthrough_dir $1
cat <<EOF2 >> $1"/"index.html
</p>
</body>
</html>
EOF2
echo Album generated to $1"/"index.html

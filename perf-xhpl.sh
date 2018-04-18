proc_name="xhpl"

nohup ./xhpl > xhpl.log 2>&1 &

name_suffixx="/"

proc_id=$(ps x | grep $proc_name | grep -v grep | awk '{print $1}')

echo ${proc_name}" pid:"
echo ${proc_id[@]}
echo "m"
nohup sudo -S perf record -e cpu-clock -g -p ${proc_id[@]} > perf.log 2>&1 & 

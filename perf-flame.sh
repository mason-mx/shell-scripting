sudo rm -f perf.unfold perf.folded perf.svg
sleep 1

sudo perf script -i perf.data &> perf.unfold
echo "perf.unfold"
sudo /home/ubuntu/FlameGraph/stackcollapse-perf.pl perf.unfold &> perf.folded
echo "perf.folded"
sudo /home/ubuntu/FlameGraph/flamegraph.pl perf.folded >perf.svg

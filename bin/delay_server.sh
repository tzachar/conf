tc qdisc add dev eth0 root handle 1: prio
tc qdisc add dev eth0 parent 1:3 handle 30: netem delay 100ms
tc filter add dev eth0 protocol ip parent 1:0 prio 3 u32 match ip dst 172.30.35.50/32 flowid 1:3


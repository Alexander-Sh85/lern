for i in $(seq 1 100); do
    redis-cli -h redis SET test$i "value_$i"
done
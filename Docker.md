```
# 10. Show all container names, status, container port, host port and docker network info for each docker container
(
echo -e "NAMES\tSTATUS\tHOST PORT\tCONTAINER PORT\tNETWORK ID\tNETWORK NAME\tDRIVER"
docker ps --format "{{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Networks}}" | while IFS=$'\t' read -r name status ports networks; do
    echo "$ports" | tr ',' '\n' | sed 's/.*:\([0-9]*\)->\([0-9]*\).*/\1\t\2/' | sort -u | while IFS=$'\t' read -r host_port container_port; do
        if [[ -n "$host_port" && -n "$container_port" ]]; then
            for network in $(echo $networks | tr ',' ' '); do
                network_info=$(docker network inspect -f '{{.Id}} {{.Name}} {{.Driver}}' "$network" 2>/dev/null)
                if [[ -n "$network_info" ]]; then
                    net_id=$(echo "$network_info" | awk '{print $1}')
                    net_name=$(echo "$network_info" | awk '{print $2}')
                    driver=$(echo "$network_info" | awk '{print $3}')
                    printf "%s\t%s\t%s\t%s\t%s\t%s\t%s\n" "$name" "$status" "$host_port" "$container_port" "$net_id" "$net_name" "$driver"
                fi
            done
        fi
    done
done
) | column -t -s $'\t'
```

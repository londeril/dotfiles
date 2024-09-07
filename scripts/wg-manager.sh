#!/bin/bash

DB_FILE="/etc/wireguard/peers.db"
CONFIG_FILE="/etc/wireguard/wg0.conf"
PEERS_DIR="/etc/wireguard/clients/"
IP_BASE="10.0.100"
NEXT_IP=2
ENDPOINT="85.195.220.90:51830"
SERVER_PUBLIC_KEY="TjHot7rB7mYg/b8nMjnKoDNXRFsYgd1ylsTQaxR+gEs="
ALLOWED_IPS="10.0.100.0/24,192.168.251.0/24"

# Function to get the next available IP
get_next_ip() {
    while grep -q "${IP_BASE}.${NEXT_IP}" "$DB_FILE"; do
        NEXT_IP=$((NEXT_IP + 1))
    done
    echo "${IP_BASE}.${NEXT_IP}"
}

# Function to add a new peer
add_peer() {
    local name="$1"
    local ip=$(get_next_ip)
    local peer_dir=$PEERS_DIR$name
    local peer_file=${peer_dir}/office.conf

    # Generate keys
    private_key=$(wg genkey)
    public_key=$(echo "$private_key" | wg pubkey)
    preshared_key=$(wg genkey)
    
    # Add to database
    echo "$name,$ip,$public_key" >> "$DB_FILE"
    
    # Add to WireGuard config
    echo "" >> "$CONFIG_FILE"
    echo "# $name" >> "$CONFIG_FILE"
    echo "[Peer]" >> "$CONFIG_FILE"
    echo "PublicKey = $public_key" >> "$CONFIG_FILE"
    echo "PresharedKey = $preshared_key" >> "$CONFIG_FILE"
    echo "AllowedIPs = $ip/32" >> "$CONFIG_FILE"
    
    # generate peer file
    mkdir $peer_dir
    echo "# $name" >> "$peer_file"
    echo "[Interface]" >> "$peer_file"
    echo "Address = $ip/24" >> "$peer_file"
    echo "PrivateKey = $private_key" >> "$peer_file"
    echo "" >> "$peer_file"
    echo "[Peer]" >> "$peer_file"
    echo "PublicKey = $SERVER_PUBLIC_KEY" >> "$peer_file"
    echo "PresharedKey = $preshared_key" >> "$peer_file"
    echo "AllowedIPs = $ALLOWED_IPS" >> "$peer_file"
    echo "Endpoint = $ENDPOINT" >> "$peer_file"
    

    echo "Peer $name added with IP $ip"
    echo "Peer file generated at $peer_file"
}

# Function to remove a peer
remove_peer() {
    local name="$1"
    sed -i "/^$name,/d" "$DB_FILE"
    sed -i "/# $name/,/^\$/d" "$CONFIG_FILE"
    rm -r $PEERS_DIR$name
    echo "Peer $name removed"
    echo "Peer $name config dir removed"
}

# Function to list all peers
list_peers() {
    cat "$DB_FILE"
}

# input selector
case "$1" in
    add)
        add_peer "$2"
        ;;
    remove)
        remove_peer "$2"
        ;;
    list)
        list_peers
        ;;
    *)
        echo "Usage: $0 {add|remove|list} [peer_name]"
        exit 1
        ;;
esac

# Apply changes to WireGuard
wg syncconf wg0 <(wg-quick strip wg0)

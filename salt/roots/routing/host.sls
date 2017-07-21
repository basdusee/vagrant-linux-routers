{%- set interface = "enp0s8" %}
net.ipv4.ip_forward:
  sysctl.present:
    - value: 0

defaultroute:
  network.routes:
    - name: {{ interface }}
    - routes:
      - name: default
        ipaddr: 0.0.0.0
        netmask: 0.0.0.0
        gateway: 192.168.101.254


base:
  '*':
    - basis
    - routing
  'edge*':
    - firewall.edge
    - vpn
    - failover
  'not edge*':
    - firewall.intern
  'darkweb*':
    - web

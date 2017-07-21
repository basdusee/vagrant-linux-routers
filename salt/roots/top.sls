base:
  '*':
    - basis
    - routing.router
  'edge*':
    - firewall.edge
    - vpn
    - failover
  'not edge*':
    - firewall.intern
  'darkweb*':
    - web

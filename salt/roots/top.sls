base:
  '*':
    - basis
  'edge*':
    - firewall.edge
    - vpn
    - failover
  'not edge*':
    - firewall.intern
  'darkweb*':
    - web
    - routing.host
  'not darkweb*':
    - routing.router

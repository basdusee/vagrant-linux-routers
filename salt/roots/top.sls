base:
  '*':
    - basis
    - routing
  'edge*':
    - vpn
    - firewall.edge
  'not edge*':
    - firewall.intern
  'darkweb*':
    - web

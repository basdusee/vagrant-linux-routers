firewallpakkettenlijst:
  pkg.installed:
    - pkgs:
      - iptables-persistent
  service.running:
    - name: netfilter-persistent
    - enable: True
    - watch:
      - file: /etc/iptables/rules.v4

/etc/iptables/rules.v4:
  file.managed:
    - source: salt://firewall/rules.v4.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 600

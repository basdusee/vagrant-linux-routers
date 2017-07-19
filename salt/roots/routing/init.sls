net.ipv4.ip_forward:
  sysctl.present:
    - value: 1

/etc/bird/bird.conf:
  file.managed:
    - source: salt://routing/bird.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

routing_pakketten:
  pkg.installed:
    - pkgs:
      - bird
      - haproxy
      - hatop

bird_service:
  service.running:
    - name: bird
    - enable: True
    - watch:
      - file: /etc/bird/bird.conf


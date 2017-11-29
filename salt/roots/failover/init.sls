# Essential! services on virtual ip's will not start or work
# if this sysctl value is 0
net.ipv4.ip_nonlocal_bind:
  sysctl.present:
    - value: 1

failover_packages:
  pkg.installed:
    - pkgs:
      - libipset3 # critical for keepalived, Y U no dependancy?!?
      - keepalived
      - haproxy
      - hatop

/etc/keepalived/keepalived.conf:
  file.managed:
    - source: salt://failover/keepalived.conf.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

keepalived_service:
  service.running:
    - name: keepalived
    - enable: True
    - watch:
      - file: /etc/keepalived/keepalived.conf

/etc/haproxy/haproxy.cfg:
  file.managed:
    - source: salt://failover/haproxy.cfg.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

haproxy_service:
  service.running:
    - name: haproxy
    - enable: True
    - watch:
      - file: /etc/haproxy/haproxy.cfg
    - require:
      - service: keepalived_service


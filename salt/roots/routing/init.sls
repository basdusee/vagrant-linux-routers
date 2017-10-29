{%- set hostname = grains['host'] -%}

# Webservers do not need to route
# but routers do..
net.ipv4.ip_forward:
  sysctl.present:
{%- if 'web' in hostname %}
    - value: 0
{%- else %}
    - value: 1
{%- endif %}

# Base config for the Bird routing daemon.
# We use a separate config for webhosts
# This makes the bird jinja less complex
/etc/bird/bird.conf:
  file.managed:
{%- if 'web' in hostname %}
    - source: salt://routing/bird.host.jinja
{%- else %}
    - source: salt://routing/bird.conf.jinja
{%- endif %}
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - makedirs: True

# Bird should be installed if we want to use it.
routing_pakketten:
  pkg.installed:
    - pkgs:
      - bird

# The Debian package automatically starts the ipv6 daemon
# Let's not do that, this is not an ipv6 lab
bird6_service:
  service.dead:
    - name: bird6
    - enable: False

# We do want to start the ipv4 daemon, 
# but only if the config file exists
bird_service:
  service.running:
    - name: bird
    - enable: True
    - watch:
      - file: /etc/bird/bird.conf

# This is the end of the file, if this is an edge router.
# Else there will be some magic to stop dhclient from setting
# a default gateway on the host, and removing the already set
# gateway. OSPF will give us the default gateway after this.

{%- if not 'edge' in grains['host'] %}
/etc/dhcp/dhclient.conf:
  file.managed:
    - source: salt://routing/dhcp_nodefault.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644

del_default_route:
  cmd.run:
    - name: 'ip route del default scope link && sleep 10 || echo "no non-OSPF default route present"'
    - require:
      - service: bird_service
{% endif -%}

#--------------------------------------
# Installing nginx proxy with a gunicorn
# back-end.
#--------------------------------------

# nginx itself should be installed of course
# we go for the lite version, no need for
# the full package
nginx-light:
  pkg.installed: []

# configuring salt-api as a default site in nginx
/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://web/defaultnginx.jinja
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx-light

# Enabling gunicorn-hypnotoad as the default website
# which is linked already probably
/etc/nginx/sites-enabled/default:
  file.symlink:
    - target: /etc/nginx/sites-available/default
    - require:
      - file: /etc/nginx/sites-available/default

# Let's start nginx, it should be ready by now
# There is no site behind it however, because
# gunicorn isn't running yet. But this is not a
# problem. So let's start.
nginx-service-running:
  service.running:
    - name: nginx
    - enable: True
    - watch:
      - pkg: nginx-light
      - file: /etc/nginx/sites-available/default

# Gunicorn does not have a standard systemd script
# so we made one and will put it in.
/lib/systemd/system/hypnotoad.service:
  file.managed:
    - source: salt://web/hypnotoad.service
    - user: root
    - password: root
    - mode: 644

# Our site is a flask site, so we need it.
flask:
  pip.installed

# We need to host the site, so gunicorn is needed
gunicorn:
  pip.installed

# this is the main site repo. All the webfiles are in here
/srv/hypnotoad:
  file.recurse:
    - source: salt://web/files
    - user: www-data
    - group: www-data
    - clean: True

# Let's use systemd to start gunicorn
# and start serving the website!
webzijde:
  service.running:
    - name: hypnotoad
    - require:
      - file: /lib/systemd/system/hypnotoad.service
      - pip: gunicorn

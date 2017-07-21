
/etc/init/hypnotoad.conf:
  file.managed:
    - source: salt://web/hypnotoad.conf
    - user: root
    - password: root
    - mode: 644

flask:
  pip.installed

gunicorn:
  pip.installed

/srv/hypnotoad:
  file.recurse:
    - source: salt://web/files
    - user: www-data
    - group: www-data
    - clean: True

#webside:
#  service.running:
#    - name: hypnotoad
#    - require:
#      - file: /etc/init/hypnotoad.conf
#      - pip: gunicorn

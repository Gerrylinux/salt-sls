supervisord-install:
  pkg.installed:
    - pkgs:
      - supervisor

/usr/local/supervisord/conf.d:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/data/wwwlogs/supervisord:
  file.directory:
    - user: root
    - group: root
    - mode: 755
    - makedirs: True

/usr/local/supervisord/supervisord.ini:
  file.managed:
    - source: salt://files/supervisord.ini
    - user: root
    - group: root
    - mode: 644
    - unless: test -e /usr/local/supervisord/supervisord.ini

/usr/local/supervisord/conf.d/test.ini:
  file.managed:
    - source: salt://files/test.ini
    - user: root
    - group: root
    - mode: 644
    - unless: test -e /usr/local/supervisord/conf.d/test.ini

/usr/lib/systemd/system/supervisord.service:
  file.managed:
    - source: salt://files/supervisord.service
    - user: root
    - group: root
    - mode: 644

supervisord-init:
  cmd.run:
    - name: systemctl daemon-reload && systemctl enable  supervisord.service && systemctl start supervisord.service

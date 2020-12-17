{% from "nginx/map.jinja" import nginx with context -%}
/etc/logrotate.d/nginx:
  file.managed:
    - source: salt://files/nginx-log
    - unless: test ! -d {{ nginx.nginx_basedir }}
    - user: root
    - group: root
    - mode: 644

  cron.present:
    - name: /usr/sbin/logrotate -f  {{ nginx.logrotate_conf }}
    - unless: test ! -d {{ nginx.nginx_basedir }}
    - user: root
    - minute: 00
    - hour: 00
    - require:
      - file: {{ nginx.logrotate_conf }}

{% from "redis/map.jinja" import redis with context -%}
include:
  - redis.install
  - user.redis

{{ redis.redis_conf_file }}:
  file.managed:
    - source: salt://files/redis.conf
    - user: root
    - group: root
    - mode: 644

redis-init:
  file.managed:
    - name: {{ redis.service_file }}
    - source: salt://files/redis
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: chkconfig redis on
    - unless: chkconfig --list | grep redis
    - require:
      - file: redis-init

redis-service:
  service.running:
    - name: redis
    - enable: True
    - reload: True
    - require:
      - cmd: redis-init
    - watch:
      - file: {{ redis.redis_conf_file }}


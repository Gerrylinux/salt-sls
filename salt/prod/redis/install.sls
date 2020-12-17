{% from "redis/map.jinja" import redis with context -%}
redis-source-install:
  file.managed:
    - name: /usr/local/src/{{ redis.redis_version }}.tar.gz
    - source: salt://files/{{ redis.redis_version }}.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src/ && tar xf {{ redis.redis_version }}.tar.gz && cd {{ redis.redis_version }} && mkdir {{ redis.redis_basedir }}/{bin,etc,log} -p && mkdir /data/redis/db -p && make  && cp /usr/local/src/{{ redis.redis_version }}/src/redis-cli {{ redis.redis_bin }} && cp /usr/local/src/{{ redis.redis_version }}/src/redis-server {{ redis.redis_bin }} && cp /usr/local/src/{{ redis.redis_version }}/src/redis-benchmark {{ redis.redis_bin }}
    - unless: test -d {{ redis.redis_basedir }}
    - require:
      - file: redis-source-install

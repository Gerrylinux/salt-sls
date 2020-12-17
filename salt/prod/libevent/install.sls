{% from "libevent/map.jinja" import libevent with context -%}
libevent-source-install:
  file.managed:
    - name: /usr/local/src/{{ libevent.libevent_version }}.tar.gz
    - source: salt://files/{{ libevent.libevent_version }}.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /usr/local/src && tar zxf {{ libevent.libevent_version }}.tar.gz && cd {{ libevent.libevent_version }} &&  ./configure --prefix={{ libevent.libevent_basedir }} && make && make install
    - unless: test -d {{ libevent.libevent_basedir }}
    - require:
      - file: libevent-source-install

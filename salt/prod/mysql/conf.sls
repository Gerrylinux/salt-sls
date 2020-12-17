{% from "mysql/map.jinja" import mysql with context -%}
include:
  - mysql.install

{{ mysql.conf_file }}:
  file.managed:
    - name: {{ mysql.conf_file }}
    - source: salt://files/my.cnf
    - user: root
    - mode: 664

salt://mysql/conf.sh:
  cmd.script:
    - env:
      - BATCH: 'yes'
    - require:
      - cmd: mysql_install
    - unless: test -f /var/run/mysqld/mysqld.pid

{{ mysql.service_file }}:
  file.managed:
    - name: {{ mysql.service_file }}
    - source: salt://files/mysqld
    - mode: 755
  cmd.run:
    - names:
      - systemctl daemon-reload
      - systemctl enable mysqld
  service.running:
    - name: mysqld 
    - reload: True
    - enable: True

salt://mysql/sql.sh:
  cmd.script:
    - require:
      - file: {{ mysql.service_file }}
    - unless: test -f /opt/mysql_root_pass-1

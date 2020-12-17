{% from "nginx/map.jinja" import nginx with context -%}
include:
  - nginx.install

nginx-init:
  file.managed:
    - name: {{ nginx.service_file }}
    - source: salt://files/nginx-init
    - mode: 755
    - user: root
    - group: root
  cmd.run:
    - name: systemctl enable nginx
    - require:
      - file: nginx-init

{{ nginx.conf_file }}:
  file.managed:
    - source: salt://files/nginx.conf
    - user: www
    - group: www
    - mode: 644 

/etc/init.d/lo0:
  file.managed:
    - source: salt://files/lo0.sh
    - user: root
    - group: root
    - mode: 755

nginx-service:
  file.directory:
    - name: {{ nginx.nginx_vhosts }}
    - require:
      - cmd: nginx-source-install
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - cmd: nginx-init
    - watch:
      - file: {{ nginx.conf_file }}

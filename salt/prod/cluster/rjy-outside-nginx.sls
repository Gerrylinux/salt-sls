#include:
#  - nginx.service
nginx-server-conf:
  file.recurse:
    - name: /usr/local/nginx/conf
    - source: salt://cluster/files/RJY-outside-nginx-conf
    - dir_mode: 755
    - file_mode: 644
    - makedirs: True
    - user: root
    - group: root
    - backup: minion
    - include_enpty: True
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - watch:
      - file: nginx-server-conf

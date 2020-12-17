{% from "filebeat/map.jinja" import filebeat with context -%}
include:
  - filebeat.install
filebeat_conf:
  file.managed:
    - name: {{ filebeat.processor }}
    - source: salt://filebeat/files/filebeat.yml
filebeat_restart:
  cmd.run:
    - names:
      - sed -i "s/$(awk '/cname/{print $2}' {{ filebeat.processor }})/$(cat /etc/salt/minion_id | tr '[A-Z]' '[a-z]')/g" {{ filebeat.processor }} && /etc/init.d/filebeat restart
    - requires:
      - files: filebeat_conf

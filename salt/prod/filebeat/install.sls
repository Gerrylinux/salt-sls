{% from "filebeat/map.jinja" import filebeat with context -%}
filebeat_source:
  file.managed:
    - name: /tmp/{{ filebeat.filebeat_bersion }}-{{ filebeat.processor }}.rpm
    - unless: test -e /tmp/{{ filebeat.filebeat_bersion }}-{{ filebeat.processor }}.rpm
    - source: salt://files/{{ filebeat.filebeat_bersion }}-{{ filebeat.processor }}.rpm
filebeat_install:
  cmd.run:
    - cwd: /tmp
    - names:
      - rpm -ivh {{ filebeat.filebeat_bersion }}-{{ filebeat.processor }}.rpm
    - unless: test -e {{ filebeat.conf_file }}
    - requires:
      - file: filebeat_source
#filebeat_rm:
#  cmd.run:
#    - cwd: /tmp
#    - names:
#      - rm -f filebeat-5.1.1-x86_64.rpm
#    - unless: test -e ! /tmp/filebeat-5.1.1-x86_64.rpm
#    - requires:
#      - files: filebeat_install

sysctl_config:
  file.managed:
    - source: salt://files/sysctl.conf
    - name: /etc/sysctl.conf
    - user: root
    - group: root
    - mode: 644

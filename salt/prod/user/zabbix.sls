system-user-group:
  group.present:
    - name: zabbix
    - gid: 1011

  user.present:
    - name: zabbix
    - fullname: zabbix
    - shell: /sbin/nologin
    - uid: 1011
    - gid: 1011

mysql-user-group:
  group.present:
    - name: mysql
    - gid: 1013

  user.present:
    - name: mysql
    - fullname: mysql
    - shell: /sbin/nologin
    - uid: 1013
    - gid: 1013

www-user-group:
  group.present:
    - name: www
    - gid: 1012

  user.present:
    - name: www
    - fullname: www
    - shell: /sbin/nologin
    - uid: 1012
    - gid: 1012

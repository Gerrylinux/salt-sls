redis-user-group:
  group.present:
    - name: redis
    - gid: 1016

  user.present:
    - name: redis
    - fullname: redis
    - shell: /sbin/nologin
    - uid: 1016
    - gid: 1016

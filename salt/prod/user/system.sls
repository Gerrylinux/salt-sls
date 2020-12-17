system-user-group:
  group.present:
    - name: system
    - gid: 1010

  user.present:
    - name: system
    - fullname: system
    - shell: /bin/bash
    - uid: 1010
    - gid: 1010

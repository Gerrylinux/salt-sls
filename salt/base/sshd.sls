sshd_config:
  file.managed:
    - source: salt://files/sshd_config
    - name: /etc/ssh/sshd_config
    - user: root
    - group: root
    - mode: 644

sshd:
  service.running:
    - name: sshd
    - reload: True
    - watch:
      - file: sshd_config

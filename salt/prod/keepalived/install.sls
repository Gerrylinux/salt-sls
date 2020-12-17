keepalived-install:
  pkg.installed:
    - pkgs:
      - keepalived
      - ipvsadm
/etc/keepalived/keepalived.conf:
  file.managed:
    - source: salt://keepalived/files/keepalived.conf
    - user: root
    - group: root
    - mode: 644

keepalived-init:
  cmd.run:
    - name: systemctl enable  keepalived.service
    - unless: chkconfig --list | grep keepalived

/etc/keepalived:
  file.directory:
    - user: root
    - group: root

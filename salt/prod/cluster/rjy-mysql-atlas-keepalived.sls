include:
  - keepalived.install
keepalived-server:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://cluster/files/RJY-mysql-atlas-keepalived.conf
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    {% if grains['fqdn'] == 'RJY-XCJ-SQLATLAS-01' %}
    - ROUTEID: RJY_MYSQL_DEVEL_67
    - STATEID: BACKUP
    - PRIORITYID: 100
    {% elif grains['fqdn'] == 'RJY-XCJ-SQLATLAS-02' %}
    - ROUTEID: RJY_MYSQL_DEVEL_68
    - STATEID: BACKUP
    - PRIORITYID: 75
    {% endif %}
  service.running:
    - name: keepalived
    - enable: True
    - reload: True
    - watch:
      - file: keepalived-server

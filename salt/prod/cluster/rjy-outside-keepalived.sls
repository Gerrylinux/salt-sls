include:
  - keepalived.install
keepalived-server:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://cluster/files/RJY-outside-keepalived.conf
    - mode: 644
    - user: root
    - group: root
    - template: jinja
    {% if grains['fqdn'] == 'RJY-YW-KEEPALIVED-PRX-01' %}
    - ROUTEID: RJY_LVS_DEVEL_200
    - STATEID: MASTER
    - PRIORITYID: 100
    {% elif grains['fqdn'] == 'RJY-YW-KEEPALIVED-PRX-02' %}
    - ROUTEID: RJY_LVS_DEVEL_201
    - STATEID: BACKUP
    - PRIORITYID: 50
    {% endif %}
  service.running:
    - name: keepalived
    - enable: True
    - reload: True
    - watch:
      - file: keepalived-server

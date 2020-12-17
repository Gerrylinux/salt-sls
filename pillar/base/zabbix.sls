zabbix-agent:
  - template: jinja
    {% if grains['fqdn'] == 'SM_*' %}
      - Zabbix_Server: 172.16.208.20,172.18.1.20
      - Zabbix_Active: 172.16.192.50,172.16.1.50
    {% elif grains['fqdn'] == 'YG*' %}
      - Zabbix_Server: 172.16.208.20,172.18.1.20
      - Zabbix_Active: 172.16.208.20,172.18.1.20
    {% endif %}

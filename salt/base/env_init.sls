include:
  {% if grains['os'] == 'CentOS' %}
    - audit
    - cron
    - dns
    - history
    - sysctl
  {% endif %}


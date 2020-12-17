{% from "nginx/map.jinja" import nginx with context -%}
include:
  - user.www
  - pkg.pkg-init
nginx-source-install:
  file.managed:
    - name: /usr/local/src/{{ nginx.nginx_version }}.tar.gz
    - source: salt://files/{{ nginx.nginx_version }}.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar xf {{ nginx.nginx_version }}.tar.gz && cd {{ nginx.nginx_version }} && ./configure --prefix={{ nginx.nginx_basedir }} --user=www --group=www --with-http_stub_status_module --without-http_memcached_module --with-http_ssl_module --with-ipv6 --with-http_gzip_static_module && make && make install
    - unless: test -d {{ nginx.nginx_basedir }}
    - require:
      - user: www-user-group
      - file: nginx-source-install
      - pkg: Basic_environment

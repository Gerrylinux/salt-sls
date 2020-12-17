include:
  - pcre.install
  - user.www
  - pkg.pkg-init
nginx-source-install:
  file.managed:
    - name: /usr/local/src/nginx-1.11.1.tar.gz
    - source: salt://files/nginx-1.11.1.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && tar zxf nginx-1.11.1.tar.gz && cd nginx-1.11.1&& ./configure --prefix=/usr/local/nginx --user=www --group=www --with-http_stub_status_module --without-http_memcached_module --with-http_ssl_module --with-ipv6 --with-http_gzip_static_module && make && make install
    - unless: test -d /usr/local/nginx
    - require:
      - user: www-user-group
      - file: nginx-source-install
      - pkg: Basic_environment
      - cmd: pcre-source-install

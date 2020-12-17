{% from "mysql/map.jinja" import mysql with context -%}
include:
  - user.mysql
  - pkg.mysql
mysql_repo:
  file.managed:
    - name: /usr/local/src/{{ mysql.mysql_version }}.tar.gz
    - unless: test -e /usr/local/src/{{ mysql.mysql_version }}.tar.gz
    - source: salt://files/{{ mysql.mysql_version }}.tar.gz

boost_repo:
  file.managed:
    - name: /usr/local/src/{{ mysql.boost_version }}.tar.gz
    - unless: test -e /usr/local/src/{{ mysql.boost_version }}.tar.gz
    - source: salt://files/{{ mysql.boost_version }}.tar.gz

extract_mysql:
  cmd.run:
    - cwd: /usr/local/src/
    - names:
      - tar -xf /usr/local/src/{{ mysql.mysql_version }}.tar.gz && tar xf /usr/local/src/{{ mysql.boost_version }}.tar.gz
    - unless: test -d /usr/local/src/{{ mysql.boost_version }}
    - require:
      - file: mysql_repo
      - file: boost_repo

mysql_install:
  cmd.run:
    - cwd: /usr/local/src/{{ mysql.mysql_version }}
    - names:
      - rpm -e mariadb-libs-5.5.60-1.el7_5.x86_64 --nodeps &>/dev/null
      - chown root:root /usr/local/src/{{ mysql.mysql_version }} /usr/local/src/{{ mysql.boost_version }} -R && /bin/cp -R /usr/local/src/{{ mysql.boost_version }} {{ mysql.boost_dir }} && /usr/bin/cmake -DCMAKE_INSTALL_PREFIX={{ mysql.mysql_basedir }} -DMYSQL_DATADIR={{ mysql.mysql_data }} -DMYSQL_TCP_PORT=3306 -DMYSQL_UNIX_ADDR={{ mysql.mysql_sock }} -DCURSES_LIBRARY=/usr/lib64/libncurses.so -DCURSES_INCLUDE_PATH=/usr/include -DEXTRA_CHARSETS=all -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DWITH_DEBUG=0 -DENABLED_LOCAL_INFILE=1 -DWITH_SSL:STRING=bundled -DWITH_UNIT_TESTS:BOOL=OFF -DWITH_BOOST={{ mysql.boost_dir }} -DWITH_ZLIB:STRING=bundled && make && make install 
    - require:
      - cmd: extract_mysql
      - user: mysql-user-group
    - unless: test -d {{ mysql.mysql_basedir }}


Deveploer-tools:
  cmd.run:
    - names:
      - yum -y install epel-release
      - yum clean all 

Basic_environment:
  pkg.installed:
    - pkgs:
      - gcc
      - gcc-c++
      - ncurses
      - ncurses-devel
      - cmake
    - require:
      - cmd: Deveploer-tools

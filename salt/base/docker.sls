docker_tools:
  cmd.run:
    - names:
      - yum -y install yum-utils device-mapper-persistent-data lvm2 && yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo && yum makecache fast && rpm --import https://mirrors.aliyun.com/docker-ce/linux/centos/gpg

docker_environment:
  pkg.installed:
    - pkgs:
      - docker-ce
    - require:
      - cmd: docker_tools

docker-service:
  service.running:
    - name: docker
    - enable: True
    - reload: True
    - require:
      - pkg: docker_environment 

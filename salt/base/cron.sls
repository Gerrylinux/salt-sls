ntp_cron:
  cron.present:
    - name: /usr/sbin/ntpdate ntp1.aliyun.com > /dev/null && /sbin/clock -w
    - user: root
    - minute: 0
    - hour: 2
ntpdate:
  pkg.installed:
    - name: ntpdate


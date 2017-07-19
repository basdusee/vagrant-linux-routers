pakkettenlijst:
  pkg.installed:
    - pkgs:
      - tmux
      - htop
      - dstat
      - curl
      - mc
      - rsync
      - nmap
      - file
      - time
      - sl
      - apg
      - jq
      - virt-what
      - python-pip
      - mtr-tiny
      - netcat
      - dc
      - dnstracer
      - iptraf

geen_rpc_meuk:
  service.dead:
    - name: rpcbind
    - enable: False

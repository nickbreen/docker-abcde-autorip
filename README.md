
Install `autorip.rules` to `/etc/udev/rules.d/99-autorip.rules` on the host. E.g. in `cloud-config.yml`:

    write_files:
     - path: /etc/udev/rules.d/99-autorip.rules 
       permissions: "0644"
       owner: root
       contents: |
         SUBSYSTEM=="block", KERNEL=="sr0", ACTION=="change", TAG+="systemd", ENV{SYSTEMD_WANTS}="autorip.service"

Install `autorip.service` on the host. E.g. in `cloud-config.yml`:

    coreos:
    units:
        - name: autorip.service
          content: |
            [Unit]
            Description=abcde autorip
            Requires=docker.service
            RequiresMountsFor=/srv/mythtv
            Wants=dev-sr0.device
            After=dev-sr0.device

            [Service]
            Type=oneshot
            ExecStartPre=-/usr/bin/docker kill %p
            ExecStartPre=-/usr/bin/docker rm %p
            ExecStartPre=/usr/bin/docker pull nickbreen/abcde-autorip
            ExecStartPre=/usr/bin/docker create \
                --name %p \
                --volume "/srv/mythtv/music:/srv" \
                --device "/dev/sr0:/dev/cdrom" \
                --tmpfs /tmp --tmpfs /var/tmp \
                --cap-add SYS_RAWIO \
                nickbreen/abcde-autorip
            ExecStart=/usr/bin/docker start --attach %p
            ExecReload=/usr/bin/docker restart %p
            ExecStop=/usr/bin/docker stop --time 5 %p

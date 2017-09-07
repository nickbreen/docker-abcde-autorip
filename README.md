
Install `autorip.service` on the host. E.g. in `cloud-config.yml`:

    coreos:
    units:
        - name: autorip.service
          content: |
            [Unit]
            Description=abcde autorip
            Requires=docker.service
            RequiresMountsFor=/srv/mythtv
            After=dev-cdrom.device
            BindsTo=dev-cdrom.device
            Requisite=dev-cdrom.device

            [Service]
            Type=oneshot
            ExecStartPre=-/usr/bin/docker kill %p
            ExecStartPre=-/usr/bin/docker rm %p
            ExecStartPre=/usr/bin/docker pull nickbreen/abcde-autorip
            ExecStartPre=/usr/bin/docker create \
                --name %p \
                --volume "/srv/mythtv/music:/srv" \
                --device "/dev/cdrom:/dev/cdrom" \
                --tmpfs /tmp --tmpfs /var/tmp \
                --cap-add SYS_RAWIO \
                nickbreen/abcde-autorip
            ExecStart=/usr/bin/docker start --attach %p
            ExecReload=/usr/bin/docker restart %p
            ExecStop=/usr/bin/docker stop --time 5 %p

            [Install]
            WantedBy=dev-cdrom.device
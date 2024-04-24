#!/usr/bin/bash

set -ouex pipefail

systemctl enable remote-fs.target && \
systemctl enable rpm-ostree-countme.service
systemctl enable dconf-update.service
systemctl --global enable ublue-flatpak-manager.service
systemctl enable ublue-update.timer
systemctl enable ublue-system-setup.service
systemctl --global enable ublue-user-setup.service
systemctl --global enable podman-auto-update.timer

# bluefin

[![GTS Images](https://github.com/bpbeatty/bluefin/actions/workflows/build-image-gts.yml/badge.svg)](https://github.com/bpbeatty/bluefin/actions/workflows/build-image-gts.yml) [![Stable Images](https://github.com/bpbeatty/bluefin/actions/workflows/build-image-stable.yml/badge.svg)](https://github.com/bpbeatty/bluefin/actions/workflows/build-image-stable.yml) [![Latest Images](https://github.com/bpbeatty/bluefin/actions/workflows/build-image-latest-main.yml/badge.svg)](https://github.com/bpbeatty/bluefin/actions/workflows/build-image-latest-main.yml) [![Latest Images HWE](https://github.com/bpbeatty/bluefin/actions/workflows/build-image-latest-hwe.yml/badge.svg)](https://github.com/bpbeatty/bluefin/actions/workflows/build-image-latest-hwe.yml)

![image](https://user-images.githubusercontent.com/1264109/224488462-ac4ed2ad-402d-4116-bd08-15f61acce5cf.png)
> "Let's see what's out there." - Jean-Luc Picard

This is my personal build of Bluefin. Use at your own risk. For the original go [here](https://projectbluefin.io/).

# Documentation

### For existing Silverblue/Kinoite users

1. After you reboot you should [pin the working deployment](https://docs.fedoraproject.org/en-US/fedora-silverblue/faq/#_about_using_silverblue) so you can safely rollback.
1. [AMD/Intel GPU users only] Open a terminal and rebase the OS to this image:

  *Note: latest for current fedora, gts for current fedora - 1*

    Bluefin:

        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin:latest
        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin:gts

    Bluefin Developer Experience:

        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin-dx:latest
        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin-dx:gts


1. [Nvidia GPU users only] Open a terminal and rebase the OS to this image:

    Bluefin:

        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin-nvidia:latest
        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin-nvidia:gts

    Bluefin Developer Experience:

        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin-dx-nvidia:latest
        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin-dx-nvidia:gts

1. Reboot the system and you're done!

1. To revert back:

        sudo rpm-ostree rebase fedora:fedora/39/x86_64/silverblue

Check the [Silverblue documentation](https://docs.fedoraproject.org/en-US/fedora-silverblue/) for instructions on how to use rpm-ostree.
We build date tags as well, so if you want to rebase to a particular day's release you can use the version number and date to boot off of that specific image:

    sudo rpm-ostree rebase ostree-image-signed:docekr://ghcr.io/bpbeatty/bluefin:37-20230310

The `latest` tag will automatically point to the latest build.

# Features

**This image heavily utilizes _cloud-native concepts_.**

System updates are image-based and automatic. Applications are logically seperated from the system by using Flatpaks, and the CLI experience is contained within OCI containers: 

## For Users

- Ubuntu-like GNOME layout
  - Includes the following GNOME Extensions
    - Dash to Dock - for a more Unity-like dock
    - Appindicator - for tray-like icons in the top right corner
    - GSConnect - Integrate your mobile device with your desktop
    - Blur my Shell - for that bling
- GNOME Software with [Flathub](https://flathub.org)
    - Use a familiar software center UI to install graphical software
- Built on top of the the [Universal Blue main image](https://github.com/bpbeatty/main)
  - Extra udev rules for game controllers and [other devices](https://github.com/bpbeatty/config) included out of the box
  - All multimedia codecs included
  - System designed for automatic staging of updates
    - If you've never used an image-based Linux before just use your computer normally
    - Don't overthink it, just shut your computer off when you're not using it

## For Developers

## bluefin-dx - The Bluefin Developer Experience

Dedicated developer image with bundled tools. It endevaours to be the world's most powerful cloud native developer environment. :) It includes everything in the base image plus:

- [VSCode](https://code.visualstudio.com/) and related tools
- [virt-manager](https://virt-manager.org/) and associated tooling
- [Cockpit](https://cockpit-project.org/) for local and remote management
- Podman and Docker extras
  - Automatically aliases the `docker` command to `podman`
  - podman.socket on by default so existing tools expecting a docker socket work out of the box
- LXC and LXD
- A collection of well curated monospace fonts
- hashicorp repo included and enabled
  - None of them installed by default, but you can just add them to the Containerfile as you need them
- Built-in Ubuntu user space
    - `Ctrl`-`Alt`-`u` - will launch an Ubuntu image inside a terminal via [Distrobox](https://github.com/89luca89/distrobox), your home directory will be transparently mounted
    - A [BlackBox terminal](https://www.omgubuntu.co.uk/2022/07/blackbox-gtk4-terminal-emulator-for-gnome) is used just for this configuration
    - Use this container for your typical CLI needs or to install software that is not available via Flatpak or Fedora
    - Optional [ubuntu-toolbox image](https://github.com/ublue-os/bluefin/pkgs/container/ubuntu-toolbox) with Python, and other convenience development tools. `just distrobox-bluefin` to get started. To configure `just` follow the [guide](https://ublue.it/guide/just/).
    - Optional [universal image](https://mcr.microsoft.com/en-us/product/devcontainers/universal/about) with Python, Node.js, JavaScript, TypeScript, C++, Java, C#, F#, .NET Core, PHP, Go, Ruby, and and Conda. `just distrobox-universal` to get started
    - `just assemble` shortcut to decleratively build distroboxes defined in `/etc/distrobox/distrobox.ini`
    - Refer to the [Distrobox documentation](https://distrobox.privatedns.org/#distrobox) for more information on using and configuring custom images
    - GNOME Terminal
      - `Ctrl`-`Alt`-`t` - will launch a host-level GNOME Terminal if you need to do host-level things in Fedora (you shouldn't need to do much).
- Cloud Native Tools
    - [kind](https://kind.sigs.k8s.io/) - Run a Kubernetes cluster on your machine. Do a `kind create cluster` on the host to get started!
    - [kubectl](https://kubernetes.io/docs/reference/kubectl/) - Administer Kubernetes Clusters
    - helm, ko, flux, minio-client -- if it's an incubated project we intend to add it where appropriate
- [DevPod](https://devpod.sh/docs/what-is-devpod) - reproducible developer environments, powered by [devcontainers](https://containers.dev/) - Nix-powered Development Experience powered by Devbox
- Quality of Life Improvements
    - systemd shutdown timers adjusted to 15 seconds
    - `fish` and `zsh` available as optional shells, use `just fish` or `just zsh` and follow the prompts to configure them

## Verification

These images are signed with sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/bpbeatty/bluefin

## Building Locally

1. Clone this repository and cd into the working directory

       git clone https://github.com/bpbeatty/bluefin.git
       cd bluefin

1. Make modifications if desired

1. Build the image (Note that this will download and the entire image), using included Justfile

       just build

1. [Podman push](https://docs.podman.io/en/latest/markdown/podman-push.1.html) to a registry of your choice.
1. Rebase to your image to wherever you pushed it:

       sudo rpm-ostree rebase ostree-image-signed:docker://whatever/bluefin:latest

## Frequently Asked Questions

> What about codecs?

Everything you need is included. You will need to [configure Firefox for hardware acceleration](https://ublue.it/guide/codecs/)

> How do I get my GNOME back to normal Fedora defaults?

We set the default dconf keys in `/etc/dconf/db/local`, removing those keys and updating the database will take you back to the fedora default:

    sudo rm -f /etc/dconf/db/local.d/01-ublue
    sudo dconf update

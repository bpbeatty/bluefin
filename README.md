# bluefin
**This image is considered Beta**

[![bluefin 38](https://github.com/bpbeatty/bluefin/actions/workflows/build-38-bluefin.yml/badge.svg)](https://github.com/bpbeatty/bluefin/actions/workflows/build-38-bluefin.yml) [![bluefin 39](https://github.com/bpbeatty/bluefin/actions/workflows/build-39-bluefin.yml/badge.svg)](https://github.com/bpbeatty/bluefin/actions/workflows/build-39-bluefin.yml) [![bluefin 40](https://github.com/bpbeatty/bluefin/actions/workflows/build-40-bluefin.yml/badge.svg)](https://github.com/bpbeatty/bluefin/actions/workflows/build-40-bluefin.yml)

![image](https://github.com/ublue-os/bluefin/assets/1264109/c0b3fa8a-f513-4bb1-b314-e134d1802e18)

> "Evolution is a process of constant branching and expansion." - Stephen Jay Gould

A familiar(ish) Ubuntu desktop for Fedora Silverblue. It strives to cover these two use cases. For end users it provides a system as reliable as a Chromebook with near-zero maintainance, with the power of Ubuntu and Fedora fused together. For gamers we strive to deliver a world-class Flathub gaming experience. Check [Introduction to Bluefin](https://universal-blue.discourse.group/t/introduction-to-bluefin/41) for a feature walkthrough. 

# Documentation

1. Download and install [the ISO from here](https://github.com/ublue-os/main/releases/latest/):
   - Select "Install ublue-os/bluefin" from the menu
     - Choose "Install bluefin:38" if you have an AMD or Intel GPU
     - Choose "Install bluefin-nvidia:38" if you have an Nvidia GPU
   - [Follow the rest of the installation instructions](https://ublue.it/installation/)

### For existing Silverblue/Kinoite users

1. After you reboot you should [pin the working deployment](https://docs.fedoraproject.org/en-US/fedora-silverblue/faq/#_about_using_silverblue) so you can safely rollback.
1. [AMD/Intel GPU users only] Open a terminal and rebase the OS to this image:

    Bluefin:

        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin:38

    Bluefin Developer Experience:

        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin-dx:38


1. [Nvidia GPU users only] Open a terminal and rebase the OS to this image:

    Bluefin:

        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin-nvidia:38

    Bluefin Developer Experience:

        sudo rpm-ostree rebase ostree-image-signed:docker://ghcr.io/bpbeatty/bluefin-dx-nvidia:38

1. Reboot the system and you're done!

1. To revert back:

        sudo rpm-ostree rebase fedora:fedora/38/x86_64/silverblue

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
- Built on top of the the [Universal Blue main image](https://github.com/ublue-os/main)
  - Extra udev rules for game controllers and [other devices](https://github.com/ublue-os/config) included out of the box
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
    - [Introducing Fleek](https://getfleek.dev)
      - `just nix-devbox` to get started
      - `just nix-devbox-global` to install a global profile
      - Check out [Devbox](https://www.jetpack.io/devbox) for more information
- Quality of Life Improvements
    - systemd shutdown timers adjusted to 15 seconds
    - [Just](https://github.com/casey/just) task runner for post-install automation tasks. Check out [our documentation](https://universal-blue.org/guide/just/) for more information on using and customizing just.
    - `fish` and `zsh` available as optional shells, use `just fish` or `just zsh` and follow the prompts to configure them

## Verification

These images are signed with sigstore's [cosign](https://docs.sigstore.dev/cosign/overview/). You can verify the signature by downloading the `cosign.pub` key from this repo and running the following command:

    cosign verify --key cosign.pub ghcr.io/bpbeatty/bluefin

## Building Locally

1. Clone this repository and cd into the working directory

       git clone https://github.com/bpbeatty/bluefin.git
       cd bluefin

1. Make modifications if desired

1. Build the image (Note that this will download and the entire image)

       podman build . -t bluefin

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

If you prefer a vanilla GNOME installation check out [silverblue-main](https://github.com/ublue-os/main) or [silverblue-nvidia](https://github.com/ublue-os/nvidia) for a more upstream experience.

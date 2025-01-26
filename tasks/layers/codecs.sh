#!/bin/bash
set -euo pipefail

source ~/.local/share/deskplay/helpers/rpm-ostree.sh

sudo rpm-ostree install -y --idempotent \
  gstreamer1-plugins-bad-free-extras \
  gstreamer1-plugins-bad-freeworld \
  gstreamer1-plugins-ugly \
  gstreamer1-vaapi
  # gstreamer1-plugin-libav


sudo rpm-ostree override remove \
  ffmpeg-free \
  libavcodec-free \
  libavfilter-free \
  libavformat-free \
  libavdevice-free \
  libavutil-free \
  libswscale-free \
  libpostproc-free \
  libswresample-free
  --install ffmpeg \
  --install ffmpegthumbnailer

#packages_to_remove=(
#  "ffmpeg-free"
#  "libavcodec-free"
#  "libavfilter-free"
#  "libavformat-free"
#  "libavdevice-free"
#  "libavutil-free"
#  "libswscale-free"
#  "libpostproc-free"
#  "libswresample-free"
#)
#
#rpm_ostree_override_remove "${packages_to_remove[@]}"
#
#sudo rpm-ostree install -y --idempotent \
#  ffmpeg \
#  ffmpegthumbnailer

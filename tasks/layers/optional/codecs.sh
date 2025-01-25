#!/bin/bash
set -euo pipefail

sudo rpm-ostree install -y --idempotent --allow-inactive \
  gstreamer1-plugin-libav \
  gstreamer1-plugins-bad-free-extras \
  gstreamer1-plugins-bad-freeworld \
  gstreamer1-plugins-ugly \
  gstreamer1-vaapi \
  libva-nvidia-driver

sudo rpm-ostree override remove \
  ffmpeg-free \
  libavcodec-free \
  libavfilter-free \
  libavformat-free \
  libavdevice-free \
  libavutil-free \
  libswscale-free \
  libpostproc-free \
  libswresample-free \
  --install ffmpeg \
  --install ffmpegthumbnailer

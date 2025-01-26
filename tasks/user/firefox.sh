# Export environment variables needed to make hardware accelerated video decoding work in Firefox on a Nvidia GPU 
# https://fedoraproject.org/wiki/Firefox_Hardware_acceleration#Configure_VA-API_Video_decoding_on_NVIDIA
install -d ~/.bashrc.d
cat >~/.bashrc.d/firefox.sh <<EOF
export NVD_BACKEND=direct
export MOZ_DISABLE_RDD_SANDBOX=1
EOF

# Remember to enable the vaapi configuration in Firefox
firefox --new-window "about:config" &> /dev/null &
echo "Please set 'media.ffmpeg.vaapi.enabled' to 'true' before continue."
read  -n 1 -p "[Press any key to continue]"

#!/bin/bash

# Url from https://github.com/niumoo/bing-wallpaper/blob/main/src/main/java/com/wdbyte/bing/Wallpaper.java
data_url="https://bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&pid=hp&FORM=BEHPTB&uhd=1&uhdwidth=3840&uhdheight=2160&setmkt=pt-BR&setlang=en"
bing_url="https://bing.com"
resolution="UHD"
extension=".jpg"
directory="$HOME/.cache/bingwallpaper"

data_file="$directory/data.json"

wallpaper="$directory/wallpaper$extension"

set_wallpaper() {
	if [[ $(file --brief --mime-type $wallpaper) == 'image/jpeg' ]]; then
		feh --bg-fill $wallpaper 
	fi
}

if [[ -s $data_file ]]; then
	start_date=$(jq -r '.images[0].startdate' $data_file)
	current_date=$(date +%Y%m%d)

	if [[ $current_date -eq $start_date && -f $wallpaper ]]; then
		set_wallpaper
		exit
	fi
fi

data=$(curl --silent "$data_url")

if [[ -z "$data" ]]; then
	set_wallpaper
	exit
fi

cat <<< "$data" > $data_file

base_url=$(jq -r '.images[0].urlbase' <<< "$data")
info=$(jq -r '.images[0].copyright' <<< "$data")

url="${bing_url}${base_url}_${resolution}${extension}"

if ! [[ -d $directory ]]; then
	mkdir -p $directory 
fi

if ! [[ -e "$wallpaper" ]]; then
	status_code=$(curl --write-out %{http_code} --silent --output "$wallpaper" "$url")

	if [[ status_code -eq "200" ]]; then
		notify-send -u low "New Bing Wallpaper" "$info"
	fi
fi

set_wallpaper
exit 0

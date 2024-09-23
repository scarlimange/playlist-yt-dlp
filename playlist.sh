#call python script and output to file

#python3 playlist.py > playlist.txt
python -c "from pytube import Playlist

URL_PLAYLIST = input('Enter the URL to download: ')

# Retrieve URLs of videos from playlist
playlist = Playlist(URL_PLAYLIST)
print('Number Of Videos In playlist: %s' % len(playlist.video_urls))

urls = []
for url in playlist:
    urls.append(url)

print(urls)"


#read the outputted file, remove the first line and remove all non-url formatting and put each on its own line while waiting for all output before writting it back to the origonal file

cat playlist.txt | tail -n 1 | tr -d "][''," | tr ' ' '\n' | sponge playlist.txt


#loop to take each individual line of the file and download them one by one to prevent rate limiting and output as mp4 files

for url in $( cat playlist.txt)
do
	yt-dlp --format "bv*[ext=mp4]+ba[ext=m4a]/b[ext=mp4]" $url
done
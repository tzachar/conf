#player="totem --fullscreen --replace"
player="vlc --fullscreen --aout alsa --alsa-audio-device=default"

function play()
{
	pkill -9 vlc
	$player "$1" &
}

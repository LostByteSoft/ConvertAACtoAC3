# ConvertAACtoAC3.sh
Convert AAC 6 ch to AC3 6 ch with ffmpeg (linux)

An easy way to convert audio (with video) AAC 6 channels to AC3 6 channels. It's just a bash script to use ffmpeg.

Features
--------

-Use ffmpeg. (Installed by default in most Linux distros)

-Use command line.

-The video was copied the audio was converted. (No change to video)

-Convert audio files (6 channels) to AC3 6 channels. (Wav, Aac, Dts)

How to ?
--------

-Save ConvertFileAACtoAC3.sh where you want.

-Make it executable.

-Double click on it. (Use file from Desktop)

-Select a file with the space bar and press enter.

I consider myself as a new in linux bash and if you're not happy make it yourself. :)


    Movie.Title.year.{Source.VideoCompression.AudioCompression}.ext
    Movie.Title.year.{Source.VideoCompression.AudioCompression}.language.srt

    {Br.2160px265.audio}
    {Br.1080pX264.Dts51}
    {Br.1080pX264.Ac351}
    {Br.1080pX264.St}
    {Br.720pX264.Ac351}
    {Br.720pX264.Ac320}
    {Dvd.480X264.Ac351}
    {Dvd.480X264.St}
    {Tv.SdX264.St}

Source:
    Br      Blu-Ray source
    Dvd     Dvd source
    Tv      Tv or other low resolutions sources

VideoRes:
    2160p   4k , uhd , 3840 x 2160 , 2160p
    1080p   p
    720p    p
    480     p or i
    Sd      lower than 480 p or i

AudioRes:   (Dts and Ac3 is supported in linux/windows)
    AtTr    Atmos TrueHd (5.1 or more)
    Dts51   Dts 5.1 or Dts-hd 5.1 (5.1 or more)
    Ac351   Ac3 5.1 (5.1 or more)
    Ac320   Ac3 is provide as 1.0 to ?.?
    St      Stereo (always 2.0)
    Mo      Mono (1.0)

Extension:
    eng     Language, only original language (Used for subtitles)
    srt     subtitles

Exemples:
    Die.Hard.1988.{Br.4kX26510bit.Dts51}.mkv
    Die.Hard.1988.{Br.4kX26510bit.Dts51}.eng.srt
    Jurassic.Park.1993.{Br1080pX264Ac351}.avi
    Jurassic.Park.1993.{Br1080pX264Ac351}.eng.srt

    VLC will auto load srt files

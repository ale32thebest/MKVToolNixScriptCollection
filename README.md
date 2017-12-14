# MKVToolNixScriptCollection
a collection of simple windows (command prompt) script i actually use to manage my media files (mostly movies/tv shows)

DISCLAIMER: i am not responsible to your files, a misuse of these script may overwrite your media, pay attenction when you type something, also keep in mind that these script work with the idea that the "MKVToolNix" software is installed on you machine and its executables are already added to your PATH variable, a simple google search for "how to add a folder to my windows path" may clarify if you are not familiar with these concept

**Script List:**
# 1. ALLtoMKV
- it takes all video files in the current folder and "convert" them into mkv format files (no encoding, just container change) is useful if you want to make some order in your files list. 

the usage is just ``` ALLtoMKV ``` typed in your folder with an open command prompt if you have the script in your PATH, otherwise you have to copy it to your working folder to use it

# 2. mkvAddCover
- this one is used to add covers to your already existing MKV files _(pay attenction, it deletes every jpg and pgn file in the folder after its execution as cleanup)_ it looks for a generic "cover.jpg" or "cover.png" to add it to all the video files in the working directory, if you have a tv show for example it works good like this, you can also add cover to your movies collection with a structure like "movie_name.mkv" and "movie_name.jpg" where the jpeg file is obviously the cover of the movie, the script will rename the file "cover.jpg", and attach it

the usage is just ``` mkvAddCover ``` typed in your folder with an open command prompt if you have the script in your PATH, otherwise you have to copy it to your working folder to use it

# 3. toMKV
- this is just a simple command to pack a single video file into an MKV container, it takes your original file name as a parameter and create an equivalent Matroska file (no encoding, just container change)

the usage is just ``` toMKV filename.ext ``` where _filename.ext_ is a supported video file (it will produce an equivalent _filename.mkv_) typed in your folder with an open command prompt if you have the script in your PATH, otherwise you have to copy it to your working folder to use it
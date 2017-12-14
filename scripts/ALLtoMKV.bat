FOR %%A IN (*.avi *.mp4 *.flv *.mpg *.mpeg *.rmvb *.ts *.mov ) DO mkvmerge -o "%%~nA.mkv" "%%~A"

::"--language" "0:jpn" "--language" "1:ita"
:: if added before "%%~A" you can set tracks language

:: --atracks 1
:: keep only the selcted track (in this case "a" stand for audio track) with the choosen number (1 is the f)
:: using "--atracks 1,2" you ca keep track 1 and 2

:: "%%~nA.srt" before "%%~A" ifd you want to add a subtitle track with the same name as the file
:: --attach-file "cover.jpg" if you want to add a cover as an attachment 
::(remeber to use the name "cover.jpg" as stated in the mkv guideline)

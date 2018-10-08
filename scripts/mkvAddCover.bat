:: clean output
@echo off

echo 	"Warning" every jpg and png file in this folder will be deleted at the 
echo 	end of this process, press ctrl+c to stop now, enter to go on
pause 

::if png
for %%m in (*.mkv) do ( 
copy "cover.png" "REALLY_cover.png"
copy "%%~nm.png" "cover.png"
:: attrib -r :: removes read-only
attrib -r %%m
mkvpropedit "%%m" --add-attachment "cover.png" 
move "REALLY_cover.png" "cover.png"
)

::if jpg
for %%m in (*.mkv) do ( 
copy "cover.jpg" "REALLY_cover.jpg"
copy "%%~nm.jpg" "cover.jpg"
:: attrib -r :: removes read-only
attrib -r %%m
mkvpropedit "%%m" --add-attachment "cover.jpg" 
move "REALLY_cover.jpg" "cover.jpg"
)

:: clean up
::toDo improve clean up removing only cover related images
del *.jpg 2>nul
del *.png 2>nul

:: In the end a file could contain these 4 basic cover art files:
:: cover.jpg (portrait/square 600)
:: small_cover.png (portrait/square 120)
:: cover_land.png (landscape 600) 
:: small_cover_land.jpg (landscape 120)
:: 960x600 for landscape and 600x800 for portrait, 600x600 for square

::you can use a single cover.jpg image for all files or use a specific "filename.jpg" file if you have one

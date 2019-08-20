IMAGES="/Users/steckel/Development/OmniWheel/textures"
FOLDER="/Users/steckel/Development/OmniWheel/textures_source"

cd $FOLDER
for PHOTO in *.png
do
  BASE=`basename $PHOTO .png`
  convert "$PHOTO" -alpha on -channel rgba "$IMAGES/$BASE.tga"
done

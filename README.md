# deltazipper
#run
docker run  -v $PWD/watchDir:/var/opt/MyDir/watchInDir  -v $PWD/deltaCompareDir:/var/opt/MyDir/deltaCompareDir  -v $PWD/deltaZips:/var/opt/MyDir/deltaZips -v $PWD/MyDir:/var/opt/MyDir  -i -t deltazipper:latest /var/opt/scripts/deltaZip.sh

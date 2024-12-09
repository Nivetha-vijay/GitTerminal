@ECHO off
Title "Docker UnDeployment"
CALL %Script%\Config_Data.bat
CD %BuildPath%\%UndeployBuild%\
docker ps -a 
docker ps -a --format "{{.ID}}" >>containerID.txt
FOR /F %%G IN (containerID.txt) DO (
ECHO %%G
docker stop %%G
docker rm %%G
)

docker images
docker images --format "{{.ID}}" >>ImagesID.txt
FOR /F %%A IN (ImagesID.txt) DO (
ECHO %%A
docker rmi %%A
)

docker network ls
docker network rm %UndeployBuild%

ECHO Container, Images and Network removed sucessfully
ECHO Removing the Mounted Data and cache files too
DEL containerID.txt
DEL ImagesID.txt
DEL dockerimages.txt
DEL network.txt

set /p DockerDeploy=Do You want to Deploy with New Build [y/n] ? :
if /i %DockerDeploy%==y goto Yes
if /i %DockerDeploy%==n goto No
:Yes
CALL %Script%\Docker_Deployment.bat
ECHO Return to main !!
:No
ECHO Returning to Main Menu in 5 secs
timeout /t 5 /nobreak

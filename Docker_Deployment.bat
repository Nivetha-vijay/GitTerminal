@ECHO off
Title "Docker Deployment"
CALL %Script%\Config_Data.bat
CD %BuildPath%\

set /p Build=Enter the Build Number : 
Set date=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%
set time=%TIME:~6,2%%TIME:~3,2%%TIME:~0,2%
set dateandtime=%date%_%time: =0%
mkdir %Build%_%dateandtime%
ECHO "%Build%_%dateandtime% File created"
CALL %Script%\Config_Data.bat
CD %LocalLocation%
ECHO "Copy the Build from Build machine to local"
COPY %BuildLocation% %LocalLocation%

for %%i in (*.tar) do (
ECHO %%i
docker load --input %%i
docker load --input %%i >> dockerimages.txt
)
docker images
docker images --format "{{.Repository}}:{{.Tag}}" >>Images.txt

docker network create %Build%_%dateandtime%
docker network ls >>network.txt

setlocal enabledelayedexpansion
FOR /F %%G IN (Images.txt) DO (
set A=%%G
ECHO !A! | findstr "%LICENSE%" > nul 2>&1
if not errorlevel 1 (
    docker run -d -it --network=%Build%_%dateandtime% -e securedConnection=%securedConnection% -p %LM_port_http%:%LM_port_http% -p %LM_port_https%:%LM_port_https% -v "%LM_Mount%" --name %LMNAME% !A!
	ECHO %LMNAME% container created sucessfully
	)
ECHO !A! | findstr "%REDIRECT%" > nul 2>&1
if not errorlevel 1 (
    docker run -d -it --network=%Build%_%dateandtime% -e ACCEPT_LICENSE=%ACCEPT_LICENSE% -p "%Redirector_Port%:%Redirector_Port%" -v "%Redirector_Cert%" --name %Redirector% !A!
	ECHO %Redirector% container created sucessfully
	)
ECHO !A! | findstr "%FTP%" > nul 2>&1
if not errorlevel 1 (
    docker run -d -it --network=%Build%_%dateandtime% -e ENVIRONMENT=%ENVIRONMENT% -p %FTP_Port%:%FTP_Port% -v "%FTP_Mount%" -v "%VTFTP_Cert_Mount%" --name %FTPCONTAINERNAME% !A!
	ECHO %FTPCONTAINERNAME% container created sucessfully
	)
ECHO !A! | findstr "%VT%" > nul 2>&1
if not errorlevel 1 (
    docker run -d -it --network=%Build%_%dateandtime% -e ENVIRONMENT=%ENVIRONMENT% -p %VT_Port%:%VT_Port% -v "%VT_Mount%" -v "%VTFTP_Cert_Mount%" --name %VTCONTAINERNAME% !A!
	ECHO %VTCONTAINERNAME% container created sucessfully
	)
ECHO !A! | findstr "%CLIENT%" > nul 2>&1
if not errorlevel 1 (
    docker run -d -it --network=%Build%_%dateandtime% -e %Server_ENV%=%WebServer% -e LMName=%LMNAME% -e securedConnection=%securedConnection% -e DEPENV=%DEPENV% -e FTPCONTAINERNAME=%FTPCONTAINERNAME% -e VTCONTAINERNAME=%VTCONTAINERNAME% -e HOSTFORDOCKER=%HOSTFORDOCKER% -e SOCKERPATH=%SOCKERPATH% -p %APP_Http_Port%:%APP_Http_Port% -p %APP_Https_Port%:%APP_Https_Port% -v %Client_Mount% --name %WebClient% !A!
	ECHO %WebClient% container created sucessfully
	)
ECHO !A! | findstr "%SERVER%" > nul 2>&1
if not errorlevel 1 (
    docker run -d -it --network=%Build%_%dateandtime% -e ACCEPT_LICENSE=%ACCEPT_LICENSE% -e %Server_ENV%=%WebServer% -p %Server_Http_Port%:%Server_Http_Port% -p %Server_Https_Port%:%Server_Https_Port% -p %Server_config_Port%:%Server_config_Port% -v "%Bin_Cert%" -v "%Publish_Cert%" -v "%Private_Mount%" -v "%DW_Mount%" -v "%Migration_Mount%" --name %WebServer% !A!
	ECHO %WebServer% container created sucessfully
	)
	)
docker ps

docker images >> dockerimages.txt
docker ps -a >> dockerimages.txt

ECHO Please wait for 30 secs to generate logs and url launch
timeout /t 30 /nobreak

DEL Images.txt
mkdir logs
CD %logsLocation%
docker logs %FTPCONTAINERNAME% >> %FTPCONTAINERNAME%_logs.txt
docker logs %VTCONTAINERNAME% >> %VTCONTAINERNAME%_logs.txt
docker logs %WebClient% >> %WebClient%_logs.txt
docker logs %WebServer% >> %WebServer%_logs.txt
docker logs %LMNAME% >> %LMNAME%_logs.txt
docker logs %Redirector% >> %Redirector%_logs.txt

start http://localhost:%APP_Http_Port%/%WebAlias%/%Adminconsole%
start http://localhost:%Server_Http_Port%/%ServerAlias%/%AdminFull%
start http://localhost:%LM_port_http%/%LmAlias%/%LicenseLogger%

set /p userinput=Do you Want to Execute Feature Testing :
if %userinput%==y goto Feature
if %userinput%==n goto cmd

:Feature
CALL %FeatureFile%\FeatureFile.bat

:cmd
ECHO Terminal will exit in 10 Secs
timeout /t 10 /nobreak
EXIT

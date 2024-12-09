@echo off
::Modification Starts (IF REQUIRED) --------------------------------------------------------------------------------------------------------------------------->
Set BaseFile=D:\QA\ZIEWEB_Container_v1.0
Set ProductName=ZIEForWeb
Set Version=HCL
Set Volume=ziewebvol
Set PublishDir=ZIEWeb
set UndeployBuild=Build17_20241209_090109

:: Environmental values
Set securedConnection=true
Set ENVIRONMENT=dev
Set ACCEPT_LICENSE=yes
Set DEPENV=DOCKER
Set HOSTFORDOCKER=tcp://host.docker.internal:2375
Set SOCKERPATH=var/run/docker.sock
Set Server_ENV=ZIEWebServer

::Container Name
Set WebServer=ziewebserver
Set FTPCONTAINERNAME=zieftpserver
Set VTCONTAINERNAME=zievtserver
Set Redirector=redirector
Set WebClient=ziewebclient
Set LMNAME=license

:: Port Details
Set APP_Http_Port=9080
Set APP_Https_Port=9443
Set LM_port_http=9088
Set LM_port_https=9444
Set Redirector_Port=12170-12185
Set FTP_Port=3090
Set VT_Port=3001
Set Server_Http_Port=8080
Set Server_Https_Port=8443
Set Server_config_Port=8999

::Alias 
Set ServerAlias=zie
Set WebAlias=zieweb
Set LmAlias=LicenseManager

::File Name
Set Adminconsole=adminconsole
Set AdminFull=dashboard.html
Set LicenseLogger=LicenseLogger

::Image Name
Set LICENSE=lm
Set REDIRECT=rdr
Set FTP=ftp
Set VT=vt
Set CLIENT=zie-webclient:v138
Set SERVER=webserver

::Modification Ends ------------------------------------------------------------------------------------------------------------------------------------->

:: Script File
Set Script=%BaseFile%\Build\Script
set BuildPath=%BaseFile%\Build

::Feature File
Set FeatureFile=%BaseFile%\Features

:: Locations
Set BuildLocation=%BaseFile%\Build\Build\
Set LocalLocation=%BaseFile%\Build\%Build%_%dateandtime%\
Set logsLocation=%BaseFile%\Build\%Build%_%dateandtime%\logs\

:: Mounted Values
Set LM_Mount=%BaseFile%/Build/%Build%_%dateandtime%/%Volume%/%PublishDir%-lm:/home/lm:rw
Set FTP_Mount=%BaseFile%/Build/%Build%_%dateandtime%/%Volume%/ftpbeconfig:/home/build/config:rw
Set VT_Mount=%BaseFile%/Build/%Build%_%dateandtime%/%Volume%/vtbeconfig:/home/build/config:rw
Set Client_Mount=/var/run/docker.sock:/var/run/docker.sock
Set Private_Mount=%BaseFile%/Build/%Build%_%dateandtime%/%Volume%/commondata:/opt/%Version%/%ProductName%/private/CommonData:rw
Set DW_Mount=%BaseFile%/Build/%Build%_%dateandtime%/%Volume%/dw:/opt/%Version%/%ProductName%/%PublishDir%/DW:rw
Set Migration_Mount=%BaseFile%/Build/%Build%_%dateandtime%/%Volume%/migration:/opt/%Version%/%ProductName%/migration:rw

::Cert Mount
Set Bin_Cert=%BaseFile%/Build/%Build%_%dateandtime%/%Volume%/bin-cert:/opt/%Version%/%ProductName%/bin/certificates:rw
Set Publish_Cert=%BaseFile%/Build/%Build%_%dateandtime%/%Volume%/%PublishDir%-cert:/opt/%Version%/%ProductName%/%PublishDir%/certificates:rw
Set Redirector_Cert=%BaseFile%/Build/%Build%_%dateandtime%/%Volume%/red-certificate:/home/redirector/certificates:rw
Set VTFTP_Cert_Mount=%BaseFile%/Build/%Build%_%dateandtime%/%Volume%/vtftpcert:/home/build/certificates:rw

::Redirector Path
Set RedirectorFileLocation=%BaseFile%\Build\%Build%_%dateandtime%\%Volume%\commondata\
Set RedirectorJar=%BaseFile%\Features\Redirector

::TestData
Set RedirectorTestData=%BaseFile%\Testdata\Redirector_File\
Set DWDataTestData=%BaseFile%\Testdata\ZIEWebData\
Set PublishTestData=%BaseFile%\Testdata\ZIEWEB\
Set CertificateTestData=%BaseFile%\Testdata\Certificate\

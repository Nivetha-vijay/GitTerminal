@echo off

::FeatureFile
Set RedirectorJar=D:\QA\ZIEWEB_Container_v1.0\Features\Redirector
:: Locations
Set BuildLocation=\\10.115.90.16\store_builds\projects\h\hod\HOD-cloudOffering\Zieweb\docker_image\20241001\
Set LocalLocation=D:\QA\ZIEWEB_Container_v1.0\Build\%Build%_%dateandtime%\
Set BuildPath=D:\QA\ZIEWEB_Container_v1.0\Build\
Set logsLocation=D:\QA\ZIEWEB_Container_v1.0\Build\%Build%_%dateandtime%\logs\

:: Mounted Values
Set LM_Mount=D:/QA/ZIEWEB_Container_v1.0/Build/%Build%_%dateandtime%/ziewebvol/zieweb-lm:/home/lm:rw
Set FTP_Mount=D:/QA/ZIEWEB_Container_v1.0/Build/%Build%_%dateandtime%/ziewebvol/ftpbeconfig:/home/build/config:rw
Set VT_Mount=D:/QA/ZIEWEB_Container_v1.0/Build/%Build%_%dateandtime%/ziewebvol/vtbeconfig:/home/build/config:rw
Set Client_Mount=/var/run/docker.sock:/var/run/docker.sock
Set Private_Mount=D:/QA/ZIEWEB_Container_v1.0/Build/%Build%_%dateandtime%/ziewebvol/commondata:/opt/HCL/ZIEForWeb/private/CommonData:rw
Set DW_Mount=D:/QA/ZIEWEB_Container_v1.0/Build/%Build%_%dateandtime%/ziewebvol/dw:/opt/HCL/ZIEForWeb/ZIEWeb/DW:rw
Set Migration_Mount=D:/QA/ZIEWEB_Container_v1.0/Build/%Build%_%dateandtime%/ziewebvol/migration:/opt/HCL/ZIEForWeb/migration:rw

::Cert Mount
Set Bin_Cert=D:/QA/ZIEWEB_Container_v1.0/Build/%Build%_%dateandtime%/ziewebvol/bin-cert:/opt/HCL/ZIEForWeb/bin/certificates:rw
Set ZIEWEB_Cert=D:/QA/ZIEWEB_Container_v1.0/Build/%Build%_%dateandtime%/ziewebvol/zieweb-cert:/opt/HCL/ZIEForWeb/ZIEWeb/certificates:rw
Set Redirector_Cert=D:/QA/ZIEWEB_Container_v1.0/Build/%Build%_%dateandtime%/ziewebvol/red-certificate:/home/redirector/certificates:rw
Set VTFTP_Cert_Mount=D:/QA/ZIEWEB_Container_v1.0/Build/%Build%_%dateandtime%/ziewebvol/vtftpcert:/home/build/certificates:rw

:: Environmental values
Set securedConnection=true
Set ENVIRONMENT=dev
Set ACCEPT_LICENSE=yes
Set DEPENV=DOCKER
Set HOSTFORDOCKER=tcp://host.docker.internal:2375
Set SOCKERPATH=var/run/docker.sock

::Container Name
Set ZIEWebServer=ziewebserver
Set FTPCONTAINERNAME=zieftpserver
Set VTCONTAINERNAME=zievtserver
Set Redirector=redirector
Set ziewebclient=ziewebclient
Set LMNAME=license

:: Port Details
Set APP_Http_Port=9080:9080
Set APP_Https_Port=9443:9443
Set LM_port_http=9088:9088
Set LM_port_https=9444:9444
Set Redirector_Port=12170-12185:12170-12185
Set FTP_Port=3090:3090
Set VT_Port=3001:3001
Set ZIEWEB_Http_Port=8080:8080
Set ZIEWEB_Https_Port=8443:8443
Set ZIEWEB_config_Port=8999:8999

::Image Name
Set LICENSE=hcl_lm_img
Set REDIRECT=hcl_rdr_img
Set FTP=zie-webclient-ftp
Set VT=zie-webclient-vt
Set CLIENT=zie-webclient:v138
Set SERVER=zie-webserver

::Redirector Path
Set RedirectorFileLocation=D:\QA\ZIEWEB_Container_v1.0\Build\%Build%_%dateandtime%\ziewebvol\commondata\

::TestData
Set RedirectorTestData=D:\QA\ZIEWEB_Container_v1.0\Testdata\Redirector_File\
Set ZIEWEBDataTestData=D:\QA\ZIEWEB_Container_v1.0\Testdata\ZIEWebData\
Set ZIEWEBTestData=D:\QA\ZIEWEB_Container_v1.0\Testdata\ZIEWEB\
Set CertificateTestData=D:\QA\ZIEWEB_Container_v1.0\Testdata\Certificate\
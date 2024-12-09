@ECHO OFF
Title "Docker Deployment"
ECHO Docker deployment using jenkins and git
:options
CALL Config_Data.bat
CD %Script%
ECHO Press 1 to Deploy
ECHO Press 2 to Undeploy
set /p Userinput=Enter the option to execute :	
if not defined userinput goto null value
if %Userinput%==1 goto 1
if %Userinput%==2 goto 2
:1
CALL Docker_Deployment.bat
ECHO Return to main !!
set /p E=Do you want back to the Main Menu:
if %E%==y goto options
if %E%==n goto cmd
:2
CALL Docker_UnDeploy.bat
ECHO Return to main !!
set /p E=Do you want back to the Main Menu:
if %E%==y goto options
if %E%==n goto cmd
:null value
Echo no user input or invalid input, please enter the input
goto options
:cmd
set /p userinput=do u like to continue [y/n] ? :
if /i %userinput%==y goto Yes
if /i %userinput%==n goto No
:Yes
ECHO user want to continue
CMD /k
:No
ECHO Command prompt will exit in 5 secs
timeout /t 5 /nobreak
EXIT

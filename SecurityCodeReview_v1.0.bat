@ECHO OFF
CLS
ECHO.
ECHO		  ####  #####  ####  #     # #####  ##### ##### #   #
ECHO		 #    # #     #    # #     # #    #   #     #   #   #
ECHO		 #      #     #    # #     # #    #   #     #   #   #
ECHO		  ####  ####  #      #     # ####     #     #    ### 
ECHO		      # #     #    # #     # #   #    #     #     # 
ECHO		 #    # #     #    # #     # #    #   #     #     #
ECHO		  ####  #####  ####   #####  #    # #####   #     #
ECHO.
ECHO		  ###    ###   ###   #####   ####  ##### #    # ##### ##### #      #
ECHO		 #   #  #   #  #   # #       #   # #     #    #   #   #     #      #
ECHO		 #      #   #  #   # #       #   # #     #    #   #   #     #      #
ECHO		 #      #   #  #   # ####    ####  ####  #    #   #   ####  #      #
ECHO		 #      #   #  #   # #       # #   #     #    #   #   #     #      #
ECHO		 #   #  #   #  #   # #       #  #  #      #  #    #   #     #  ##  #
ECHO		  ###    ###   ###   #####   #   # #####   #    ##### #####  ##  ##
ECHO.
ECHO			PLEASE DO NOT CLOSE THIS COMMAND WINDOW
ECHO.
ECHO		[Developed by Deepak Mourya(deepak.0401@gmail.com)]
ECHO.
ECHO			IT IS "WINDOWS" KEYWORD BASED SEARCH SCRIPT
ECHO.
ECHO	PLEASE CAREFULLY READ ALL INSTRUCTIONS OF "README.TXT"
ECHO.
ECHO.

set /p choice="*** I have read all the instructions mentioned in "README.TXT" and want to continue. [y/n] *** "
IF %choice% == y goto Label1
IF %choice% == n goto Label2

:Label1
REM "codePath" is the root of the application code. format: C:\Path\Of\Codebase (without double quots). 
REM Update below data as per your requirement
SET codePath=C:\Path\Of\Codebase

REM Provide application name or/and date "DDMMYYYY" format. For example: DemoApp01012020
REM Update below data as per your requirement
SET appName=DemoApp01012020

REM Do not change below two lines
SET resultFolder=Output_%appName%
mkdir %resultFolder%

REM *************************************************************************************
REM Checking existence of files - exclusionList.txt, StringToSearch.txt, README_(version).txt
IF NOT EXIST exclusionList.txt (
    ECHO exclusionList.txt is missing...
    GOTO Label2
 ) 
IF NOT EXIST StringToSearch.txt (
    ECHO StringToSearch.txt is missing...
    GOTO Label2
 ) 
IF NOT EXIST README.txt (
    ECHO README.txt is missing...
    GOTO Label2
 ) 
REM *************************************************************************************
ECHO.
ECHO	Step 1: Collecting files and folders information....
DIR /s /b "%codePath%" 1>%appName%_fileList.txt 2>%appName%_error.log
ECHO.

ECHO	Completed information gathering... For errors, see %appName%_error.log in %resultFolder%
ECHO.
ECHO ON
REM *************************************************************************************
ECHO.
ECHO	Step 2: Filtering "%appName%_fileList.txt" file as per given folder exclusion list
ECHO.

TYPE %appName%_fileList.txt > %appName%_new1_fileList.txt

FOR /F "tokens=*" %%i IN (exclusionList.txt) do (
TYPE %appName%_new1_fileList.txt | FINDSTR /v /i "%%i" > %appName%_new2_fileList.txt
TYPE %appName%_new2_fileList.txt > %appName%_new1_fileList.txt
)


TYPE %appName%_new1_fileList.txt > %appName%_Final_fileList.txt
DEL %appName%_new1_fileList.txt
DEL %appName%_new2_fileList.txt

ECHO.
ECHO	Completed filteration and final file list is available in "%appName%_Final_fileList.txt" file.
ECHO.
ECHO.
REM *************************************************************************************

ECHO.
ECHO	Step 3: Pattern/keyword based search script will start here
ECHO.
FOR /F "tokens=*" %%i IN (StringToSearch.txt) do (
ECHO File containing "%%i" > %resultFolder%\%%i_%appName%.txt
ECHO --------------------------- >> %resultFolder%\%%i_%appName%.txt
ECHO. >> %resultFolder%\%%i_%appName%.txt
FOR /F "tokens=*" %%f IN (%appName%_Final_fileList.txt) do (
ECHO ON
FINDSTR /s /np /i "%%i" "%%f" 1>> %resultFolder%\%%i_%appName%.txt 2>>%appName%_error.log
)
ECHO. >> %resultFolder%\%%i_%appName%.txt
ECHO. >> %resultFolder%\%%i_%appName%.txt
ECHO --------------------------- >> %resultFolder%\%%i_%appName%.txt
)

MOVE %appName%_fileList.txt %resultFolder%
MOVE %appName%_error.log %resultFolder%
MOVE %appName%_Final_fileList.txt %resultFolder%

@ECHO OFF
ECHO.
ECHO.
ECHO.
ECHO	Completed script execution and result is available at below folder
ECHO.
ECHO 	"%cd%\%resultFolder%"
GOTO Label3
ECHO.
ECHO.
REM *************************************************************************************
:Label2
ECHO.
ECHO.
ECHO	*** Please read all the instructions carefully mentioned in "README.TXT" and re-start execution of script ***
ECHO.
:Label3
ECHO.
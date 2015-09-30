@echo off

set COLOR_DEFAULT=81
set COLOR_ERROR=84
set COLOR_RUN=02

color %COLOR_DEFAULT%

SetLocal EnableDelayedExpansion

REM
REM Command line main menu. To edit this file, use encoding DOS (CP 437).
REM
REM Author: Cristiano S. Neves, 30-Sep-2015
REM

set PROJECT_NAME=Global Weather

set ARTIFACT_ID=GlobalWeather
set GROUP_ID=io.github.crisstanza
set VERSION=1.0.0-SNAPSHOT

set MAIN_PACKAGE=io.github.crisstanza.globalweather
set MAIN_CLASS=Main

set WSDL_1=http://www.webservicex.net/globalweather.asmx?WSDL
set WSDL_MAX=1;

set CP=.
set CP=%CP%;%USERPROFILE%\.m2\repository\io\github\crisstanza\jchron\1.0\jchron-1.0.jar

set INVALID_OPTION_MSG=

:MAIN_MENU
	if not [%OPTION%] == [] goto OPTION_IS_SET

	cls
	echo.
	echo         ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
	echo         º    %PROJECT_NAME% - %VERSION%   º
	echo         ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
	echo.
	if not "%INVALID_OPTION_MSG%" == "" (
		color %COLOR_ERROR%
		echo.
		echo %INVALID_OPTION_MSG%
		echo.
		pause
		color %COLOR_DEFAULT%
		set INVALID_OPTION_MSG=
		goto MAIN_MENU
	)
	echo.
	echo   Maven options:
	echo   ÄÄÄÄÄÄÄÄÄÄÄÄÄ
	echo.
	echo     [c] Clean       [i] Install   [k] Install (skip tests)
	echo     [s] Source      [t] Test      [p] Dependency tree
	echo     [r] Run
	echo.
	echo   Shortcuts: [ci] [csi] [ck] [csk]
	echo.
	echo.
	echo   WSImport options:
	echo   ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	echo.
	echo     [g] Generate    [d] Delete
	echo.
	echo.
	echo   Native options:
	echo   ÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
	echo.
	echo     [1] Compile     [2] Run           [3] Clean
	echo     [4] Release     [5] Zip release   [6] Clean release
	echo     [T] Terminal    [h] Help          [q] quit
	echo.
	echo   Shortcuts: [45]
	echo.
	echo.

	set /p OPTION="> "

:OPTION_IS_SET
	if [%OPTION%] == [c] goto OPTION_C
	if [%OPTION%] == [i] goto OPTION_I
	if [%OPTION%] == [ci] goto OPTION_CI
	if [%OPTION%] == [csi] goto OPTION_CSI
	if [%OPTION%] == [k] goto OPTION_K
	if [%OPTION%] == [ck] goto OPTION_CK
	if [%OPTION%] == [csk] goto OPTION_CSK
	if [%OPTION%] == [s] goto OPTION_S
	if [%OPTION%] == [t] goto OPTION_T
	if [%OPTION%] == [p] goto OPTION_P
	if [%OPTION%] == [r] goto OPTION_R

	if [%OPTION%] == [g] goto OPTION_WSIMPORT_G
	if [%OPTION%] == [d] goto OPTION_D

	if [%OPTION%] == [1] goto OPTION_1
	if [%OPTION%] == [2] goto OPTION_2
	if [%OPTION%] == [3] goto OPTION_3
	if [%OPTION%] == [4] goto OPTION_4
	if [%OPTION%] == [5] goto OPTION_5
	if [%OPTION%] == [45] goto OPTION_4
	if [%OPTION%] == [6] goto OPTION_6
	if [%OPTION%] == [T] goto OPTION_NATIVE_T
	if [%OPTION%] == [h] goto OPTION_NATIVE_H
	if [%OPTION%] == [q] goto OPTION_Q
	
	set INVALID_OPTION_MSG=  Invalid option "%OPTION%".

	set OPTION=

	goto MAIN_MENU

:END_OF_OPTION
	pause
	color %COLOR_DEFAULT%
:END_OF_OPTION_NON_PAUSED
	set OPTION=%OPTION:~1,1%
	if "%OPTION%" == "~1,1" set OPTION=
	goto MAIN_MENU

:OPTION_C
	echo.
	call mvn clean
	echo.
	goto END_OF_OPTION

:OPTION_I
	echo.
	call mvn install
	echo.
	goto END_OF_OPTION

:OPTION_CI
	echo.
	call mvn clean install
	echo.
	set OPTION=
	goto END_OF_OPTION

:OPTION_CSI
	echo.
	call mvn clean source:jar install
	echo.
	set OPTION=
	goto END_OF_OPTION

:OPTION_K
	echo.
	call mvn install -Dmaven.test.skip=true
	echo.
	goto END_OF_OPTION

:OPTION_CK
	echo.
	call mvn clean install -Dmaven.test.skip=true
	echo.
	set OPTION=
	goto END_OF_OPTION

:OPTION_CSK
	echo.
	call mvn clean source:jar install -Dmaven.test.skip=true
	echo.
	set OPTION=
	goto END_OF_OPTION

:OPTION_S
	echo.
	call mvn source:jar
	echo.
	goto END_OF_OPTION

:OPTION_T
	echo.
	call mvn test
	echo.
	goto END_OF_OPTION

:OPTION_P
	echo.
	set OUTPUT_FILE=dependency-tree.txt
	rem FILE GENERATION
		echo Non-verbose: > %OUTPUT_FILE%
		echo. >> %OUTPUT_FILE%
		call mvn dependency:tree >> %OUTPUT_FILE%
		echo. >> %OUTPUT_FILE%
		echo. >> %OUTPUT_FILE%
		echo. >> %OUTPUT_FILE%
		echo Verbose: >> %OUTPUT_FILE%
		echo. >> %OUTPUT_FILE%
		call mvn dependency:tree -Dverbose >> %OUTPUT_FILE%
	rem /FILE GENERATION
	notepad %OUTPUT_FILE%
	del %OUTPUT_FILE%
	echo.
	goto END_OF_OPTION_NON_PAUSED

:OPTION_R
	echo.
	call mvn exec:java -Dexec.mainClass="%MAIN_PACKAGE%.%MAIN_CLASS%"
	echo.
	goto END_OF_OPTION

:OPTION_WSIMPORT_G
	echo.
	for /l %%i in (1,1,%WSDL_MAX%) do (
		call set TMP_WSDL=%%WSDL_%%i%%
		if not [!TMP_WSDL!] == [] (
			wsimport -s .\src\main\java.wsimport -d .\target\classes -keep !TMP_WSDL!
		)
	)
	echo.
	goto END_OF_OPTION

:OPTION_D
	echo.
	if exist .\src\main\java.wsimport rmdir /s/q .\src\main\java.wsimport
	md .\src\main\java.wsimport
	goto END_OF_OPTION_NON_PAUSED

:OPTION_1
	echo.
	if not exist .\target md .\target
	if not exist .\target\classes md .\target\classes
	dir /s /b *.java > .\target\files.txt
	javac -encoding UTF-8 -sourcepath .\src\main\java -d .\target\classes -cp .\src\main\java;%CP% @.\target\files.txt
	goto END_OF_OPTION

:OPTION_2
	echo.
	cls
	color %COLOR_RUN%
	java -cp .\target\classes;%CP% %MAIN_PACKAGE%.%MAIN_CLASS%
	echo.
	goto END_OF_OPTION

:OPTION_3
	echo.
	if exist .\target rmdir /s/q .\target
	md .\target
	md .\target\classes
	if exist .\bd rmdir /s/q .\bd
	goto END_OF_OPTION

:OPTION_4
	echo.
	if not exist .\RELEASE md .\RELEASE
	if not exist .\RELEASE\bin md .\RELEASE\bin
	copy .\target\classes\*.properties .\RELEASE
	copy .\target\%ARTIFACT_ID%-%VERSION%.jar .\RELEASE\bin
	rem FILE GENERATION
		echo @echo off > .\RELEASE\%ARTIFACT_ID%-%VERSION%.bat
		echo cd bin >> .\RELEASE\%ARTIFACT_ID%-%VERSION%.bat
		echo java -jar %ARTIFACT_ID%-%VERSION%.jar >> .\RELEASE\%ARTIFACT_ID%-%VERSION%.bat
		echo pause >> .\RELEASE\%ARTIFACT_ID%-%VERSION%.bat
	rem /FILE GENERATION
	goto END_OF_OPTION_NON_PAUSED

:OPTION_5
	echo.
	cd .\RELEASE
	jar cfM ..\target\%ARTIFACT_ID%-%VERSION%.zip .\*.* .\bin\*.*
	echo Generated file: ..\target\%ARTIFACT_ID%-%VERSION%.zip
	echo.
	cd ..
	goto END_OF_OPTION

:OPTION_6
	echo.
	if exist .\RELEASE rmdir /s/q .\RELEASE
	goto END_OF_OPTION_NON_PAUSED

:OPTION_NATIVE_T
	echo.
	cmd
	goto END_OF_OPTION_NON_PAUSED

:OPTION_NATIVE_H
	cls
	echo.
	type LEIA-ME.txt
	echo.
	goto END_OF_OPTION

:OPTION_Q
	echo.
	goto END

:END
	EndLocal

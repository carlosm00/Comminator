ECHO off
SETLOCAL ENABLEDELAYEDEXPANSION

:: Batch version for Windows

:: Setting repository
ECHO.
ECHO Enter your repository link
SET /P repo=""
ECHO.
ECHO Your link is %repo%

:: Folder setting
ECHO. 
ECHO Enter the name you wish the repo folder to be
SET /P folder=""
ECHO.
ECHO Making repo...
mkdir %folder%
cd %folder%

:: Max commits per day
ECHO.
ECHO Enter the max number of commits you'd like in a day
SET /P max=""

:: Days application
ECHO.
ECHO Please, specify the number of days to be applied
SET /P days=""

:: GIT initialization
ECHO.
ECHO Initialize git
git init

:: Contribution generator
ECHO.
ECHO Generating fake contributions...

FOR /L %%I IN (%days%,-1,0) DO ( :: Loop Backwards through year
		mkdir %%I
		cd %%I
		call :genRand num :: Randomly determine number of commits that day
		ECHO Seed: !num!
		FOR /L %%J in (!num!, -1, 0) DO ( :: Loop through days commits
			SET filename=%%I_%%J
			SET /A rDate=%%I * 60*60*24
			ECHO > !filename!.txt
			git add !filename!.txt
			git commit --date=format:relative:!rDate!.seconds.ago -m !filename!
		)
		cd..
		ECHO.
)       

git remote add origin !repo!
git push origin master

SET /P cleanUP="Cleanup? [y/n]"
IF %cleanUP%==y (
	CD..
	ECHO %cd%
	IF exist %cd%/%folder% (
		ECHO deleting repo
		RMDIR /Q /S %cd%\%folder%
	) ELSE (
		ECHO No repo to delete
	)
)
ENDLOCAL
PAUSE

:genRand
SET /A %1=%random% * (%max% - 1 + 1) / 32768 + 1
EXIT /B

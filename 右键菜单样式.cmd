@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
CALL :D 76 20 2F
CD /D "%~DP0"
TITLE �����Ҽ����ܣ�Feature Management��
BCDEDIT|FIND "Windows Boot Manager" >NUL
IF %ERRORLEVEL%==1 (SET F="%TEMP%\GETADMIN.VBS"
	DEL !F! /F /Q >NUL 2>NUL
	ECHO CREATEOBJECT^("SHELL.APPLICATION"^).SHELLEXECUTE "%~F0", "%*", "", "RUNAS", 1 >!F!
	CSCRIPT //B !F! && EXIT /B
	DEL !F! /F /Q >NUL 2>NUL
)
SET KK=
FOR /F "Tokens=4 Delims= " %%V IN ('CMD /C VER') DO (
	FOR /F "Tokens=1-4 Delims=.]" %%A IN ('ECHO %%V') DO (
		IF %%A GTR 10 SET KK=+ & GOTO :M
		IF %%A EQU 10 (
			IF %%B GTR 0 SET KK=+ & GOTO :M
			IF %%C GTR 22000 SET KK=+ & GOTO :M
			IF %%C EQU 22000 SET KK=%%D & GOTO :M
			IF %%C GEQ 21996 SET KK=- & GOTO :M
		)
	)	
)
CALL :B 55 12 4F "��⵽��ϵͳ���ǡ�Windows 11�����޷��������С�" "N" "�����Ҽ����ܣ�Feature Management��"
Exit

:M
CLS
CALL :C 3
ECHO. 	======================================================= 
ECHO. 	        ��ѡ���Ҽ����ܹ���Feature Management���� 
ECHO. 	======================================================= 
CALL :C 3
ECHO.      1��   Windows 11 ���¿�ʽ
ECHO.
ECHO.      2��   Windows 10 �����ʽ
CALL :C 3 
CHOICE /C 12 /M ".    �밴����ѡ��"
IF "%ERRORLEVEL%"=="2"  SET /A S1=1 & SET "S2=����" & GOTO :A
IF "%ERRORLEVEL%"=="1"  SET /A S1=0 & SET "S2=����" & GOTO :A
GOTO :M

:A
CALL :B 55 12 4F "      ��رգ����棩�������е���������������" "N" "ִ�б����������Զ������������"
NET Start TrustedInstaller >NUL 2>NUL
"%~dp0Bin\SuperUser64.exe" /w /c "%~dp0Bin\Data.CMD" %S1% "%KK%"
CALL :B 55 12 2F "10��������������������%S2%��ʽ���Ҽ�������Ч��" "R" "�����Ҽ����ܣ�Feature Management��"
Exit

	


:B
TITLE %~6
CALL :D %~1 %~2 %~3
CLS
CALL :C 3
ECHO.   %~4
CALL :C 4
ECHO.         ��   ��   ��   ��   ��   ��   ��   ��
IF /I "%~5"=="R" (
	shutdown /r /f /t 10
	timeout /t 9 >nul
) else (PAUSE >nul)
GOTO :EOF

:C
FOR /l %%X IN (1,1,%~1) DO ECHO.
GOTO :EOF

:D
MODE CON COLS=%~1 LINES=%~2
COLOR %~3
GOTO :EOF
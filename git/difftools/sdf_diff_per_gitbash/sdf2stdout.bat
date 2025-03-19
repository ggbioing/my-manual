@echo off
REM echo( %0
REM echo( %1

REM copy sdf locally because accessing sdf causes metadata changes in it (why microsoft, why?!)
REM SET SCRIPT_DIR=%~dp0
REM set tmpVar=%SCRIPT_DIR%_%date:~6,4%-%date:~3,2%-%date:~0,2%_%time::=.%.sdf
REM echo( %tmpVar%
REM copy /B "%1" "%tmpVar%"
SET SDF_FILE=%1

FOR %%a IN (%SDF_FILE%) do (
    set file=%%~fa
    set filepath=%%~dpa
    set filename=%%~nxa
)    
REM echo %file% = %filepath% + %filename%

: ./AddOn/Calibrazione/parametri.sdf
: ./AddOn/Dicom/lingueQuerySCU.sdf
: ./AddOn/Dicom/lingueStorageSCU.sdf
: ./AddOn/feedback.sdf
: ./AddOn/lingue.sdf
: ./lingue.sdf
: ./lingueStampaFrax.sdf
: ./parametri.sdf
: ./TableTemp.sdf

: https://stackoverflow.com/questions/7005951/batch-file-find-if-substring-is-in-string-not-in-a-file
: Yes, you can use substitutions and check against the original string:
: if not x%str1:bcd=%==x%str1% echo It contains bcd
: The %str1:bcd=% bit will replace a bcd in str1 with an empty string, making it different from the original.
: If the original didn't contain a bcd string in it, the modified version will be identical.
: A couple of notes:
:     The if statement is the meat of this solution, everything else is support stuff.
:     The x before the two sides of the equality is to ensure that the string bcd works okay. It also protects against certain "improper" starting characters.

IF "%filename%" == "dicomset.sdf" (
	SET passwd=CC3.13,7,10,9,13,11#8;1756;gh9
	GOTO:DICOMSET
)
IF NOT x"%filename:logfile.sdf=%" == "x%filename%" (
IF "%filename%" == "logfile.sdf" (
	SET passwd=RFmaAG28
	GOTO:LOGFILE
	)
)
IF "%filename%" == "pazienti.sdf" (
	SET passwd=RFmaAG28
	GOTO:PAZIENTI
)
IF "%filename%" == "pazienti_assistenza.sdf" (
	SET passwd=RFmaAG28
	GOTO:PAZIENTI
)
IF "%filename%" == "lingue.sdf" (
	SET passwd=RFAnF7213#-28?!14L@2015#12#1133@_10
	GOTO:LINGUE
)
IF NOT x"%filename:pazienti2.sdf=%" == "x%filename%" (
	SET passwd=RFmaAG28RFAnF7213#28?!14L@2015#12#1133@
	GOTO:PAZIENTI2
)
IF "%filename%" == "pazienti2.sdf" (
	SET passwd=RFmaAG28RFAnF7213#28?!14L@2015#12#1133@
	GOTO:PAZIENTI2
)
IF "%filename%" == "pazientiA.sdf" (
	SET passwd=RFAnF7213#-28?!14L@2015#12#1133@_10
	GOTO:PAZIENTIA
)
IF "%filename%" == "TableTemp.sdf" (
	SET passwd=RFmaAG28
	GOTO:TABLETEMP
)
IF "%filename%" == "utentiL.sdf" (
	SET passwd=TPDAnX7915#-28?!14L@2022#19#1133@_120
	GOTO:UTENTIL
)
IF "%filename%" == "worklist.sdf" (
	SET passwd=RFmaAG28
	GOTO:WORKLIST
)

:UNSUPPORTED
ECHO UNSUPPORTED %filename%pippo
GOTO:EOF

:DICOMSET
echo( 
echo( ADDON/DICOM/DICOMSET.SDF - DICOMSETSCU
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM dicomsetscu" stdout
GOTO:SCHEMA

:LOGFILE
SET passwd=RFmaAG28
echo(
echo( EVENTS/LOGFILE.SDF - FILEEPATH
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM fileepath" stdout
echo(
echo( EVENTS/LOGFILE.SDF - LOGS
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM logs" stdout
GOTO:SCHEMA

:PAZIENTI
echo(
echo( PAZIENTI.SDF - INTESTAZIONE REFERTO
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM intestazione_referto" stdout
echo(
echo( PAZIENTI.SDF - UTENTI
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM utenti" stdout
echo(
echo( PAZIENTI.SDF - PAZIENTI
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM pazienti" stdout
echo(
echo( PAZIENTI.SDF - ANALISI
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM analisi" stdout
echo(
echo( PAZIENTI.SDF - OUTPUT
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM Output" stdout
echo(
echo( PAZIENTI.SDF - ETNIA
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM etnia" stdout
echo(
echo( PAZIENTI.SDF - WORKLIST
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM worklist" stdout
GOTO:SCHEMA

:PAZIENTI2
echo(
echo( PAZIENTI2.SDF - CONFIGURAZIONE
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM Configurazione" stdout
GOTO:SCHEMA

:PAZIENTIA
echo(
echo( ADDON/PAZIENTIA.SDF - ADIPOMETRO
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM adipometro" stdout
GOTO:SCHEMA

:TABLETEMP
echo( 
echo( TABLETEMP.SDF - ANALISI
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM analisi" stdout
GOTO:SCHEMA

:UTENTIL
echo(
echo( UTENTIL.SDF - ACCESSI
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM accessi" stdout
echo(
echo( UTENTIL.SDF - UTENTI
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM utenti" stdout
GOTO:SCHEMA

:WORKLIST
echo( 
echo( ADDON/DICOM/WORKLIST.SDF - PAZIENTE
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM paziente" stdout
GOTO:SCHEMA

:LINGUE
echo( 
echo( LINGUE.SDF - CONFIGURAZIONE
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM configurazione" stdout
echo( 
echo( LINGUE.SDF - confVisualizzazioneTMP
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM confVisualizzazioneTMP" stdout
echo( 
echo( LINGUE.SDF - lingua
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM lingua" stdout
echo( 
echo( LINGUE.SDF - linguetab
sdf2csv.exe %SDF_FILE% %passwd% "SELECT * FROM linguetab" stdout
GOTO:SCHEMA

:SCHEMA
echo(
echo( INFORMATION_SCHEMA.COLUMNS
sdf2csv.exe %SDF_FILE% %passwd% "SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, NUMERIC_PRECISION, CHARACTER_MAXIMUM_LENGTH FROM INFORMATION_SCHEMA.COLUMNS" stdout
echo(
echo( INFORMATION_SCHEMA.KEY_COLUMN_USAGE
sdf2csv.exe %SDF_FILE% %passwd% "SELECT TABLE_NAME, COLUMN_NAME, CONSTRAINT_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE ORDER BY TABLE_NAME, COLUMN_NAME" stdout
GOTO:EOF

REM del %tmpVar%

::-- Get all the columns of the database
::SELECT * 
::FROM INFORMATION_SCHEMA.COLUMNS
::-- Get all the indexes of the database
::SELECT * 
::FROM INFORMATION_SCHEMA.INDEXES
::-- Get all the indexes and columns of the database
::SELECT * 
::FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
::-- Get all the datatypes of the database
::SELECT * 
::FROM INFORMATION_SCHEMA.PROVIDER_TYPES
::-- Get all the tables of the database
::SELECT * 
::FROM INFORMATION_SCHEMA.TABLES
::-- Get all the constraint of the database
::SELECT * 
::FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
::-- Get all the foreign keys of the database
::SELECT * 
::FROM INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS
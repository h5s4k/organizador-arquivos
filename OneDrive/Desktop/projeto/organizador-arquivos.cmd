@echo off
setlocal enabledelayedexpansion

:: Configuração - pode ser editada conforme necessidade
set "PASTA_IMAGENS=Imagens"
set EXT_IMAGENS=.jpg .jpeg .png .gif .bmp

set "PASTA_DOCS=Documentos"
set EXT_DOCS=.pdf .docx .doc .xlsx .pptx .txt .rtf

set "PASTA_AUDIO=Audios"
set EXT_AUDIO=.mp3 .wav .ogg .flac

set "PASTA_VIDEO=Videos"
set EXT_VIDEO=.mp4 .mov .avi .mkv .flv

set "PASTA_ZIP=Compactados"
set EXT_ZIP=.zip .rar .7z .tar .gz

set "PASTA_EXE=Executaveis"
set EXT_EXE=.exe .msi

set "PASTA_OUTROS=Outros"

:: Verifica se foi passado um diretório, senão usa o atual
if "%~1"=="" (
    set "diretorio=."
) else (
    set "diretorio=%~1"
)

:: Verifica se o diretório existe
if not exist "%diretorio%" (
    echo Diretório "%diretorio%" não existe!
    pause
    exit /b 1
)

:: Cria as pastas necessárias
for %%P in (
    "%PASTA_IMAGENS%" 
    "%PASTA_DOCS%" 
    "%PASTA_AUDIO%" 
    "%PASTA_VIDEO%" 
    "%PASTA_ZIP%" 
    "%PASTA_EXE%" 
    "%PASTA_OUTROS%"
) do (
    if not exist "%diretorio%\%%~P" (
        mkdir "%diretorio%\%%~P"
        echo Criada pasta: %%~P
    )
)

:: Contador de arquivos movidos
set /a count=0

:: Organiza os arquivos
for %%F in ("%diretorio%\*") do (
    if not "%%~xF"=="" if exist "%%F" if not "%%~nF"=="" (
        set "ext=%%~xF"
        set "moved=0"
        
        :: Verifica cada categoria
        for %%G in (%EXT_IMAGENS%) do if /i "!ext!"=="%%G" (
            move "%%F" "%diretorio%\%PASTA_IMAGENS%\" >nul
            set /a count+=1
            set "moved=1"
        )
        
        for %%G in (%EXT_DOCS%) do if /i "!ext!"=="%%G" (
            move "%%F" "%diretorio%\%PASTA_DOCS%\" >nul
            set /a count+=1
            set "moved=1"
        )
        
        for %%G in (%EXT_AUDIO%) do if /i "!ext!"=="%%G" (
            move "%%F" "%diretorio%\%PASTA_AUDIO%\" >nul
            set /a count+=1
            set "moved=1"
        )
        
        for %%G in (%EXT_VIDEO%) do if /i "!ext!"=="%%G" (
            move "%%F" "%diretorio%\%PASTA_VIDEO%\" >nul
            set /a count+=1
            set "moved=1"
        )
        
        for %%G in (%EXT_ZIP%) do if /i "!ext!"=="%%G" (
            move "%%F" "%diretorio%\%PASTA_ZIP%\" >nul
            set /a count+=1
            set "moved=1"
        )
        
        for %%G in (%EXT_EXE%) do if /i "!ext!"=="%%G" (
            move "%%F" "%diretorio%\%PASTA_EXE%\" >nul
            set /a count+=1
            set "moved=1"
        )
        
        :: Se não foi movido para nenhuma categoria específica, move para Outros
        if "!moved!"=="0" if not "%%~xF"=="" (
            move "%%F" "%diretorio%\%PASTA_OUTROS%\" >nul
            set /a count+=1
        )
    )
)

echo Organização concluída! %count% arquivos movidos.
pause
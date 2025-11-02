<#
.SYNOPSIS
    Guided, multi-language script to install prerequisites
    and compile a chosen branch of CrystalServer (Canary).
    Version 7: Removed all Polish diacritics to prevent encoding errors.
.DESCRIPTION
    WARNING:
    1. MUST be run as ADMINISTRATOR.
    2. The script will open download pages in your browser.
    3. You must manually install the programs as instructed.
    4. This entire process (especially compilation) will take a VERY LONG TIME.
#>

# --- Nagłówek / Header / Cabeçalho ---
Clear-Host
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host " Welcome To CrystalServer Windows Installer" -ForegroundColor White
Write-Host " Bem-vindo ao Instalador CrystalServer Windows" -ForegroundColor White
Write-Host " Witamy w Instalatorze CrystalServer Windows" -ForegroundColor White
Write-Host "===============================================" -ForegroundColor Cyan
Write-Host ""
Start-Sleep -Seconds 3

# --- Krok 0.1: Ustawienie Polityki Uruchamiania / Set Execution Policy ---
Write-Host "Setting Execution Policy to 'RemoteSigned' for Current User (to allow scripts to run in the future)..." -ForegroundColor Cyan
Write-Host "Ustawianie polityki uruchamiania na 'RemoteSigned' (aby skrypt dzialal w przyszlosci)..." -ForegroundColor Cyan
try {
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force -ErrorAction Stop
    Write-Host "Policy set successfully." -ForegroundColor Cyan
} catch {
    Write-Warning "Could not set execution policy. You may need to run 'Set-ExecutionPolicy Bypass -Scope Process' manually each time."
}
Start-Sleep -Seconds 2

# --- Krok 0.2: Wybór Języka / Language Selection / Seleção de Idioma ---

$lang = $null
while ($lang -eq $null) {
    Clear-Host
    Write-Host "Please select your language:" -ForegroundColor Yellow
    Write-Host "Por favor, selecione seu idioma:" -ForegroundColor Yellow
    # === POPRAWIONA LINIA (usunięte polskie znaki) ===
    Write-Host "Prosze wybrac swoj jezyk:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  1: English"
    Write-Host "  2: Português (Brasil)"
    Write-Host "  3: Polski"
    Write-Host ""
    $choice = Read-Host -Prompt "Enter 1, 2, or 3"

    switch ($choice) {
        '1' {
            $lang = @{
                Title           = "--- Interactive CrystalServer (Canary) Compiler ---"
                Description     = "This script will guide you through installing Git, CMake, and Visual Studio, then it will attempt to compile the server."
                AdminWarning1   = "Administrator privileges are required!"
                AdminWarning2   = "Please re-run this script by right-clicking it and selecting 'Run as administrator'."
                PressEnterExit  = "Press Enter to exit"
                CheckFound      = "found. Skipping."
                CheckNotFound   = "not found. Starting installation guide..."
                Step1Title      = "--- STEP 1: Checking for Git ---"
                Step1Inst1      = "  1. Download the '64-bit Git for Windows Setup' installer."
                Step1Inst2      = "  2. Run it and click through the installation (defaults are OK)."
                Step1Inst3      = "  3. IMPORTANT: Ensure 'Add to PATH' is selected (usually default)."
                Step1Prompt     = "Press Enter when you have FINISHED installing Git..."
                Step2Title      = "--- STEP 2: Checking for CMake ---"
                Step2Inst1      = "  1. Download the latest Windows x64 installer (.msi file)."
                Step2Inst2      = "  2. Run it."
                Step2Inst3      = "  3. IMPORTANT: In the installer, choose 'Add CMake to the system PATH for all users'."
                Step2Prompt     = "Press Enter when you have FINISHED installing CMake..."
                Step3Title      = "--- STEP 3: Checking for Visual Studio 2022 ---"
                Step3Inst1      = "  1. Download and run 'vs_community.exe'."
                Step3Inst2      = "  2. The 'Visual Studio Installer' will open. Go to the 'Workloads' tab."
                Step3Inst3      = "  3. IMPORTANT: Check the box for 'Desktop development with C++'."
                Step3Inst4      = "  4. Click 'Install' (this will take a long time and download several GB)."
                Step3Prompt     = "Press Enter when you have FINISHED installing Visual Studio..."
                VSWarning       = "Visual Studio Installer found. Skipping download. PLEASE ENSURE the 'Desktop development with C++' workload is installed. If Step 7 (CMake) fails, run the 'Visual Studio Installer' from your Start Menu and add this workload."
                Step4Title      = "--- STEP 4: Reloading and Verifying Environment ---"
                Step4Desc1      = "Attempting to refresh PATH to find Git and CMake..."
                Step4Error1     = "Failed to find Git or CMake after installation/reload."
                Step4Error2     = "If you just installed them, PLEASE RESTART THIS SCRIPT. A restart is often required after installing."
                Step4Success    = "Git and CMake verified! Proceeding to compilation..."
                Step5Title      = "--- STEP 5: Setting up vcpkg ---"
                Step5CreateDir  = "Creating directory: {0}"
                Step5Clone      = "Cloning vcpkg repository..."
                Step5Build      = "Bootstrapping vcpkg..."
                Step5Exists     = "vcpkg already exists. Skipping."
                Step5InstallLibs = "Installing libraries (openssl, boost). THIS MAY TAKE A VERY LONG TIME..."
                Step5PromptDone = "Step 5 (vcpkg) is complete. Press Enter to continue to Step 6..."
                Step6Title      = "--- STEP 6: Cloning CrystalServer Source ---"
                Step6Clone      = "Cloning CrystalServer repository (branch: {0})..."
                Step6Exists     = "CrystalServer already exists. Skipping."
                Step6PromptDone = "Step 6 (Cloning) is complete. Press Enter to continue to Step 7..."
                Step7Title      = "--- STEP 7: Configuring CMake Project ---"
                Step7Config     = "Running CMake configuration..."
                Step7Success    = "CMake configuration successful."
                Step7Error      = "CMake configuration FAILED."
                Step7ErrorCommon = "Check errors above. Common causes: vcpkg error or missing C++ workload in Visual Studio."
                Step7PromptDone = "Step 7 (CMake Config) is complete. Press Enter to begin compilation (Step 8)..."
                Step8Title      = "--- STEP 8: Compiling the Project (Release) ---"
                Step8Desc       = "This is the final step, it may also take a long time."
                Step8Error      = "Build FAILED. Check compilation errors above."
                DoneTitle       = "         BUILD COMPLETED SUCCESSFULLY!        "
                DonePath        = "The compiled server files are located in:"
                DonePrompt      = "Press Enter to close this window"
            }
        }
        '2' {
            $lang = @{
                Title           = "--- Compilador Interativo CrystalServer (Canary) ---"
                Description     = "Este script irá guiá-lo na instalação do Git, CMake e Visual Studio, e então tentará compilar o servidor."
                AdminWarning1   = "Privilégios de Administrador são necessários!"
                AdminWarning2   = "Por favor, execute este script novamente clicando com o botão direito e selecionando 'Executar como administrador'."
                PressEnterExit  = "Pressione Enter para sair"
                CheckFound      = "encontrado. Pulando."
                CheckNotFound   = "nao encontrado. Iniciando guia de instalacao..."
                Step1Title      = "--- PASSO 1: Verificando o Git ---"
                Step1Inst1      = "  1. Baixe o instalador '64-bit Git for Windows Setup'."
                Step1Inst2      = "  2. Execute-o e prossiga com a instalação (os padrões são OK)."
                Step1Inst3      = "  3. IMPORTANTE: Certifique-se de que 'Add to PATH' está selecionado (geralmente é o padrão)."
                Step1Prompt     = "Pressione Enter quando TERMINAR de instalar o Git..."
                Step2Title      = "--- PASSO 2: Verificando o CMake ---"
                Step2Inst1      = "  1. Baixe o instalador mais recente do Windows x64 (arquivo .msi)."
                Step2Inst2      = "  2. Execute-o."
                Step2Inst3      = "  3. IMPORTANTE: No instalador, escolha 'Add CMake to the system PATH for all users'."
                Step2Prompt     = "Pressione Enter quando TERMINAR de instalar o CMake..."
                Step3Title      = "--- PASSO 3: Verificando o Visual Studio 2022 ---"
                Step3Inst1      = "  1. Baixe e execute 'vs_community.exe'."
                Step3Inst2      = "  2. O 'Instalador do Visual Studio' será aberto. Vá para a aba 'Cargas de Trabalho' (Workloads)."
                Step3Inst3      = "  3. IMPORTANTE: Marque a caixa 'Desenvolvimento para desktop com C++' ('Desktop development with C++')."
                Step3Inst4      = "  4. Clique em 'Instalar' (isso levará muito tempo e baixará vários GB)."
                Step3Prompt     = "Pressione Enter quando TERMINAR de instalar o Visual Studio..."
                VSWarning       = "Instalador do Visual Studio encontrado. Pulando download. POR FAVOR, VERIFIQUE se a carga de trabalho 'Desenvolvimento para desktop com C++' esta instalada. Se o Passo 7 (CMake) falhar, execute o 'Instalador do Visual Studio' e adicione essa carga."
                Step4Title      = "--- PASSO 4: Recarregando e Verificando o Ambiente ---"
                Step4Desc1      = "Tentando atualizar o PATH para encontrar o Git e o CMake..."
                Step4Error1     = "Falha ao encontrar o Git ou CMake após a instalação/recarregamento."
                Step4Error2     = "Se voce acabou de instala-los, POR FAVOR, REINICIE ESTE SCRIPT. Muitas vezes e necessario reiniciar."
                Step4Success    = "Git e CMake verificados! Prosseguindo para a compilação..."
                Step5Title      = "--- PASSO 5: Configurando o vcpkg ---"
                Step5CreateDir  = "Criando diretório: {0}"
                Step5Clone      = "Clonando repositório vcpkg..."
                Step5Build      = "Inicializando vcpkg (bootstrap)..."
                Step5Exists     = "vcpkg já existe. Pulando."
                Step5InstallLibs = "Instalando bibliotecas (openssl, boost). ISSO PODE LEVAR MUITO TEMPO..."
                Step5PromptDone = "Passo 5 (vcpkg) concluido. Pressione Enter para continuar..."
                Step6Title      = "--- PASSO 6: Clonando o Código do CrystalServer ---"
                Step6Clone      = "Clonando repositório CrystalServer (branch: {0})..."
                Step6Exists     = "CrystalServer já existe. Pulando."
                Step6PromptDone = "Passo 6 (Clonagem) concluido. Pressione Enter para continuar..."
                Step7Title      = "--- PASSO 7: Configurando o Projeto CMake ---"
                Step7Config     = "Executando configuração do CMake..."
                Step7Success    = "Configuração do CMake bem-sucedida."
                Step7Error      = "Configuração do CMake FALHOU."
                Step7ErrorCommon = "Verifique os erros acima. Causas comuns: erro no vcpkg ou falta da carga de trabalho C++ no Visual Studio."
                Step7PromptDone = "Passo 7 (Config. CMake) concluido. Pressione Enter para iniciar a compilacao (Passo 8)..."
                Step8Title      = "--- PASSO 8: Compilando o Projeto (Release) ---"
                Step8Desc       = "Este é o último passo, também pode levar muito tempo."
                Step8Error      = "A compilação FALHOU. Verifique os erros de compilação acima."
                DoneTitle       = "         COMPILAÇÃO CONCLUÍDA COM SUCESSO!        "
                DonePath        = "Os arquivos compilados do servidor estão localizados em:"
                DonePrompt      = "Pressione Enter para fechar esta janela"
            }
        }
        '3' {
            # Polskie znaki diakrytyczne zostaly usuniete, aby uniknac bledow kodowania.
            $lang = @{
                Title           = "--- Interaktywny Kompilator CrystalServer (Canary) ---"
                Description     = "Ten skrypt poprowadzi Cie przez instalacje Git, CMake i Visual Studio, a nastepnie sam sprobuje skompilowac serwer."
                AdminWarning1   = "Wymagane sa uprawnienia Administratora!"
                AdminWarning2   = "Uruchom ten skrypt ponownie, klikajac na niego prawym przyciskiem myszy i wybierajac 'Uruchom jako administrator'."
                PressEnterExit  = "Nacisnij Enter, aby zakonczyc"
                CheckFound      = "znaleziony. Pomijanie."
                CheckNotFound   = "nie znaleziony. Uruchamianie instrukcji instalacji..."
                Step1Title      = "--- KROK 1: Sprawdzanie GIT ---"
                Step1Inst1      = "  1. Pobierz instalator '64-bit Git for Windows Setup'."
                Step1Inst2      = "  2. Uruchom go i przejdz przez instalacje (domyslne ustawienia sa OK)."
                Step1Inst3      = "  3. WAZNE: Upewnij sie, ze opcja 'Add to PATH' jest zaznaczona (zazwyczaj domyslna)."
                Step1Prompt     = "Nacisnij Enter, gdy ZAKONCZYSZ instalacje Git..."
                Step2Title      = "--- KROK 2: Sprawdzanie CMAKE ---"
                Step2Inst1      = "  1. Pobierz najnowszy instalator Windows x64 (plik .msi)."
                Step2Inst2      = "  2. Uruchom go."
                Step2Inst3      = "  3. WAZNE: W instalatorze wybierz opcje 'Add CMake to the system PATH for all users'."
                Step2Prompt     = "Nacisnij Enter, gdy ZAKONCZYSZ instalacje CMake..."
                Step3Title      = "--- KROK 3: Sprawdzanie VISUAL STUDIO 2022 ---"
                Step3Inst1      = "  1. Pobierz i uruchom 'vs_community.exe'."
                Step3Inst2      = "  2. Otworzy sie 'Visual Studio Installer'. Przejdz do zakladki 'Workloads' ('Obciazenia')."
                Step3Inst3      = "  3. WAZNE: Zaznacz pole 'Programowanie aplikacji klasycznych w jezyku C++' ('Desktop development with C++')."
                Step3Inst4      = "  4. Kliknij 'Zainstaluj' (to potrwa bardzo dlugo i pobierze kilka GB)."
                Step3Prompt     = "Nacisnij Enter, gdy ZAKONCZYSZ instalacje Visual Studio..."
                VSWarning       = "Znaleziono Instalator Visual Studio. Pomijanie pobierania. PROSZE UPEWNIJ SIE, ze pakiet 'Programowanie aplikacji klasycznych w jezyku C++' jest zainstalowany. Jesli Krok 7 (CMake) sie nie uda, uruchom 'Visual Studio Installer' z Menu Start i dodaj ten pakiet."
                Step4Title      = "--- KROK 4: Przeladowanie i Weryfikacja Srodowiska ---"
                Step4Desc1      = "Probuje odswiezyc PATH, aby znalezc Git i CMake..."
                Step4Error1     = "Nie udalo sie znalezc Git lub CMake po instalacji/przeladowaniu."
                Step4Error2     = "Jesli wlasnie je zainstalowales, PROSZE URUCHOM TEN SKRYPT PONOWNIE. Czesto jest to wymagane."
                Step4Success    = "Git i CMake zweryfikowane! Przechodzenie do kompilacji..."
                Step5Title      = "--- KROK 5: Konfiguracja vcpkg ---"
                Step5CreateDir  = "Tworzenie katalogu: {0}"
                Step5Clone      = "Klonowanie repozytorium vcpkg..."
                Step5Build      = "Budowanie vcpkg..."
                Step5Exists     = "vcpkg juz istnieje. Pomijanie."
                Step5InstallLibs = "Instalacja bibliotek (openssl, boost). TO MOZE POTRWAC BARDZO DLUGO..."
                Step5PromptDone = "Krok 5 (vcpkg) zakonczony. Nacisnij Enter, aby przejsc do Kroku 6..."
                Step6Title      = "--- KROK 6: Pobieranie kodu CrystalServer ---"
                Step6Clone      = "Klonowanie repozytorium CrystalServer (galaz: {0})..."
                Step6Exists     = "CrystalServer juz istnieje. Pomijanie."
                Step6PromptDone = "Krok 6 (Klonowanie) zakonczony. Nacisnij Enter, aby przejsc do Kroku 7..."
                Step7Title      = "--- KROK 7: Konfiguracja projektu CMake ---"
                Step7Config     = "Uruchamianie konfiguracji CMake..."
                Step7Success    = "Konfiguracja CMake zakonczona sukcesem."
                Step7Error      = "Konfiguracja CMake NIE POWIODLA SIE."
                Step7ErrorCommon = "Sprawdz bledy powyzej. Najczestsze przyczyny: blad vcpkg lub brak pakietu C++ w Visual Studio."
                Step7PromptDone = "Krok 7 (Konfiguracja CMake) zakonczony. Nacisnij Enter, aby rozpoczac kompilacje (Krok 8)..."
                Step8Title      = "--- KROK 8: Kompilacja projektu (Release) ---"
                Step8Desc       = "To ostatni krok, rowniez moze zajac duzo czasu."
                Step8Error      = "Kompilacja NIE POWIODLA SIE. Sprawdz bledy powyzej."
                DoneTitle       = "         KOMPILACJA ZAKONCZONA SUKCESEM!        "
                DonePath        = "Gotowe pliki serwera znajdziesz w:"
                DonePrompt      = "Nacisnij Enter, aby zamknac okno"
            }
        }
        default {
            Write-Warning "Invalid selection. Wybór nieprawidłowy. Seleção inválida."
            Start-Sleep -Seconds 2
        }
    }
}

# --- Branch Configuration ---
# Script uses 'main' branch by default.
$branchName = "main"
Write-Host "Branch set to '$branchName'." -ForegroundColor Cyan


# --- Rozpoczęcie skryptu / Script Start ---

Clear-Host
Write-Host $lang.Title -ForegroundColor Yellow
Write-Host $lang.Description
Write-Host ""

# --- Sprawdzenie Uprawnień Administratora ---
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning $lang.AdminWarning1
    Write-Host $lang.AdminWarning2
    Read-Host -Prompt $lang.PressEnterExit
    exit 1
}

# --- Krok 1: Instalacja GIT ---
Write-Host ""
Write-Host $lang.Step1Title -ForegroundColor Green
if ($null -eq (Get-Command git -ErrorAction SilentlyContinue)) {
    Write-Host "Git $($lang.CheckNotFound)"
    Write-Host $lang.Step1Inst1
    Write-Host $lang.Step1Inst2
    Write-Host $lang.Step1Inst3
    Write-Host ""
    Start-Process "https://git-scm.com/download/win"
    Read-Host -Prompt $lang.Step1Prompt
} else {
    Write-Host "Git $($lang.CheckFound)"
}


# --- Krok 2: Instalacja CMAKE ---
Write-Host ""
Write-Host $lang.Step2Title -ForegroundColor Green
if ($null -eq (Get-Command cmake -ErrorAction SilentlyContinue)) {
    Write-Host "CMake $($lang.CheckNotFound)"
    Write-Host $lang.Step2Inst1
    Write-Host $lang.Step2Inst2
    Write-Host $lang.Step2Inst3
    Write-Host ""
    Start-Process "https://cmake.org/download/"
    Read-Host -Prompt $lang.Step2Prompt
} else {
    Write-Host "CMake $($lang.CheckFound)"
}

# --- Krok 3: Instalacja VISUAL STUDIO 2022 ---
Write-Host ""
Write-Host $lang.Step3Title -ForegroundColor Green
$vsInstallerPath = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vs_installer.exe"
if (-not (Test-Path $vsInstallerPath)) {
    Write-Host "Visual Studio $($lang.CheckNotFound)"
    Write-Host $lang.Step3Inst1
    Write-Host $lang.Step3Inst2
    Write-Host $lang.Step3Inst3
    Write-Host $lang.Step3Inst4
    Write-Host ""
    Start-Process "https://visualstudio.microsoft.com/vs/community/"
    Read-Host -Prompt $lang.Step3Prompt
} else {
    Write-Host "Visual Studio $($lang.CheckFound)"
    Write-Warning $lang.VSWarning
}


# --- Krok 4: Przeładowanie Środowiska (PATH) ---
Write-Host ""
Write-Host $lang.Step4Title -ForegroundColor Green
Write-Host $lang.Step4Desc1
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

try {
    Get-Command git -ErrorAction Stop | Out-Null
    Get-Command cmake -ErrorAction Stop | Out-Null
} catch {
    Write-Error $lang.Step4Error1
    Write-Host $lang.Step4Error2
    Read-Host -Prompt $lang.PressEnterExit
    exit 1
}
Write-Host $lang.Step4Success

# --- Konfiguracja kompilacji ---
$DevRoot = "C:\"

$VcpkgRoot = Join-Path $DevRoot "vcpkg"
$VcpkgToolchainFile = Join-Path $VcpkgRoot "scripts\buildsystems\vcpkg.cmake"
$ProjectRoot = Join-Path $DevRoot "crystalserver"

# --- Krok 5: Konfiguracja vcpkg ---
Write-Host ""
Write-Host $lang.Step5Title -ForegroundColor Green
try {
    if (-not (Test-Path $DevRoot)) {
        Write-Host ($lang.Step5CreateDir -f $DevRoot)
        New-Item -Path $DevRoot -ItemType Directory
    }
    Set-Location $DevRoot

    if (-not (Test-Path $VcpkgRoot)) {
        Write-Host $lang.Step5Clone
        git clone https://github.com/Microsoft/vcpkg.git
        if ($LASTEXITCODE -ne 0) { throw "Git clone vcpkg failed." }
        
        Write-Host $lang.Step5Build
        Set-Location $VcpkgRoot
        ./bootstrap-vcpkg.bat
        if ($LASTEXITCODE -ne 0) { throw "vcpkg bootstrap failed." }
    } else {
        Write-Host $lang.Step5Exists
        Set-Location $VcpkgRoot
    }

    Write-Host $lang.Step5InstallLibs
    ./vcpkg install openssl:x64-windows boost:x64-windows
    if ($LASTEXITCODE -ne 0) { throw "vcpkg install libraries failed." }
    
    Read-Host -Prompt $lang.Step5PromptDone
} catch {
    Write-Error "STEP 5 FAILED: $($_.Exception.Message)"
    Read-Host -Prompt $lang.PressEnterExit
    exit 1
}


# --- Krok 6: Pobranie kodu CrystalServer ---
Write-Host ""
Write-Host $lang.Step6Title -ForegroundColor Green
try {
    Set-Location $DevRoot

    if (-not (Test-Path $ProjectRoot)) {
        Write-Host ($lang.Step6Clone -f $branchName)
        git clone -b $branchName https://github.com/zimbadev/crystalserver.git
        if ($LASTEXITCODE -ne 0) { throw "Git clone crystalserver failed." }
    } else {
        Write-Host $lang.Step6Exists
    }
    
    Read-Host -Prompt $lang.Step6PromptDone
} catch {
    Write-Error "STEP 6 FAILED: $($_.Exception.Message)"
    Read-Host -Prompt $lang.PressEnterExit
    exit 1
}

# --- Krok 7: Konfiguracja CMake ---
Write-Host ""
Write-Host $lang.Step7Title -ForegroundColor Green
try {
    Set-Location $ProjectRoot

    $BuildDir = Join-Path $ProjectRoot "build"
    if (-not (Test-Path $BuildDir)) {
        New-Item -Path $BuildDir -ItemType Directory
    }
    Set-Location $BuildDir

    Write-Host $lang.Step7Config
    cmake .. -G "Visual Studio 17 2022" -A x64 -DCMAKE_TOOLCHAIN_FILE="$($VcpkgToolchainFile)" -DWITH_MYSQL=OFF
    
    if ($LASTEXITCODE -ne 0) {
        throw "CMake configuration failed. Check the errors above."
    }
    
    Write-Host $lang.Step7Success
    Read-Host -Prompt $lang.Step7PromptDone
} catch {
    Write-Error $lang.Step7Error
    Write-Host $lang.Step7ErrorCommon
    Write-Error "DETAILS: $($_.Exception.Message)"
    Read-Host -Prompt $lang.PressEnterExit
    exit 1
}

# --- Krok 8: Kompilacja ---
Write-Host ""
Write-Host $lang.Step8Title -ForegroundColor Green
try {
    Write-Host $lang.Step8Desc
    cmake --build . --config Release
    
    if ($LASTEXITCODE -ne 0) {
        throw "CMake build failed. Check the errors above."
    }

    Write-Host ""
    Write-Host "------------------------------------------------" -ForegroundColor Cyan
    Write-Host $lang.DoneTitle -ForegroundColor Cyan
    Write-Host "------------------------------------------------" -ForegroundColor Cyan
    Write-Host $lang.DonePath
    Write-Host "$BuildDir\bin\Release"
    Write-Host ""
    
} catch {
    Write-Error $lang.Step8Error
    Write-Error "DETAILS: $($_.Exception.Message)"
    Read-Host -Prompt $lang.PressEnterExit
    exit 1
}

Read-Host -Prompt $lang.DonePrompt
function Write-ColoredText {
    param(
        [Parameter(Mandatory=$true)]
        [string]$Text,
        [Parameter()]
        [ConsoleColor]$ForegroundColor = "White",
        [Parameter()]
        [ConsoleColor]$BackgroundColor = "Black"
    )
    $defaultForegroundColor = $Host.UI.RawUI.ForegroundColor
    $defaultBackgroundColor = $Host.UI.RawUI.BackgroundColor

    $Host.UI.RawUI.ForegroundColor = $ForegroundColor
    $Host.UI.RawUI.BackgroundColor = $BackgroundColor

    Write-Host $Text

    $Host.UI.RawUI.ForegroundColor = $defaultForegroundColor
    $Host.UI.RawUI.BackgroundColor = $defaultBackgroundColor
}

Clear-Host

$inSourceDir = ($PWD.Path.EndsWith("Source"))


Write-ColoredText "--------------------------" -ForegroundColor "White"
if (-not ($PWD.Path.EndsWith("Source"))) {
    Set-Location -Path "$PWD\Source"
    if ($?) {

    } else {
        Write-ColoredText "There was a problem changing to the './Source' directory." -ForegroundColor "Red"
        exit 1
    }
}

Remove-Item -Path "CompilationErrors.txt" -ErrorAction SilentlyContinue

$hasCFiles = 0
$hasCppFiles = 0

if (Test-Path -Path "*.c") {
    $hasCFiles = 1
}
if (Test-Path -Path "*.cpp") {
    $hasCppFiles = 1
}

if (Test-Path -Path "Output.exe") {
    Remove-Item -Path "Output.exe" -ErrorAction SilentlyContinue
}

$errorsFile = "CompilationErrors.txt"

if ($hasCFiles -eq 1) {
    Write-ColoredText "Compiling C code..." -ForegroundColor "Yellow"
    $compilationOutput = g++ *.c -o Output 2>&1
    if ($LASTEXITCODE -ne 0) {
        $compilationOutput | Out-File -FilePath $errorsFile
        Write-ColoredText "Compilation errors detected" -ForegroundColor "Red"
        Write-Host $compilationOutput
    } else {
        Write-ColoredText "No compilation errors" -ForegroundColor "Green"
    }
} elseif ($hasCppFiles -eq 1) {
    Write-ColoredText "Compiling C++ code..." -ForegroundColor "Yellow"
    $compilationOutput = g++ *.cpp -o Output 2>&1
    if ($LASTEXITCODE -ne 0) {
        $compilationOutput | Out-File -FilePath $errorsFile
        Write-ColoredText "Compilation errors detected" -ForegroundColor "Red"
        Write-Host $compilationOutput
    } else {
        Write-ColoredText "No compilation errors" -ForegroundColor "Green"
    }
} else {
    Write-ColoredText "No C or C++ files found." -ForegroundColor "Red"
    exit 1
}

if (Test-Path -Path "Output.exe") {
    Write-ColoredText "Running Output.exe..." -ForegroundColor "Blue"
    Write-ColoredText "--------------------------`n" -ForegroundColor "White"
    gdb .\Output.exe
}

if (-not $inSourceDir) {
    Set-Location ..
}

Remove-Item -Path $errorsFile -ErrorAction SilentlyContinue
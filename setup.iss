[Setup]
AppName=Calculator
AppVersion=1.5.3.0
DefaultDirName={tmp}\CalculatorSetup
DisableDirPage=yes
DisableProgramGroupPage=yes
OutputDir=Output
OutputBaseFilename=Calculator_Setup
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin

[Files]
Source: "Calculator.cer"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "*.msix"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Run]
Filename: "certutil.exe"; Parameters: "-addstore ""Root"" ""{tmp}\Calculator.cer"""; Flags: runhidden
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -Command ""Get-ChildItem -Path '{tmp}\*.msix' | ForEach-Object { Add-AppxPackage -Path $_.FullName }"""; Flags: runhidden

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
; 直接讀取根目錄下的 Calculator.cer
Source: "Calculator.cer"; DestDir: "{tmp}"; Flags: deleteafterinstall
; 自動抓取當前目錄下的任何 .msix 檔案
Source: "*.msix"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Run]
; 1. 自動匯入憑證至「受信任的根憑證授權機構」
Filename: "certutil.exe"; Parameters: "-addstore ""Root"" ""{tmp}\Calculator.cer"""; Flags: runhidden

; 2. 自動執行 PowerShell 安裝抓到的 .msix 檔案
Filename: "powershell.exe"; Parameters: "-Command ""Get-ChildItem '{tmp}\*.msix' | ForEach-Object { Add-AppxPackage -Path $_.FullName }"""; Flags: runhidden

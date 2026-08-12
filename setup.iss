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
; 讀取根目錄下的 Calculator.cer
Source: "Calculator.cer"; DestDir: "{tmp}"; Flags: deleteafterinstall
; 自動抓取下載下來的 .msix 檔案
Source: "*.msix"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Run]
; 1. 自動匯入憑證至「受信任的根憑證授權機構」
Filename: "certutil.exe"; Parameters: "-addstore ""Root"" ""{tmp}\Calculator.cer"""; Flags: runhidden

; 2. 自動執行 PowerShell 安裝 .msix（已修正引號轉義問題）
Filename: "powershell.exe"; Parameters: "-ExecutionPolicy Bypass -Command Add-AppxPackage -Path '{tmp}\*.msix'"; Flags: runhidden

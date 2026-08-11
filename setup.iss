[Setup]
AppName=Calculator
AppVersion=1.5.3.0
DefaultDirName={tmp}\CalculatorSetup
DisableDirPage=yes
DisableProgramGroupPage=yes
OutputDir=Output
OutputBaseFilename=Calculator_Setup_v1.5.3.0
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin

[Files]
; 使用通配符，只要目錄下有 .cer 和 .msix 就會自動抓取打包
Source: "*.cer"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "*.msix"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Run]
; 1. 自動匯入憑證至「受信任的根憑證授權機構」
Filename: "certutil.exe"; Parameters: "-addstore ""Root"" ""{tmp}\Calculator.cer"""; Flags: runhidden

; 2. 自動靜默安裝 MSIX 套件（利用 Powershell 抓取 {tmp} 下的 .msix 檔，避免死板檔名）
Filename: "powershell.exe"; Parameters: "-Command ""Get-ChildItem '{tmp}\*.msix' | ForEach-Object { Add-AppxPackage -Path $_.FullName }"""; Flags: runhidden

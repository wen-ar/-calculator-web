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
Source: "Calculator.cer"; DestDir: "{tmp}"; Flags: deleteafterinstall
; 改用 *.msix，這樣不論版號是 1.5.3.0 還是未來的版本都能自動抓取
Source: "*.msix"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Run]
; 1. 自動匯入憑證至「受信任的根憑證授權機構」
Filename: "certutil.exe"; Parameters: "-addstore ""Root"" ""{tmp}\Calculator.cer"""; Flags: runhidden

; 2. 自動尋找 {tmp} 底下的 .msix 並進行安裝
Filename: "powershell.exe"; Parameters: "-Command ""Get-ChildItem '{tmp}\*.msix' | ForEach-Object { Add-AppxPackage -Path $_.FullName }"""; Flags: runhidden

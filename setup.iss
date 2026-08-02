[Setup]
AppName=Calculator
AppVersion=1.5.2.0
DefaultDirName={tmp}\CalculatorSetup
DisableDirPage=yes
DisableProgramGroupPage=yes
OutputBaseFilename=Calculator_Setup_v1.5.2
Compression=lzma
SolidCompression=yes
PrivilegesRequired=admin

[Files]
Source: "Calculator.cer"; DestDir: "{tmp}"; Flags: deleteafterinstall
Source: "Calculator_1.5.2.0_x64.msix"; DestDir: "{tmp}"; Flags: deleteafterinstall

[Run]
; 1. 自動匯入憑證至「受信任的根憑證授權機構」
Filename: "certutil.exe"; Parameters: "-addstore ""Root"" ""{tmp}\Calculator.cer"""; Flags: runhidden

; 2. 自動靜默安裝 MSIX 套件
Filename: "powershell.exe"; Parameters: "-Command ""Add-AppxPackage -Path '{tmp}\Calculator_1.5.2.0_x64.msix'"""; Flags: runhidden

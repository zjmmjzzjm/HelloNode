; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#define MyAppName "Hello Node"
#define MyAppShortName "HelloNode"
#define MyAppVersion "1.0"
#define MyAppPublisher "Hello Node LLC"
#define MyAppURL "http://hurpdurp.com/"
#define NSSM "nssm.exe"
#define NSSM32 "nssm-x86.exe"
#define NSSM64 "nssm.exe"
#define nodemsi "node-v0.10.4-x64.msi"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{BE28CC34-C56B-4B0B-B096-25681B775C9F}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
;DefaultDirName={pf64}\{#MyAppShortName}
; Testing to see if spaces or special characters were the problem
DefaultDirName=C:\{#MyAppShortName}
DisableDirPage=yes
DefaultGroupName={#MyAppShortName}
DisableProgramGroupPage=yes
;LicenseFile=C:\Users\coolaj86\Downloads\LICENSE.txt
;InfoBeforeFile=C:\Users\coolaj86\Downloads\before.txt
;InfoAfterFile=C:\Users\coolaj86\Downloads\after.txt
OutputDir=C:\Users\coolaj86\Desktop
OutputBaseFilename={#MyAppShortName}Installer
;SetupIconFile=C:\Users\coolaj86\Downloads\installer.ico
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Files]
Source: "C:\Users\coolaj86\Downloads\{#MyAppShortName}-master\winstaller\{#nodemsi}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\coolaj86\Downloads\{#MyAppShortName}-master\HelloNode\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Users\coolaj86\Downloads\{#MyAppShortName}-master\winstaller\{#NSSM32}"; DestDir: "{app}"; Flags: ignoreversion
Source: "C:\Users\coolaj86\Downloads\{#MyAppShortName}-master\winstaller\{#NSSM64}"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files


[Run]
; These all run with 'runascurrentuser' (i.e. admin) whereas 'runasoriginaluser' would refer to the logged in user
; Install Node
Filename: "{sys}\msiexec.exe"; Parameters: "/passive /i ""{app}\{#nodemsi}"""; MinVersion: 0.0,5.0;

; Add Firewall Rules
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""Node In"" program=""{pf64}\nodejs\node.exe"" dir=in action=allow enable=yes"; Flags: runhidden; MinVersion: 0,5.0;
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""Node Out"" program=""{pf64}\nodejs\node.exe"" dir=out action=allow enable=yes"; Flags: runhidden; MinVersion: 0,5.0;
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} In"" program=""{app}\bin\daemon\hellonode10.exe"" dir=in action=allow enable=yes"; Flags: runhidden; MinVersion: 0,5.0;
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall add rule name=""{#MyAppName} Out"" program=""{app}\bin\daemon\hellonode10.exe"" dir=out action=allow enable=yes"; Flags: runhidden; MinVersion: 0,5.0;

; Add System Service
;Filename: "{app}\{#NSSM}"; Parameters: "install {#MyAppShortName} ""{pf64}\nodejs\node.exe"" ""{app}\bin\server.js"" ""5566"""; MinVersion: 0.0,5.0;
;Filename: "{sys}\net.exe"; Parameters: "start {#MyAppShortName}"; Flags: runhidden; MinVersion: 0,5.0;
Filename: "{pf64}\nodejs\node.exe"; Parameters: "{app}\bin\windows-service-installer.js install"; MinVersion: 0.0,5.0;


[UninstallRun]
; Removes System Service
;Filename: "{sys}\net.exe"; Parameters: "stop {#MyAppShortName}"; Flags: runhidden; MinVersion: 0,5.0;
;Filename: "{app}\{#NSSM}"; Parameters: "remove {#MyAppShortName} confirm"; MinVersion: 0.0,5.0;
Filename: "{pf64}\nodejs\node.exe"; Parameters: "{app}\bin\windows-service-installer.js remove"; MinVersion: 0.0,5.0;

; Remove Firewall Rules
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""Node In"" program=""{pf32}\nodejs\node.exe"""; Flags: runhidden; MinVersion: 0,5.0;
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""Node Out"" program=""{pf32}\nodejs\node.exe"""; Flags: runhidden; MinVersion: 0,5.0;
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""{#MyAppName} In"" program=""{pf64}\nodejs\node.exe"""; Flags: runhidden; MinVersion: 0,5.0;
Filename: "{sys}\netsh.exe"; Parameters: "advfirewall firewall delete rule name=""{#MyAppName} Out"" program=""{pf64}\nodejs\node.exe"""; Flags: runhidden; MinVersion: 0,5.0;

; Uninstall Node
Filename: "{sys}\msiexec.exe"; Parameters: "/passive /x ""{app}\{#nodemsi}"""; MinVersion: 0.0,5.0;
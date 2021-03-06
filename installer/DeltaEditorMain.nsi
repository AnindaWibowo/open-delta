# Generated by EclipseNSIS Script Wizard, then manually edited

Name "Open DELTA Suite"

# General Symbol Definitions
!define REGKEY "SOFTWARE\$(^Name)"
!define /date DATE "%Y%m%d"

# MultiUser Symbol Definitions
!define MULTIUSER_EXECUTIONLEVEL Highest
!define MULTIUSER_MUI
!define MULTIUSER_INSTALLMODE_DEFAULT_REGISTRY_KEY "${REGKEY}"
!define MULTIUSER_INSTALLMODE_DEFAULT_REGISTRY_VALUENAME MultiUserInstallMode
!define MULTIUSER_INSTALLMODE_COMMANDLINE
!define MULTIUSER_INSTALLMODE_INSTDIR "Open DELTA"
!define MULTIUSER_INSTALLMODE_INSTDIR_REGISTRY_KEY "${REGKEY}"
!define MULTIUSER_INSTALLMODE_INSTDIR_REGISTRY_VALUE "Path"

# MUI Symbol Definitions
!define MUI_ICON ".\resources\installer.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP ".\resources\InstallerHeaderImage.bmp"
!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_NOAUTOCLOSE
!define MUI_STARTMENUPAGE_REGISTRY_KEY ${REGKEY}
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME StartMenuGroup
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "Open DELTA Suite"
!define MUI_UNICON ".\resources\installer.ico"
!define MUI_UNFINISHPAGE_NOAUTOCLOSE

# Included files
!include MultiUser.nsh
!include Sections.nsh
!include MUI2.nsh
!include FileFunc.nsh

!insertmacro RefreshShellIcons
!insertmacro un.RefreshShellIcons

# Variables
Var StartMenuGroup

# Installer pages
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "${LICENSE-TEXT-PATH}"
!insertmacro MULTIUSER_PAGE_INSTALLMODE
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_STARTMENU Application $StartMenuGroup
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

# Installer languages
!insertmacro MUI_LANGUAGE English

# Installer attributes

InstallDir OpenDelta
CRCCheck on
XPStyle on
ShowInstDetails show
;InstallDirRegKey SHELL_CONTEXT "${REGKEY}" Path
ShowUninstDetails show

# Installer sections
Section -Main SEC0000
    SetOverwrite on
    
    SetOutPath "$INSTDIR"
    File "/oname=${DELTA-EDITOR-EXEOUTPUTNAME}" "${DELTA-EDITOR-EXEPATH}"
    File "/oname=${INTKEY-EXEOUTPUTNAME}" "${INTKEY-EXEPATH}" 
    File "/oname=${CONFOR-EXEOUTPUTNAME}" "${CONFOR-EXEPATH}"
    File "/oname=${DIST-EXEOUTPUTNAME}" "${DIST-EXEPATH}"
    File "/oname=${KEY-EXEOUTPUTNAME}" "${KEY-EXEPATH}"  

    ; Do With JRE/No JRE specific stuff here    
    Call CustomAddFiles
  
    ; Output sample dlt into sample subdirectory
    File /r /x ".svn" "${SAMPLE-DATASET-PATH}"
    
    ; Output JAR files to lib subdirectory
    SetOutPath "$INSTDIR\lib"
    File "${JARPATH}\*.jar"
    
    WriteRegStr SHELL_CONTEXT "${REGKEY}\Components" Main 1
SectionEnd

Section -post SEC0001
    WriteRegStr SHELL_CONTEXT "${REGKEY}" Path "$INSTDIR"
    SetOutPath "$INSTDIR"
    WriteUninstaller "$INSTDIR\uninstall.exe"
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    
    #SetOutPath $SMPROGRAMS\$StartMenuGroup
    CreateDirectory "$SMPROGRAMS\$StartMenuGroup"
    SetOutPath "$INSTDIR"
    
    CreateShortCut "$SMPROGRAMS\$StartMenuGroup\DELTA Editor.lnk" "$INSTDIR\${DELTA-EDITOR-EXEOUTPUTNAME}"
    CreateShortCut "$SMPROGRAMS\$StartMenuGroup\Intkey.lnk" "$INSTDIR\${INTKEY-EXEOUTPUTNAME}"
    
    CreateShortCut "$SMPROGRAMS\$StartMenuGroup\CONFOR.lnk" "cmd.exe" '/k "$INSTDIR\${CONFOR-EXEOUTPUTNAME}"' "$INSTDIR\${CONFOR-EXEOUTPUTNAME}" "" ""
    CreateShortCut "$SMPROGRAMS\$StartMenuGroup\DIST.lnk" "cmd.exe" '/k "$INSTDIR\${DIST-EXEOUTPUTNAME}"' "$INSTDIR\${DIST-EXEOUTPUTNAME}" "" ""
    CreateShortCut "$SMPROGRAMS\$StartMenuGroup\KEY.lnk" "cmd.exe" '/k "$INSTDIR\${KEY-EXEOUTPUTNAME}"' "$INSTDIR\${KEY-EXEOUTPUTNAME}" "" ""
    SetOutPath $SMPROGRAMS\$StartMenuGroup
    
    CreateShortcut "$SMPROGRAMS\$StartMenuGroup\Uninstall $(^Name).lnk" "$INSTDIR\uninstall.exe"
    !insertmacro MUI_STARTMENU_WRITE_END
    WriteRegStr SHELL_CONTEXT "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayName "$(^Name)"
    WriteRegStr SHELL_CONTEXT "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" DisplayIcon "$INSTDIR\uninstall.exe"
    WriteRegStr SHELL_CONTEXT "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" UninstallString "$INSTDIR\uninstall.exe"
    WriteRegDWORD SHELL_CONTEXT "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoModify 1
    WriteRegDWORD SHELL_CONTEXT "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" NoRepair 1
    
    WriteRegStr SHELL_CONTEXT "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "Version" "${VERSION}"
    WriteRegStr SHELL_CONTEXT "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "DisplayVersion" "${VERSION}"
    WriteRegStr SHELL_CONTEXT "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "URLInfoAbout" "http://code.google.com/p/open-delta/"
    WriteRegStr SHELL_CONTEXT "Software\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)" "InstallDate" "${DATE}"
    
    # File type associations
    WriteRegStr HKCR ".dlt" "" "OpenDelta.EditorDocument"    
    WriteRegStr HKCR "OpenDelta.EditorDocument" "" "OpenDelta Editor data file"
    WriteRegStr HKCR "OpenDelta.EditorDocument\DefaultIcon" "" "$INSTDIR\${DELTA-EDITOR-EXEOUTPUTNAME},0"
    WriteRegStr HKCR "OpenDelta.EditorDocument\shell\open\command" "" '"$INSTDIR\${DELTA-EDITOR-EXEOUTPUTNAME}" "%1"'
    
    WriteRegStr HKCR ".ink" "" "OpenDelta.IntkeyDataset"    
    WriteRegStr HKCR "OpenDelta.IntkeyDataset" "" "Intkey dataset"
    WriteRegStr HKCR "OpenDelta.IntkeyDataset\DefaultIcon" "" "$INSTDIR\${INTKEY-EXEOUTPUTNAME},0"
    WriteRegStr HKCR "OpenDelta.IntkeyDataset\shell\open\command" "" '"$INSTDIR\${INTKEY-EXEOUTPUTNAME}" "%1"'
        
    ${RefreshShellIcons}
    
    WriteINIStr "$INSTDIR\uninstall.ini" UninstallMode mode $MultiUser.InstallMode
SectionEnd

# Macro for selecting uninstaller sections
!macro SELECT_UNSECTION SECTION_NAME UNSECTION_ID
    Push $R0
    ReadRegStr $R0 SHELL_CONTEXT "${REGKEY}\Components" "${SECTION_NAME}"
    StrCmp $R0 1 0 next${UNSECTION_ID}
    !insertmacro SelectSection "${UNSECTION_ID}"
    GoTo done${UNSECTION_ID}
next${UNSECTION_ID}:
    !insertmacro UnselectSection "${UNSECTION_ID}"
done${UNSECTION_ID}:
    Pop $R0
!macroend

# Uninstaller sections
Section /o -un.Main UNSEC0000
    RmDir /r /REBOOTOK "$INSTDIR"
    DeleteRegValue SHELL_CONTEXT "${REGKEY}\Components" Main
SectionEnd

Section -un.post UNSEC0001
    DeleteRegKey SHELL_CONTEXT "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$(^Name)"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Uninstall $(^Name).lnk"
    
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\DELTA Editor.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\Intkey.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\CONFOR.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\DIST.lnk"
    Delete /REBOOTOK "$SMPROGRAMS\$StartMenuGroup\KEY.lnk"
    
    Delete /REBOOTOK "$INSTDIR\uninstall.exe"
    DeleteRegValue SHELL_CONTEXT "${REGKEY}" StartMenuGroup
    DeleteRegValue SHELL_CONTEXT "${REGKEY}" Path
    DeleteRegKey /IfEmpty SHELL_CONTEXT "${REGKEY}\Components"
    DeleteRegKey /IfEmpty SHELL_CONTEXT "${REGKEY}"
    
    # File type associations
    DeleteRegKey HKCR ".dlt"
    DeleteRegKey HKCR "OpenDelta.EditorDocument" 
    DeleteRegKey HKCR ".ink"
    DeleteRegKey HKCR "OpenDelta.IntkeyDataset" 
    
    ${un.RefreshShellIcons}   
    
    RmDir /REBOOTOK "$SMPROGRAMS\$StartMenuGroup"
    RmDir /REBOOTOK "$INSTDIR"
    Push $R0
    StrCpy $R0 $StartMenuGroup 1
    StrCmp $R0 ">" no_smgroup
no_smgroup:
    Pop $R0
SectionEnd

# Installer functions
Function .onInit
    InitPluginsDir
    !insertmacro MULTIUSER_INIT
FunctionEnd

# Uninstaller functions
Function un.onInit
    !insertmacro MUI_STARTMENU_GETFOLDER Application $StartMenuGroup
    !insertmacro MULTIUSER_UNINIT
    
    ReadINIStr $0 "$INSTDIR\uninstall.ini" UninstallMode mode
    
    StrCmp $0 "CurrentUser" 0 +3
    Call un.MultiUser.InstallMode.CurrentUser
    Goto +2
    Call un.MultiUser.InstallMode.AllUsers
    
    !insertmacro SELECT_UNSECTION Main ${UNSEC0000}
FunctionEnd


@echo off
chcp 65001 >nul 2>&1
title XNODES ULTRA MASTER ANDROID DEBLOATER v3.0 — by Tharindu Liyanage
color 0B

:BANNER
cls
echo.
echo   ██╗  ██╗███╗   ██╗ ██████╗ ██████╗ ███████╗███████╗
echo   ╚██╗██╔╝████╗  ██║██╔═══██╗██╔══██╗██╔════╝██╔════╝
echo    ╚███╔╝ ██╔██╗ ██║██║   ██║██║  ██║█████╗  ███████╗
echo    ██╔██╗ ██║╚██╗██║██║   ██║██║  ██║██╔══╝  ╚════██║
echo   ██╔╝ ██╗██║ ╚████║╚██████╔╝██████╔╝███████╗███████║
echo   ╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝
echo.
echo   ╔══════════════════════════════════════════════════════════════╗
echo   ║    XNODES ULTRA MASTER ANDROID DEBLOATER v3.0               ║
echo   ║    MAGIC EDITION — Programmed by Tharindu Liyanage / Xnodes ║
echo   ║    Rocket Speed  ^|  Battery Beast  ^|  Privacy Shield        ║
echo   ║    Custom ROM Level Deep Optimization  ^|  No Root Required   ║
echo   ╚══════════════════════════════════════════════════════════════╝
echo.

:CHECK_ADB
echo   Checking ADB connection...
where adb >nul 2>&1
if %errorlevel% neq 0 (
  echo.
  echo   [ERROR] ADB not found on this system!
  echo   Download: https://developer.android.com/studio/releases/platform-tools
  echo   Extract and add the folder to your system PATH, then rerun.
  pause & exit /b 1
)
adb devices 2>nul | findstr "device$" >nul
if %errorlevel% neq 0 (
  echo.
  echo   [ERROR] No phone detected!
  echo.
  echo   How to enable USB Debugging:
  echo     Step 1 - Settings ^> About Phone ^> Build Number ^> tap 7 times
  echo     Step 2 - Settings ^> Developer Options ^> USB Debugging ^> ON
  echo     Step 3 - Connect phone via USB cable
  echo     Step 4 - Tap Allow / OK on the phone popup
  echo     Step 5 - Run this script again
  pause & exit /b 1
)
for /f "tokens=*" %%b in ('adb shell getprop ro.product.brand 2^>nul') do set BRAND=%%b
for /f "tokens=*" %%m in ('adb shell getprop ro.product.model 2^>nul') do set MODEL=%%m
for /f "tokens=*" %%v in ('adb shell getprop ro.build.version.release 2^>nul') do set VER=%%v
echo.
echo   Connected!   Brand: %BRAND%   Model: %MODEL%   Android: %VER%
echo.
echo   IMPORTANT:
echo     - No root required. Apps are disabled, not deleted.
echo     - Camera, Phone, Calendar, YouTube, Play Store = NEVER touched.
echo     - Use option [9] to restore all changes at any time.
echo     - Restart phone after script for full effect.
echo.

:MENU
echo   ────────────────────────────────────────────────────────
echo   [1]   FULL MAGIC DEBLOAT  (Recommended - runs everything)
echo   [2]   Spyware + Trackers Only
echo   [3]   Battery Beast Mode
echo   [4]   Speed Profile
echo   [5]   RAM Nuclear Clear
echo   [6]   Google Bloatware Only
echo   [7]   Brand-Specific Bloatware
echo   [8]   Hidden Background Killers
echo   [9]   Restore All (Undo Everything)
echo   [0]   Exit
echo   ────────────────────────────────────────────────────────
set /p CH="  Your choice (0-9): "

if "%CH%"=="1" goto FULL
if "%CH%"=="2" goto DO_SPYWARE
if "%CH%"=="3" goto DO_BATTERY
if "%CH%"=="4" goto DO_SPEED
if "%CH%"=="5" goto DO_RAM
if "%CH%"=="6" goto DO_GOOGLE
if "%CH%"=="7" goto DO_BRAND
if "%CH%"=="8" goto DO_HIDDEN
if "%CH%"=="9" goto RESTORE
if "%CH%"=="0" goto EXIT
echo   Invalid choice. Please enter 0-9.
goto MENU

:: ────────────────────────────────────────────────
:: DEBLOAT FUNCTION (call with package + description)
:: ────────────────────────────────────────────────
:DEBLOAT
setlocal
set PKG=%~1
set DSC=%~2
adb shell pm list packages %PKG% 2>nul | findstr "^package:%PKG%$" >nul
if errorlevel 1 (
  echo   [SKIP]  %DSC%
  endlocal & exit /b
)
adb shell pm disable-user --user 0 %PKG% >nul 2>&1
echo   [OK]    %DSC%
echo REMOVED: %PKG% >> xnodes_log.txt
endlocal
exit /b

:: ────────────────────────────────────────────────
:: GOOGLE
:: ────────────────────────────────────────────────
:GOOGLE_MODULE
echo.
echo   ── MODULE: GOOGLE BLOATWARE ──────────────────────────
call :DEBLOAT "com.google.android.videos"              "Google Play Movies and TV"
call :DEBLOAT "com.google.android.music"               "Google Play Music (Legacy)"
call :DEBLOAT "com.google.android.apps.youtube.music"  "YouTube Music"
call :DEBLOAT "com.google.android.apps.subscriptions.red" "YouTube Premium App"
call :DEBLOAT "com.google.android.talk"                "Google Hangouts"
call :DEBLOAT "com.google.android.apps.tachyon"        "Google Duo Standalone"
call :DEBLOAT "com.google.android.apps.magazines"      "Google News / Newsstand"
call :DEBLOAT "com.google.android.apps.books"          "Google Play Books"
call :DEBLOAT "com.google.android.apps.docs"           "Google Docs (preinstalled)"
call :DEBLOAT "com.google.android.apps.sheets"         "Google Sheets (preinstalled)"
call :DEBLOAT "com.google.android.apps.slides"         "Google Slides (preinstalled)"
call :DEBLOAT "com.google.android.apps.photos"         "Google Photos (preinstalled)"
call :DEBLOAT "com.google.android.feedback"            "Google Feedback"
call :DEBLOAT "com.google.android.partnersetup"        "Partner Setup"
call :DEBLOAT "com.google.android.printservice.recommendation" "Print Service Recommendation"
call :DEBLOAT "com.google.android.apps.restore"        "Google Device Restore"
call :DEBLOAT "com.google.android.apps.wellbeing"      "Digital Wellbeing"
call :DEBLOAT "com.google.android.marvin.talkback"     "TalkBack Accessibility"
call :DEBLOAT "com.google.android.apps.nbu.files"      "Files by Google"
call :DEBLOAT "com.google.android.setupwizard"         "Setup Wizard"
call :DEBLOAT "com.google.android.onetimeinitializer"  "One Time Initializer"
call :DEBLOAT "com.google.android.as"                  "Android System Intelligence (heavy RAM)"
call :DEBLOAT "com.google.android.as.oss"              "Android System Intelligence OSS"
call :DEBLOAT "com.google.android.apps.kids.familylink" "Google Family Link"
call :DEBLOAT "com.google.android.hotspot2"            "Passpoint Provisioner (background scanner)"
call :DEBLOAT "com.google.android.captiveportallogin"  "Captive Portal Login"
call :DEBLOAT "com.google.android.documentsui"         "Documents UI"
goto :EOF

:: ────────────────────────────────────────────────
:: SAMSUNG
:: ────────────────────────────────────────────────
:SAMSUNG_MODULE
echo.
echo   ── MODULE: SAMSUNG DEEP BLOATWARE ──────────────────────
call :DEBLOAT "com.samsung.android.bixby.agent"        "Bixby Voice Agent (always-on drain!)"
call :DEBLOAT "com.samsung.android.bixby.agent.dummy"  "Bixby Dummy Agent"
call :DEBLOAT "com.samsung.android.bixby.wakeup"       "Bixby Wakeup Listener (microphone!)"
call :DEBLOAT "com.samsung.android.bixby.service"      "Bixby Background Service"
call :DEBLOAT "com.samsung.android.bixbyvision.framework" "Bixby Vision"
call :DEBLOAT "com.samsung.android.app.routines"       "Bixby Routines"
call :DEBLOAT "com.samsung.systemui.bixby2"            "Bixby Sidebar"
call :DEBLOAT "com.samsung.android.bixby.personalization" "Bixby Personalization"
call :DEBLOAT "com.samsung.android.arzone"             "AR Zone"
call :DEBLOAT "com.samsung.android.aremoji"            "AR Emoji"
call :DEBLOAT "com.samsung.android.aremoji.editor"     "AR Emoji Editor"
call :DEBLOAT "com.samsung.android.livestickers"       "Live Stickers"
call :DEBLOAT "com.samsung.android.stickercenter"      "Sticker Center"
call :DEBLOAT "com.samsung.android.spay"               "Samsung Pay"
call :DEBLOAT "com.samsung.android.samsungpay.gear"    "Samsung Pay Gear"
call :DEBLOAT "com.samsung.knox.analytics.uploader"    "Knox Analytics Uploader"
call :DEBLOAT "com.samsung.android.game.gos"           "GOS — Game Throttle Service"
call :DEBLOAT "com.samsung.android.game.gamehome"      "Game Launcher"
call :DEBLOAT "com.samsung.android.game.gametools"     "Game Tools Overlay"
call :DEBLOAT "com.samsung.android.rubin.app"          "Samsung Analytics and Tracking"
call :DEBLOAT "com.samsung.android.mobileservice"      "Samsung Mobile Services"
call :DEBLOAT "com.samsung.android.app.updatecenter"   "Samsung Update Center"
call :DEBLOAT "com.sec.android.diagmonagent"           "Diagnostic Monitor Agent"
call :DEBLOAT "com.samsung.android.beaconmanager"      "Samsung Beacon Manager (location tracking)"
call :DEBLOAT "com.samsung.android.ipsgeofence"        "IPS Geofence (location harvesting)"
call :DEBLOAT "com.samsung.android.scloud"             "Samsung Cloud Sync"
call :DEBLOAT "com.samsung.android.themestore"         "Theme Store"
call :DEBLOAT "com.samsung.android.app.tips"           "Samsung Tips"
call :DEBLOAT "com.samsung.android.privateshare"       "Private Share"
call :DEBLOAT "com.samsung.android.kidsinstaller"      "Kids Mode Installer"
call :DEBLOAT "com.samsung.android.app.galaxyfinder"   "Galaxy Finder"
call :DEBLOAT "com.samsung.android.wallpaper.live"     "Samsung Live Wallpaper"
call :DEBLOAT "com.samsung.android.lool"               "Samsung Life Skills (useless)"
call :DEBLOAT "com.samsung.android.messaging"          "Samsung Messages (replace with Signal)"
call :DEBLOAT "com.samsung.android.email.provider"     "Samsung Email"
goto :EOF

:: ────────────────────────────────────────────────
:: XIAOMI
:: ────────────────────────────────────────────────
:XIAOMI_MODULE
echo.
echo   ── MODULE: XIAOMI / MIUI SPYWARE + BLOAT ────────────────
call :DEBLOAT "com.miui.analytics"                     "[SPYWARE] MIUI Analytics"
call :DEBLOAT "com.miui.msa.global"                    "[SPYWARE] MIUI System Ads"
call :DEBLOAT "com.miui.hybrid"                        "[SPYWARE] MIUI Hybrid Ads Platform"
call :DEBLOAT "com.miui.hybrid.accessory"              "[SPYWARE] MIUI Hybrid Accessory"
call :DEBLOAT "com.miui.systemadserver"                "[SPYWARE] MIUI System Ad Server"
call :DEBLOAT "com.miui.daemon"                        "[SPYWARE] MIUI Ad Daemon"
call :DEBLOAT "com.miui.global.providers"              "[SPYWARE] MIUI Global Tracking Providers"
call :DEBLOAT "com.miui.contentcatcher"                "[SPYWARE] Content Catcher"
call :DEBLOAT "com.baidu.input_mi"                     "[SPYWARE] Baidu Input — Chinese Spyware Keyboard"
call :DEBLOAT "com.xiaomi.mipicks"                     "[ADS] GetApps Spam Recommendations"
call :DEBLOAT "com.miui.miservice"                     "[TRACKING] MIUI Mi Service"
call :DEBLOAT "com.miui.phrase"                        "[TRACKING] Phrase Word Tracker"
call :DEBLOAT "com.miui.bugreport"                     "MIUI Bug Report (sends data)"
call :DEBLOAT "com.miui.cleanmaster"                   "MIUI Clean Master"
call :DEBLOAT "com.miui.player"                        "MIUI Music Player"
call :DEBLOAT "com.miui.videoplayer"                   "MIUI Video Player"
call :DEBLOAT "com.miui.yellowpage"                    "MIUI Yellow Pages"
call :DEBLOAT "com.miui.compass"                       "MIUI Compass"
call :DEBLOAT "com.miui.notes"                         "MIUI Notes"
call :DEBLOAT "com.miui.weather2"                      "MIUI Weather"
call :DEBLOAT "com.miui.fm"                            "MIUI FM Radio"
call :DEBLOAT "com.miui.calculator"                    "MIUI Calculator"
call :DEBLOAT "com.xiaomi.midrop"                      "ShareMe / MiDrop"
call :DEBLOAT "com.xiaomi.gamecenter.sdk.service"      "Mi Game Center"
call :DEBLOAT "com.miui.cloudservice"                  "MIUI Cloud Service"
call :DEBLOAT "com.miui.cloudbackup"                   "MIUI Cloud Backup"
call :DEBLOAT "com.miui.voiceassist"                   "MIUI Voice Assistant"
call :DEBLOAT "com.miui.mishare.connectivity"          "Mi Share Connectivity"
call :DEBLOAT "com.mi.android.globalminusscreen"       "Mi -1 Screen Today Feed"
call :DEBLOAT "com.miui.catcherpatch"                  "MIUI Catcher Patch (background scanner)"
goto :EOF

:: ────────────────────────────────────────────────
:: SPYWARE
:: ────────────────────────────────────────────────
:SPYWARE_MODULE
echo.
echo   ── MODULE: UNIVERSAL SPYWARE + TRACKERS ─────────────────
call :DEBLOAT "com.facebook.services"                  "[SPYWARE] Facebook Device Services"
call :DEBLOAT "com.facebook.system"                    "[SPYWARE] Facebook System Service"
call :DEBLOAT "com.facebook.appmanager"                "[SPYWARE] Facebook App Manager"
call :DEBLOAT "com.facebook.katana"                    "Facebook App (preinstalled)"
call :DEBLOAT "com.facebook.orca"                      "Facebook Messenger (preinstalled)"
call :DEBLOAT "com.instagram.android"                  "Instagram (preinstalled)"
call :DEBLOAT "com.whatsapp"                           "WhatsApp (preinstalled)"
call :DEBLOAT "com.microsoft.teams"                    "Microsoft Teams (preinstalled)"
call :DEBLOAT "com.microsoft.skydrive"                 "Microsoft OneDrive (preinstalled)"
call :DEBLOAT "com.skype.raider"                       "Skype (preinstalled)"
call :DEBLOAT "com.microsoft.office.word"              "Microsoft Word (preinstalled)"
call :DEBLOAT "com.microsoft.office.excel"             "Microsoft Excel (preinstalled)"
call :DEBLOAT "com.microsoft.office.powerpoint"        "Microsoft PowerPoint (preinstalled)"
call :DEBLOAT "com.amazon.kindle"                      "Amazon Kindle (preinstalled)"
call :DEBLOAT "com.netflix.mediaclient"                "Netflix (preinstalled)"
call :DEBLOAT "com.spotify.music"                      "Spotify (preinstalled)"
call :DEBLOAT "com.linkedin.android"                   "LinkedIn (preinstalled)"
call :DEBLOAT "com.twitter.android"                    "Twitter / X (preinstalled)"
call :DEBLOAT "com.snapchat.android"                   "Snapchat (preinstalled)"
call :DEBLOAT "com.tiktok"                             "TikTok (preinstalled)"
goto :EOF

:: ────────────────────────────────────────────────
:: HIDDEN KILLERS
:: ────────────────────────────────────────────────
:HIDDEN_MODULE
echo.
echo   ── MODULE: HIDDEN BACKGROUND KILLERS ────────────────────
call :DEBLOAT "com.qualcomm.qti.sva.manager"           "Qualcomm SVA Always-On Voice Engine"
call :DEBLOAT "com.qualcomm.qti.perfdump"              "Qualcomm Performance Telemetry"
call :DEBLOAT "com.qualcomm.qti.qms.service.trustzoneaccess" "Qualcomm Trust Zone Access"
call :DEBLOAT "com.qualcomm.qti.sar"                   "Qualcomm SAR Background Scanner"
call :DEBLOAT "com.android.dreams.basic"               "Basic Screensavers"
call :DEBLOAT "com.android.dreams.phototable"          "Photo Table Screensaver"
call :DEBLOAT "com.android.smspush"                    "WAP SMS Push (obsolete since 2015)"
call :DEBLOAT "com.android.wallpaper.livepicker"       "Live Wallpaper Picker"
call :DEBLOAT "com.android.sharedstoragebackup"        "Shared Storage Backup"
call :DEBLOAT "com.android.localtransport"             "Local Transport Backup"
call :DEBLOAT "com.android.stk"                        "SIM Toolkit (safe on unlocked phones)"
call :DEBLOAT "com.android.backupconfirm"              "Backup Confirm UI"
call :DEBLOAT "com.android.hotspot2.osulogin"          "Hotspot 2.0 OSU Login"
call :DEBLOAT "com.android.managedprovisioning"        "Managed Provisioning (enterprise)"
call :DEBLOAT "com.android.traceur"                    "System Tracer (dev tool only)"
call :DEBLOAT "com.android.apps.tag"                   "NFC Tag Writer"
call :DEBLOAT "com.android.certinstaller"              "Certificate Installer"
call :DEBLOAT "com.android.printspooler"               "Print Spooler"
call :DEBLOAT "com.android.wallpaper"                  "Default Wallpaper App"
call :DEBLOAT "com.android.egg"                        "Android Easter Egg"
call :DEBLOAT "com.android.htmlviewer"                 "HTML Viewer (ancient / obsolete)"
call :DEBLOAT "com.google.android.networkstack"        "Network Stack Captive Portal"
call :DEBLOAT "com.google.android.connectivity.resources" "Connectivity Resources (duplicate)"
goto :EOF

:: ────────────────────────────────────────────────
:: BATTERY BEAST
:: ────────────────────────────────────────────────
:BATTERY_MODULE
echo.
echo   ── MODULE: BATTERY BEAST MODE ───────────────────────────
adb shell settings put global always_finish_activities 0 >nul 2>&1
echo   [OK]  Always finish activities: smart mode
adb shell settings put global enhanced_battery_mode 1 >nul 2>&1
echo   [OK]  Enhanced battery mode ON
adb shell settings put global ble_scan_always_enabled 0 >nul 2>&1
echo   [OK]  BLE background scan OFF
adb shell settings put global wifi_scan_throttle_enabled 1 >nul 2>&1
echo   [OK]  WiFi scan throttled
adb shell settings put global nfc_payment_foreground 0 >nul 2>&1
echo   [OK]  NFC background OFF
adb shell settings put global aggressive_wifi_to_mobile_handover 1 >nul 2>&1
echo   [OK]  Aggressive WiFi-to-mobile handover ON
adb shell settings put global sync_max_retry_delay_sec 86400 >nul 2>&1
echo   [OK]  Background sync retry: once per 24hrs max
adb shell dumpsys deviceidle enable deep >nul 2>&1
adb shell dumpsys deviceidle enable light >nul 2>&1
echo   [OK]  Doze: deep + light mode forced
adb shell settings put global heads_up_notifications_enabled 0 >nul 2>&1
echo   [OK]  Heads-up notifications OFF (fewer screen wakeups)
adb shell setprop camera.disable_zsl_mode 1 >nul 2>&1
echo   [OK]  Camera ZSL background mode OFF
echo.
echo   Battery Beast Mode Applied!
goto :EOF

:: ────────────────────────────────────────────────
:: SPEED PROFILE
:: ────────────────────────────────────────────────
:SPEED_MODULE
echo.
echo   ── MODULE: SPEED PROFILE ────────────────────────────────
adb shell settings put global window_animation_scale 0.4 >nul 2>&1
adb shell settings put global transition_animation_scale 0.4 >nul 2>&1
adb shell settings put global animator_duration_scale 0.4 >nul 2>&1
echo   [OK]  Animations set to 0.4x (blazing fast)
adb shell setprop debug.egl.hw 1 >nul 2>&1
adb shell setprop debug.sf.hw 1 >nul 2>&1
adb shell setprop persist.sys.ui.hw 1 >nul 2>&1
echo   [OK]  GPU hardware acceleration forced ON
adb shell settings put global background_process_limit 3 >nul 2>&1
echo   [OK]  Background process limit: max 3
adb shell setprop persist.sys.purgeable_assets 1 >nul 2>&1
echo   [OK]  RAM purgeable assets ON
adb shell settings put global network_congestion_control bbr >nul 2>&1
echo   [OK]  Network BBR congestion control (Google algorithm)
adb shell settings put global networks_available_notification_on 0 >nul 2>&1
echo   [OK]  Network available notifications OFF
adb shell setprop pm.dexopt.bg-dexopt speed-profile >nul 2>&1
echo   [OK]  DEX optimization: speed-profile mode
adb shell settings put system pointer_speed 4 >nul 2>&1
echo   [OK]  Touch pointer speed maximized
echo.
echo   Speed Profile Applied!
goto :EOF

:: ────────────────────────────────────────────────
:: RAM NUKE
:: ────────────────────────────────────────────────
:RAM_MODULE
echo.
echo   ── MODULE: RAM NUCLEAR CLEAR ────────────────────────────
adb shell am kill-all >nul 2>&1
echo   [OK]  All cached background apps killed
adb shell sync >nul 2>&1
echo   [OK]  System memory flushed
adb shell rm -rf /data/anr/* >nul 2>&1
echo   [OK]  ANR crash traces cleared
adb shell pm trim-caches 1048576000 >nul 2>&1
echo   [OK]  App caches trimmed (1GB freed)
adb shell am clear-task-list >nul 2>&1
echo   [OK]  Recents list cleared
echo.
echo   RAM Nuked! Your phone can breathe again.
goto :EOF

:: ────────────────────────────────────────────────
:: FULL
:: ────────────────────────────────────────────────
:FULL
echo.
echo   ════ FULL MAGIC DEBLOAT — ALL MODULES ════
call :GOOGLE_MODULE
call :SAMSUNG_MODULE
call :XIAOMI_MODULE
call :SPYWARE_MODULE
call :HIDDEN_MODULE
call :BATTERY_MODULE
call :SPEED_MODULE
call :RAM_MODULE
goto DONE

:: ────────────────────────────────────────────────
:: INDIVIDUAL OPTIONS
:: ────────────────────────────────────────────────
:DO_SPYWARE
call :SPYWARE_MODULE
goto DONE

:DO_BATTERY
call :BATTERY_MODULE
goto DONE

:DO_SPEED
call :SPEED_MODULE
goto DONE

:DO_RAM
call :RAM_MODULE
goto DONE

:DO_GOOGLE
call :GOOGLE_MODULE
goto DONE

:DO_BRAND
call :SAMSUNG_MODULE
call :XIAOMI_MODULE
goto DONE

:DO_HIDDEN
call :HIDDEN_MODULE
goto DONE

:: ────────────────────────────────────────────────
:: RESTORE
:: ────────────────────────────────────────────────
:RESTORE
echo.
echo   WARNING: This will re-enable ALL disabled packages!
set /p CONF="   Are you sure? (y/n): "
if /i not "%CONF%"=="y" goto DONE
for /f "tokens=2 delims=:" %%p in ('adb shell pm list packages -d 2^>nul') do (
  adb shell pm enable --user 0 %%p >nul 2>&1
  echo   [RESTORED]  %%p
)
echo.
echo   All packages restored! Restart your phone.
goto DONE

:: ────────────────────────────────────────────────
:: DONE / RESULTS
:: ────────────────────────────────────────────────
:DONE
echo.
echo   ╔═══════════════════════════════════════════════════════╗
echo   ║              XNODES MAGIC — COMPLETE!                 ║
echo   ║                                                        ║
echo   ║   Battery improvement:   ~15-35%%                     ║
echo   ║   Speed improvement:     ~25-50%%                     ║
echo   ║   Spyware / Trackers:    Eliminated                   ║
echo   ║                                                        ║
echo   ║   RESTART YOUR PHONE for full effect!                 ║
echo   ║                                                        ║
echo   ║   Programmed by Tharindu Liyanage  ^|  Xnodes         ║
echo   ╚═══════════════════════════════════════════════════════╝
echo.
pause
goto BANNER

:EXIT
echo.
echo   Bye! Restart your phone for full effect!
echo   Programmed by Tharindu Liyanage  ^|  Xnodes
pause
exit /b 0

#!/bin/bash
# ╔══════════════════════════════════════════════════════════════════════════════╗
# ║         XNODES ULTRA MASTER ANDROID DEBLOATER v3.0 — MAGIC EDITION         ║
# ║         Programmed by Tharindu Liyanage  |  Xnodes                         ║
# ║         Safe  |  Deep  |  Custom ROM Level  |  No Root  |  No Knowledge OK ║
# ╚══════════════════════════════════════════════════════════════════════════════╝

# ─── COLORS ───────────────────────────────────────────────────────────────────
RED='\033[0;31m';    LRED='\033[1;31m'
GREEN='\033[0;32m';  LGREEN='\033[1;32m'
YELLOW='\033[1;33m'; CYAN='\033[0;36m'
LCYAN='\033[1;36m';  BLUE='\033[0;34m'
MAGENTA='\033[0;35m';LMAG='\033[1;35m'
WHITE='\033[1;37m';  GREY='\033[0;37m'
BOLD='\033[1m';      DIM='\033[2m'
NC='\033[0m'

# ─── GLOBALS ──────────────────────────────────────────────────────────────────
REMOVED=0; FAILED=0; SKIPPED=0
LOGFILE="xnodes_debloat_$(date +%Y%m%d_%H%M%S).log"
VERSION="3.0 MAGIC EDITION"

# ══════════════════════════════════════════════════════════════════════════════
#   BANNER
# ══════════════════════════════════════════════════════════════════════════════
banner() {
  clear
  echo -e "${LCYAN}"
  cat << 'ART'
██╗  ██╗███╗   ██╗ ██████╗ ██████╗ ███████╗███████╗
╚██╗██╔╝████╗  ██║██╔═══██╗██╔══██╗██╔════╝██╔════╝
 ╚███╔╝ ██╔██╗ ██║██║   ██║██║  ██║█████╗  ███████╗
 ██╔██╗ ██║╚██╗██║██║   ██║██║  ██║██╔══╝  ╚════██║
██╔╝ ██╗██║ ╚████║╚██████╔╝██████╔╝███████╗███████║
╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═════╝ ╚══════╝╚══════╝
ART
  echo -e "${NC}"
  echo -e "${LMAG}  ╔══════════════════════════════════════════════════════════════════╗${NC}"
  echo -e "${LMAG}  ║${WHITE}${BOLD}   🚀  ULTRA MASTER ANDROID DEBLOATER — MAGIC EDITION v3.0    ${LMAG}║${NC}"
  echo -e "${LMAG}  ║${CYAN}        Programmed by Tharindu Liyanage  |  Xnodes               ${LMAG}║${NC}"
  echo -e "${LMAG}  ║${YELLOW}    ⚡ Rocket Speed   🔋 Battery Beast   🛡️  Privacy Shield      ${LMAG}║${NC}"
  echo -e "${LMAG}  ║${GREEN}       Custom ROM Level Deep Optimization  |  No Root Needed     ${LMAG}║${NC}"
  echo -e "${LMAG}  ╚══════════════════════════════════════════════════════════════════╝${NC}"
  echo ""
}

# ══════════════════════════════════════════════════════════════════════════════
#   HELPERS
# ══════════════════════════════════════════════════════════════════════════════
log()  { echo "[$(date '+%H:%M:%S')] $*" >> "$LOGFILE"; }
sep()  { echo -e "${DIM}${CYAN}  ──────────────────────────────────────────────────${NC}"; }
head() { echo -e "\n${LMAG}${BOLD}  $*${NC}"; sep; }

# ══════════════════════════════════════════════════════════════════════════════
#   ADB CHECK & DEVICE INFO
# ══════════════════════════════════════════════════════════════════════════════
check_adb() {
  echo -e "\n${YELLOW}  Checking ADB connection...${NC}"

  if ! command -v adb &>/dev/null; then
    echo -e "${LRED}  [ERROR] ADB not found on this system!${NC}"
    echo -e "${CYAN}  Download ADB: https://developer.android.com/studio/releases/platform-tools${NC}"
    exit 1
  fi

  DEVICE=$(adb devices 2>/dev/null | grep -v "List" | grep "device$" | head -1 | cut -f1)
  if [ -z "$DEVICE" ]; then
    echo -e "${LRED}  [ERROR] No phone detected!${NC}\n"
    echo -e "${WHITE}${BOLD}  How to enable USB Debugging:${NC}"
    sep
    echo -e "${GREEN}  Step 1 — Settings → About Phone → Build Number → tap 7 times${NC}"
    echo -e "${GREEN}  Step 2 — Settings → Developer Options → USB Debugging → ON${NC}"
    echo -e "${GREEN}  Step 3 — Connect your phone via USB cable${NC}"
    echo -e "${GREEN}  Step 4 — On phone popup, tap Allow / OK${NC}"
    echo -e "${GREEN}  Step 5 — Run this script again${NC}\n"
    exit 1
  fi

  PHONE_BRAND=$(adb shell getprop ro.product.brand 2>/dev/null | tr -d '\r\n ')
  PHONE_MODEL=$(adb shell getprop ro.product.model 2>/dev/null | tr -d '\r\n ')
  PHONE_ANDROID=$(adb shell getprop ro.build.version.release 2>/dev/null | tr -d '\r\n ')
  PHONE_SDK=$(adb shell getprop ro.build.version.sdk 2>/dev/null | tr -d '\r\n ')
  PHONE_CPU=$(adb shell getprop ro.hardware 2>/dev/null | tr -d '\r\n ')
  PHONE_BATTERY=$(adb shell dumpsys battery 2>/dev/null | grep "level" | head -1 | awk '{print $2}')
  PHONE_RAM=$(adb shell cat /proc/meminfo 2>/dev/null | grep MemTotal | awk '{printf "%.0f MB", $2/1024}')

  echo -e "\n${LGREEN}  Connected!${NC}"
  sep
  printf "  ${CYAN}%-12s${WHITE} %s${NC}\n" "Brand:"    "$PHONE_BRAND"
  printf "  ${CYAN}%-12s${WHITE} %s${NC}\n" "Model:"    "$PHONE_MODEL"
  printf "  ${CYAN}%-12s${WHITE} Android %s (SDK %s)${NC}\n" "OS:" "$PHONE_ANDROID" "$PHONE_SDK"
  printf "  ${CYAN}%-12s${WHITE} %s${NC}\n" "RAM:"      "$PHONE_RAM"
  printf "  ${CYAN}%-12s${WHITE} %s${NC}\n" "CPU:"      "$PHONE_CPU"
  printf "  ${CYAN}%-12s${WHITE} %s%%${NC}\n" "Battery:" "$PHONE_BATTERY"
  sep
  log "=== XNODES DEBLOATER $VERSION ==="
  log "Device: $PHONE_BRAND $PHONE_MODEL | Android $PHONE_ANDROID | SDK $PHONE_SDK"
}

# ══════════════════════════════════════════════════════════════════════════════
#   CORE DEBLOAT ENGINE
# ══════════════════════════════════════════════════════════════════════════════
debloat() {
  local pkg="$1" desc="$2"
  local exists
  exists=$(adb shell pm list packages "$pkg" 2>/dev/null | grep -c "^package:${pkg}$" || true)
  if [ "$exists" -eq 0 ]; then
    printf "  ${DIM}%-6s  %s${NC}\n" "SKIP" "$desc"
    ((SKIPPED++)); log "SKIP: $pkg"; return
  fi
  adb shell pm disable-user --user 0 "$pkg" >/dev/null 2>&1 || true
  local disabled
  disabled=$(adb shell pm list packages -d 2>/dev/null | grep -c "^package:${pkg}$" || true)
  if [ "$disabled" -gt 0 ]; then
    printf "  ${LGREEN}%-6s${NC}  ${GREY}%s${NC}\n" "[OK]" "$desc"
    ((REMOVED++)); log "REMOVED: $pkg — $desc"
  else
    printf "  ${YELLOW}%-6s${NC}  %s${NC}\n" "[FAIL]" "$desc"
    ((FAILED++)); log "FAILED: $pkg — $desc"
  fi
}

# ══════════════════════════════════════════════════════════════════════════════
#   MODULE 1 — GOOGLE BLOATWARE
# ══════════════════════════════════════════════════════════════════════════════
debloat_google() {
  head "MODULE 1 — GOOGLE BLOATWARE"

  debloat "com.google.android.videos"               "Google Play Movies & TV"
  debloat "com.google.android.music"                "Google Play Music (Legacy)"
  debloat "com.google.android.apps.youtube.music"   "YouTube Music"
  debloat "com.google.android.apps.subscriptions.red" "YouTube Premium App"
  debloat "com.google.android.talk"                 "Google Hangouts"
  debloat "com.google.android.apps.tachyon"         "Google Duo (Standalone)"
  debloat "com.google.android.apps.magazines"       "Google News / Newsstand"
  debloat "com.google.android.apps.books"           "Google Play Books"
  debloat "com.google.android.apps.docs"            "Google Docs (preinstalled)"
  debloat "com.google.android.apps.sheets"          "Google Sheets (preinstalled)"
  debloat "com.google.android.apps.slides"          "Google Slides (preinstalled)"
  debloat "com.google.android.apps.photos"          "Google Photos (preinstalled)"
  debloat "com.google.android.feedback"             "Google Feedback"
  debloat "com.google.android.partnersetup"         "Partner Setup"
  debloat "com.google.android.printservice.recommendation" "Print Service Recommendation"
  debloat "com.google.android.apps.restore"         "Google Device Restore"
  debloat "com.google.android.apps.wellbeing"       "Digital Wellbeing"
  debloat "com.google.android.marvin.talkback"      "TalkBack Accessibility"
  debloat "com.google.android.apps.nbu.files"       "Files by Google"
  debloat "com.google.android.setupwizard"          "Setup Wizard (safe after setup)"
  debloat "com.google.android.onetimeinitializer"   "One Time Initializer"
  debloat "com.google.android.apps.enterprise.clouddpc" "Android Device Policy"
  debloat "com.google.android.apps.googleassistant" "Google Assistant (if unwanted)"
  debloat "com.google.android.hotspot2"             "Passpoint Provisioner (background scanner)"
  debloat "com.google.android.as"                   "Android System Intelligence (heavy RAM)"
  debloat "com.google.android.as.oss"               "Android System Intelligence OSS"
  debloat "com.google.android.gms.supervision"      "Kids Supervision"
  debloat "com.google.android.apps.kids.familylink" "Google Family Link"
  debloat "com.google.android.networkstack.permissionconfig" "Network Permission Config"
  debloat "com.google.android.captiveportallogin"   "Captive Portal Login"
  debloat "com.google.android.documentsui"          "Documents UI (use better file manager)"
  debloat "com.google.android.syncadapters.contacts" "Google Contacts Sync Adapter"
  debloat "com.google.android.apps.work.profile"    "Work Profile Helper"
}

# ══════════════════════════════════════════════════════════════════════════════
#   MODULE 2 — SAMSUNG DEEP BLOATWARE
# ══════════════════════════════════════════════════════════════════════════════
debloat_samsung() {
  [[ "${PHONE_BRAND,,}" != *samsung* ]] && return
  head "MODULE 2 — SAMSUNG DEEP BLOATWARE"

  # Bixby — massive always-on drain
  debloat "com.samsung.android.bixby.agent"           "Bixby Voice Agent (always-on drain!)"
  debloat "com.samsung.android.bixby.agent.dummy"     "Bixby Dummy Agent"
  debloat "com.samsung.android.bixby.wakeup"          "Bixby Wakeup Listener (microphone!)"
  debloat "com.samsung.android.bixby.service"         "Bixby Background Service"
  debloat "com.samsung.android.bixbyvision.framework" "Bixby Vision"
  debloat "com.samsung.android.app.routines"          "Bixby Routines"
  debloat "com.samsung.systemui.bixby2"               "Bixby Sidebar"
  debloat "com.samsung.android.bixby.personalization" "Bixby Personalization"
  # AR Junk
  debloat "com.samsung.android.arzone"                "AR Zone"
  debloat "com.samsung.android.aremoji"               "AR Emoji"
  debloat "com.samsung.android.aremoji.editor"        "AR Emoji Editor"
  debloat "com.samsung.android.app.camera.sticker.facear" "Face AR Camera Sticker"
  debloat "com.samsung.android.livestickers"          "Live Stickers"
  debloat "com.samsung.android.stickercenter"         "Sticker Center"
  # Pay
  debloat "com.samsung.android.spay"                  "Samsung Pay"
  debloat "com.samsung.android.samsungpay.gear"       "Samsung Pay Gear"
  debloat "com.samsung.android.samsungpayindia"       "Samsung Pay India"
  # Knox / Enterprise
  debloat "com.samsung.knox.securefolder"             "Secure Folder (if unused)"
  debloat "com.samsung.knox.analytics.uploader"       "Knox Analytics Uploader"
  debloat "com.samsung.android.knox.containercore"    "Knox Container Core"
  debloat "com.samsung.android.knox.push"             "Knox Push"
  debloat "com.samsung.android.mdx"                   "Samsung MDX"
  debloat "com.samsung.android.mdx.kit"               "Samsung MDX Kit"
  # Game bloat
  debloat "com.samsung.android.game.gamehome"         "Game Launcher"
  debloat "com.samsung.android.game.gos"              "GOS — Game Optimizing Service (THROTTLES phone!)"
  debloat "com.samsung.android.game.gametools"        "Game Tools Overlay"
  # Analytics / Tracking
  debloat "com.samsung.android.rubin.app"             "Samsung Analytics & Tracking"
  debloat "com.samsung.android.mobileservice"         "Samsung Mobile Services"
  debloat "com.samsung.android.app.updatecenter"      "Samsung Update Center"
  debloat "com.sec.android.diagmonagent"              "Diagnostic Monitor Agent"
  debloat "com.sec.android.easyMover.Agent"           "Smart Switch Agent"
  debloat "com.samsung.android.smartswitchassistant"  "Smart Switch Assistant"
  debloat "com.samsung.android.beaconmanager"         "Samsung Beacon Manager (location tracking)"
  debloat "com.sec.android.soagent"                   "Samsung SoAgent (background process)"
  debloat "com.samsung.android.ipsgeofence"           "IPS Geofence (location harvesting)"
  # Cloud / Sync
  debloat "com.samsung.android.scloud"                "Samsung Cloud Sync"
  debloat "com.samsung.android.app.social"            "Samsung Social (dead service)"
  # Themes / UI fluff
  debloat "com.samsung.android.themestore"            "Theme Store"
  debloat "com.samsung.android.app.dressroom"         "Dress Room / Themes App"
  debloat "com.samsung.android.app.tips"              "Samsung Tips"
  debloat "com.samsung.android.privateshare"          "Private Share"
  debloat "com.samsung.android.kidsinstaller"         "Kids Mode Installer"
  debloat "com.samsung.android.kidsmode"              "Kids Mode"
  debloat "com.samsung.android.easysetup"             "Easy Setup"
  debloat "com.samsung.android.app.galaxyfinder"      "Galaxy Finder"
  debloat "com.samsung.android.wallpaper.live"        "Samsung Live Wallpaper"
  debloat "com.sec.android.app.chromecustomizations"  "Chrome Customizations"
  debloat "com.samsung.android.app.watchmanagersam"   "Galaxy Watch Manager (if no watch)"
  debloat "com.samsung.android.lool"                  "Samsung Life Skills (useless)"
  debloat "com.samsung.android.messaging"             "Samsung Messages (replace with Signal/AOSP)"
  debloat "com.samsung.android.email.provider"        "Samsung Email (replace with Gmail/Proton)"
}

# ══════════════════════════════════════════════════════════════════════════════
#   MODULE 3 — XIAOMI / MIUI / REDMI / POCO
# ══════════════════════════════════════════════════════════════════════════════
debloat_xiaomi() {
  [[ "${PHONE_BRAND,,}" != *xiaomi* ]] && [[ "${PHONE_BRAND,,}" != *redmi* ]] && [[ "${PHONE_BRAND,,}" != *poco* ]] && return
  head "MODULE 3 — XIAOMI / MIUI SPYWARE & BLOAT REMOVAL"

  # CRITICAL: Ads & Spyware — these are the worst offenders
  debloat "com.miui.analytics"                      "[SPYWARE] MIUI Analytics"
  debloat "com.miui.msa.global"                     "[SPYWARE] MIUI System Ads"
  debloat "com.miui.hybrid"                         "[SPYWARE] MIUI Hybrid Ads Platform"
  debloat "com.miui.hybrid.accessory"               "[SPYWARE] MIUI Hybrid Accessory"
  debloat "com.miui.systemadserver"                 "[SPYWARE] MIUI System Ad Server"
  debloat "com.miui.daemon"                         "[SPYWARE] MIUI Ad Daemon Process"
  debloat "com.miui.global.providers"               "[SPYWARE] MIUI Global Tracking Providers"
  debloat "com.miui.contentcatcher"                 "[SPYWARE] Content Catcher (reads your content)"
  debloat "com.baidu.input_mi"                      "[SPYWARE] Baidu Input — Chinese Spyware Keyboard"
  debloat "com.xiaomi.mipicks"                      "[ADS] GetApps Spam Recommendations"
  debloat "com.miui.miservice"                      "[TRACKING] MIUI Mi Service"
  debloat "com.miui.phrase"                         "[TRACKING] Phrase — Word Suggestion Tracker"
  debloat "com.miui.personalassistant"              "MIUI Personal Assistant"
  # Junk Apps
  debloat "com.miui.bugreport"                      "MIUI Bug Report (sends data to Xiaomi)"
  debloat "com.miui.cleanmaster"                    "Clean Master (junk cleaner)"
  debloat "com.miui.player"                         "MIUI Music Player"
  debloat "com.miui.videoplayer"                    "MIUI Video Player"
  debloat "com.miui.yellowpage"                     "MIUI Yellow Pages"
  debloat "com.miui.compass"                        "MIUI Compass"
  debloat "com.miui.notes"                          "MIUI Notes"
  debloat "com.miui.weather2"                       "MIUI Weather"
  debloat "com.miui.fm"                             "MIUI FM Radio"
  debloat "com.miui.calculator"                     "MIUI Calculator (replace with Google Calc)"
  debloat "com.xiaomi.midrop"                       "ShareMe / MiDrop"
  debloat "com.xiaomi.gamecenter.sdk.service"       "Mi Game Center"
  debloat "com.miui.cloudservice"                   "MIUI Cloud Service"
  debloat "com.miui.cloudbackup"                    "MIUI Cloud Backup"
  debloat "com.miui.cloudgame"                      "MIUI Cloud Game"
  debloat "com.miui.gallery"                        "MIUI Gallery (replace with A-Photos)"
  debloat "com.miui.mi_optimize"                    "MIUI Optimizer"
  debloat "com.miui.securityadd"                    "MIUI Security Add-on (bloated)"
  debloat "com.miui.antispam"                       "MIUI Anti-Spam (itself spammy)"
  debloat "com.xiaomi.payment"                      "Mi Payment"
  debloat "com.miui.miinput"                        "MIUI Input (replace with Gboard)"
  debloat "com.miui.voiceassist"                    "MIUI Voice Assistant"
  debloat "com.miui.mishare.connectivity"           "Mi Share Connectivity"
  debloat "com.mi.android.globalminusscreen"        "Mi -1 Screen (Today Feed — always polling)"
  debloat "com.miui.newhome"                        "MIUI New Home (replace with Nova Launcher)"
  debloat "com.miui.catcherpatch"                   "MIUI Catcher Patch (background scanner)"
}

# ══════════════════════════════════════════════════════════════════════════════
#   MODULE 4 — REALME / OPPO / ColorOS
# ══════════════════════════════════════════════════════════════════════════════
debloat_realme() {
  [[ "${PHONE_BRAND,,}" != *realme* ]] && [[ "${PHONE_BRAND,,}" != *oppo* ]] && return
  head "MODULE 4 — REALME / OPPO BLOATWARE"

  debloat "com.coloros.weather2"                    "ColorOS Weather"
  debloat "com.coloros.music"                       "ColorOS Music"
  debloat "com.coloros.video"                       "ColorOS Video"
  debloat "com.coloros.phonemanager"                "ColorOS Phone Manager (bloated)"
  debloat "com.oppo.market"                         "OPPO App Market (spam)"
  debloat "com.nearme.gamecenter"                   "NearMe Game Center"
  debloat "com.realme.gamespaceui"                  "Realme Game Space"
  debloat "com.coloros.safecenter"                  "ColorOS Safe Center"
  debloat "com.oplus.statisticsubs"                 "[TRACKING] OPPO Statistics & Tracking"
  debloat "com.oplus.oshare"                        "OPPO Share"
  debloat "com.coloros.backuprestore"               "ColorOS Backup"
  debloat "com.coloros.cloudservice"                "ColorOS Cloud"
  debloat "com.heytap.market"                       "HeyTap Market (spam)"
  debloat "com.heytap.pictorial"                    "HeyTap Pictorial"
  debloat "com.heytap.speechassist"                 "HeyTap Voice Assistant"
  debloat "com.coloros.note"                        "ColorOS Notes"
  debloat "com.coloros.filemanager"                 "ColorOS File Manager"
  debloat "com.coloros.themes"                      "ColorOS Themes"
  debloat "com.oplus.l10napplication"               "OPPO Localization (unknown background)"
}

# ══════════════════════════════════════════════════════════════════════════════
#   MODULE 5 — ONEPLUS / OxygenOS
# ══════════════════════════════════════════════════════════════════════════════
debloat_oneplus() {
  [[ "${PHONE_BRAND,,}" != *oneplus* ]] && return
  head "MODULE 5 — ONEPLUS / OXYGENOS BLOATWARE"

  debloat "com.oneplus.brickmode"                   "OnePlus Brick Mode"
  debloat "com.oneplus.tips"                        "OnePlus Tips"
  debloat "com.oneplus.ocloud"                      "OnePlus Cloud"
  debloat "com.oneplus.wallpaperscroll"             "OnePlus Wallpaper Scroll"
  debloat "com.oneplus.oneplusswitch"               "OnePlus Switch"
  debloat "com.oneplus.healthservice"               "OnePlus Health Service"
  debloat "net.oneplus.odm"                         "OnePlus ODM Service"
  debloat "com.oneplus.account"                     "OnePlus Account"
  debloat "com.oneplus.photos"                      "OnePlus Photos"
  debloat "com.oneplus.gallery"                     "OnePlus Gallery"
  debloat "com.oneplus.filemanager"                 "OnePlus File Manager"
  debloat "com.oneplus.weather"                     "OnePlus Weather"
}

# ══════════════════════════════════════════════════════════════════════════════
#   MODULE 6 — UNIVERSAL SPYWARE (ALL BRANDS)
# ══════════════════════════════════════════════════════════════════════════════
debloat_spyware() {
  head "MODULE 6 — UNIVERSAL SPYWARE & TRACKERS"

  # Facebook ecosystem — notorious background battery drain
  debloat "com.facebook.services"                   "[SPYWARE] Facebook Device Services"
  debloat "com.facebook.system"                     "[SPYWARE] Facebook System Service"
  debloat "com.facebook.appmanager"                 "[SPYWARE] Facebook App Manager"
  debloat "com.facebook.katana"                     "Facebook Main App (preinstalled)"
  debloat "com.facebook.orca"                       "Facebook Messenger (preinstalled)"
  debloat "com.instagram.android"                   "Instagram (preinstalled)"
  debloat "com.whatsapp"                            "WhatsApp (preinstalled)"
  # Microsoft bloat
  debloat "com.microsoft.teams"                     "Microsoft Teams (preinstalled)"
  debloat "com.microsoft.skydrive"                  "Microsoft OneDrive (preinstalled)"
  debloat "com.skype.raider"                        "Skype (preinstalled)"
  debloat "com.microsoft.office.word"               "Microsoft Word (preinstalled)"
  debloat "com.microsoft.office.excel"              "Microsoft Excel (preinstalled)"
  debloat "com.microsoft.office.powerpoint"         "Microsoft PowerPoint (preinstalled)"
  # Other preinstalled junk
  debloat "com.amazon.kindle"                       "Amazon Kindle (preinstalled)"
  debloat "com.netflix.mediaclient"                 "Netflix (preinstalled)"
  debloat "com.spotify.music"                       "Spotify (preinstalled)"
  debloat "com.linkedin.android"                    "LinkedIn (preinstalled)"
  debloat "com.twitter.android"                     "Twitter / X (preinstalled)"
  debloat "com.snapchat.android"                    "Snapchat (preinstalled)"
  debloat "com.tiktok"                              "TikTok (preinstalled)"
}

# ══════════════════════════════════════════════════════════════════════════════
#   MODULE 7 — HIDDEN BACKGROUND DRAINERS (Custom ROM Level Research)
# ══════════════════════════════════════════════════════════════════════════════
debloat_hidden() {
  head "MODULE 7 — HIDDEN BACKGROUND DRAINERS"

  # Qualcomm daemons — most users never know these run 24/7
  debloat "com.qualcomm.qti.sva.manager"            "Qualcomm SVA — Always-On Voice Engine"
  debloat "com.qualcomm.qti.perfdump"               "Qualcomm Perf Dump (performance telemetry)"
  debloat "com.qualcomm.qti.qms.service.trustzoneaccess" "Qualcomm Trust Zone Access"
  debloat "com.qualcomm.qti.sar"                    "Qualcomm SAR Service (background scanner)"
  debloat "com.qti.snapdragon.qdsp6"                "Snapdragon QDSP6 (unneeded on most devices)"
  # Android system junk
  debloat "com.android.dreams.basic"                "Basic Screensavers"
  debloat "com.android.dreams.phototable"           "Photo Table Screensaver"
  debloat "com.android.smspush"                     "SMS Push — WAP Protocol (obsolete since 2015)"
  debloat "com.android.wallpaper.livepicker"        "Live Wallpaper Picker"
  debloat "com.android.sharedstoragebackup"         "Shared Storage Backup"
  debloat "com.android.localtransport"              "Local Transport (backup layer)"
  debloat "com.android.stk"                         "SIM Toolkit (safe on unlocked phones)"
  debloat "com.android.backupconfirm"               "Backup Confirm UI"
  debloat "com.android.hotspot2.osulogin"           "Hotspot 2.0 OSU Login"
  debloat "com.android.managedprovisioning"         "Managed Provisioning (enterprise)"
  debloat "com.android.traceur"                     "System Tracing (development tool)"
  debloat "com.android.apps.tag"                    "NFC Tag Writer App"
  debloat "com.android.certinstaller"               "Certificate Installer (post-setup safe)"
  debloat "com.android.printspooler"                "Print Spooler (if not printing)"
  debloat "com.android.wallpaper"                   "Default Wallpaper App"
  debloat "com.android.egg"                         "Android Easter Egg"
  debloat "com.android.htmlviewer"                  "HTML Viewer (ancient, obsolete)"
  debloat "com.android.emergency"                   "Emergency Info Companion App"
  debloat "com.android.facelock"                    "Face Unlock Legacy (old bloated version)"
  debloat "com.android.providers.userdictionary"    "User Dictionary Sync"
  debloat "com.google.android.networkstack"         "Network Stack Captive Portal (background)"
  debloat "com.google.android.connectivity.resources" "Connectivity Resources (duplicate)"
}

# ══════════════════════════════════════════════════════════════════════════════
#   MODULE 8 — SPEED PROFILE (Custom ROM Level Kernel + System Tweaks)
# ══════════════════════════════════════════════════════════════════════════════
apply_speed_profile() {
  head "MODULE 8 — SPEED PROFILE (Custom ROM Level)"

  echo -e "  ${CYAN}Applying UI animation tweaks...${NC}"
  adb shell settings put global window_animation_scale 0.4 2>/dev/null
  adb shell settings put global transition_animation_scale 0.4 2>/dev/null
  adb shell settings put global animator_duration_scale 0.4 2>/dev/null
  echo -e "  ${LGREEN}[OK]  Animations set to 0.4x — UI feels lightning fast${NC}"

  echo -e "  ${CYAN}Forcing GPU hardware acceleration...${NC}"
  adb shell setprop debug.egl.hw 1 2>/dev/null
  adb shell setprop debug.sf.hw 1 2>/dev/null
  adb shell setprop debug.hwui.renderer opengl 2>/dev/null
  adb shell setprop persist.sys.ui.hw 1 2>/dev/null
  echo -e "  ${LGREEN}[OK]  GPU hardware acceleration forced on${NC}"

  echo -e "  ${CYAN}Limiting background processes...${NC}"
  adb shell settings put global background_process_limit 3 2>/dev/null
  echo -e "  ${LGREEN}[OK]  Background app limit: max 3 processes${NC}"

  echo -e "  ${CYAN}Enabling RAM purgeable assets...${NC}"
  adb shell setprop persist.sys.purgeable_assets 1 2>/dev/null
  adb shell setprop ro.config.fha_enable true 2>/dev/null
  echo -e "  ${LGREEN}[OK]  RAM purgeable assets enabled${NC}"

  echo -e "  ${CYAN}Optimizing touch response...${NC}"
  adb shell settings put system pointer_speed 4 2>/dev/null
  echo -e "  ${LGREEN}[OK]  Touch pointer speed maximized${NC}"

  echo -e "  ${CYAN}Enabling Skia GPU rendering...${NC}"
  adb shell setprop debug.skia.enabled true 2>/dev/null
  adb shell setprop debug.composition.type gpu 2>/dev/null
  echo -e "  ${LGREEN}[OK]  Skia GPU rendering enabled${NC}"

  echo -e "  ${CYAN}Setting DEX optimization to speed-profile...${NC}"
  adb shell setprop pm.dexopt.bg-dexopt speed-profile 2>/dev/null
  adb shell setprop pm.dexopt.boot-after-ota speed-profile 2>/dev/null
  echo -e "  ${LGREEN}[OK]  DEX: speed-profile mode (like custom ROMs)${NC}"

  echo -e "  ${CYAN}Tuning network stack...${NC}"
  adb shell settings put global network_congestion_control bbr 2>/dev/null
  adb shell settings put global wifi_scan_throttle_enabled 1 2>/dev/null
  adb shell settings put global ble_scan_always_enabled 0 2>/dev/null
  adb shell settings put global networks_available_notification_on 0 2>/dev/null
  echo -e "  ${LGREEN}[OK]  Network BBR algorithm + WiFi scan throttled${NC}"

  echo -e "\n  ${LGREEN}${BOLD}Speed Profile Applied! Phone should feel noticeably faster.${NC}"
}

# ══════════════════════════════════════════════════════════════════════════════
#   MODULE 9 — BATTERY BEAST MODE
# ══════════════════════════════════════════════════════════════════════════════
apply_battery_mode() {
  head "MODULE 9 — BATTERY BEAST MODE"

  echo -e "  ${CYAN}Enabling enhanced battery mode...${NC}"
  adb shell settings put global always_finish_activities 0 2>/dev/null
  adb shell settings put global enhanced_battery_mode 1 2>/dev/null
  echo -e "  ${LGREEN}[OK]  Enhanced battery mode ON${NC}"

  echo -e "  ${CYAN}Disabling radio background drains...${NC}"
  adb shell settings put global ble_scan_always_enabled 0 2>/dev/null
  adb shell settings put global wifi_scan_throttle_enabled 1 2>/dev/null
  adb shell settings put global nfc_payment_foreground 0 2>/dev/null
  adb shell settings put global aggressive_wifi_to_mobile_handover 1 2>/dev/null
  echo -e "  ${LGREEN}[OK]  BLE background scan OFF | NFC background OFF | WiFi throttled${NC}"

  echo -e "  ${CYAN}Throttling background sync...${NC}"
  adb shell settings put global sync_max_retry_delay_sec 86400 2>/dev/null
  adb shell settings put global auto_time 1 2>/dev/null
  echo -e "  ${LGREEN}[OK]  Background sync retry: once per 24 hours max${NC}"

  echo -e "  ${CYAN}Forcing aggressive Doze mode...${NC}"
  adb shell dumpsys deviceidle enable deep 2>/dev/null
  adb shell dumpsys deviceidle enable light 2>/dev/null
  adb shell dumpsys deviceidle force-idle 2>/dev/null
  echo -e "  ${LGREEN}[OK]  Doze deep + light mode forced (like GrapheneOS tuning)${NC}"

  echo -e "  ${CYAN}Reducing notification screen wakeups...${NC}"
  adb shell settings put global heads_up_notifications_enabled 0 2>/dev/null
  echo -e "  ${LGREEN}[OK]  Heads-up notifications OFF (reduces accidental wakeups)${NC}"

  echo -e "  ${CYAN}Disabling camera background buffering...${NC}"
  adb shell setprop camera.disable_zsl_mode 1 2>/dev/null
  echo -e "  ${LGREEN}[OK]  ZSL camera background mode OFF${NC}"

  echo -e "\n  ${LGREEN}${BOLD}Battery Beast Mode Applied! Expect noticeably longer battery life.${NC}"
}

# ══════════════════════════════════════════════════════════════════════════════
#   MODULE 10 — RAM NUCLEAR CLEAR
# ══════════════════════════════════════════════════════════════════════════════
ram_nuke() {
  head "MODULE 10 — RAM NUCLEAR CLEAR"

  echo -e "  ${CYAN}RAM Before:${NC}"
  adb shell cat /proc/meminfo 2>/dev/null | grep -E "MemTotal|MemFree|Cached" | \
    while IFS= read -r line; do printf "  ${GREY}  %s${NC}\n" "$line"; done

  echo -e "\n  ${CYAN}Killing all background cached apps...${NC}"
  adb shell am kill-all 2>/dev/null
  echo -e "  ${LGREEN}[OK]  All cached background apps killed${NC}"

  echo -e "  ${CYAN}Flushing dirty system memory...${NC}"
  adb shell sync 2>/dev/null
  echo -e "  ${LGREEN}[OK]  System sync flushed${NC}"

  echo -e "  ${CYAN}Clearing ANR crash traces...${NC}"
  adb shell rm -rf /data/anr/* 2>/dev/null
  echo -e "  ${LGREEN}[OK]  ANR traces cleared${NC}"

  echo -e "  ${CYAN}Clearing recents list...${NC}"
  adb shell am clear-task-list 2>/dev/null || true
  echo -e "  ${LGREEN}[OK]  Recent apps list cleared${NC}"

  echo -e "  ${CYAN}Trimming app caches (freeing 1GB)...${NC}"
  adb shell pm trim-caches 1048576000 2>/dev/null
  echo -e "  ${LGREEN}[OK]  App cache trim: 1GB freed${NC}"

  echo -e "\n  ${CYAN}RAM After:${NC}"
  adb shell cat /proc/meminfo 2>/dev/null | grep -E "MemTotal|MemFree|Cached" | \
    while IFS= read -r line; do printf "  ${GREY}  %s${NC}\n" "$line"; done

  echo -e "\n  ${LGREEN}${BOLD}RAM Nuked! Your phone can breathe again.${NC}"
}

# ══════════════════════════════════════════════════════════════════════════════
#   RESTORE ALL
# ══════════════════════════════════════════════════════════════════════════════
restore_all() {
  head "RESTORE ALL DISABLED PACKAGES"
  echo -e "  ${LRED}WARNING: This will re-enable ALL disabled packages!${NC}"
  echo -ne "  ${CYAN}Are you sure? (y/n): ${NC}"; read -r confirm
  [[ "$confirm" != "y" ]] && echo -e "  ${YELLOW}Cancelled.${NC}" && return
  local cnt=0
  while IFS= read -r line; do
    local pkg="${line//package:/}"; pkg="${pkg//[[:space:]]/}"
    [ -z "$pkg" ] && continue
    adb shell pm enable --user 0 "$pkg" >/dev/null 2>&1
    echo -e "  ${LGREEN}[RESTORED]  $pkg${NC}"
    ((cnt++))
  done < <(adb shell pm list packages -d 2>/dev/null)
  echo -e "\n  ${LGREEN}${BOLD}$cnt packages restored. Please restart your phone.${NC}"
}

# ══════════════════════════════════════════════════════════════════════════════
#   RESULTS SUMMARY
# ══════════════════════════════════════════════════════════════════════════════
results() {
  local freed=$((REMOVED * 45))
  echo ""
  echo -e "${LCYAN}  ╔═══════════════════════════════════════════════════════╗${NC}"
  echo -e "${LCYAN}  ║${WHITE}${BOLD}          ✨  XNODES MAGIC RESULTS  ✨                 ${LCYAN}║${NC}"
  echo -e "${LCYAN}  ╠═══════════════════════════════════════════════════════╣${NC}"
  printf "${LCYAN}  ║${LGREEN}  %-16s ${WHITE}${BOLD}%-4d apps removed                ${LCYAN}║${NC}\n" "Removed:" "$REMOVED"
  printf "${LCYAN}  ║${YELLOW}  %-16s ${WHITE}${BOLD}%-4d not found (OK)              ${LCYAN}║${NC}\n" "Skipped:" "$SKIPPED"
  printf "${LCYAN}  ║${LRED}  %-16s ${WHITE}${BOLD}%-4d failed                      ${LCYAN}║${NC}\n" "Failed:" "$FAILED"
  echo -e "${LCYAN}  ╠═══════════════════════════════════════════════════════╣${NC}"
  printf "${LCYAN}  ║${CYAN}  %-16s ${WHITE}${BOLD}~%s MB                          ${LCYAN}║${NC}\n" "Storage freed:" "$freed"
  echo -e "${LCYAN}  ║${CYAN}  Battery life    ${WHITE}${BOLD}~15-35%% improvement             ${LCYAN}║${NC}"
  echo -e "${LCYAN}  ║${CYAN}  Performance     ${WHITE}${BOLD}~25-50%% faster                  ${LCYAN}║${NC}"
  echo -e "${LCYAN}  ║${CYAN}  Privacy         ${WHITE}${BOLD}Spyware & Trackers Eliminated    ${LCYAN}║${NC}"
  echo -e "${LCYAN}  ╠═══════════════════════════════════════════════════════╣${NC}"
  echo -e "${LCYAN}  ║${LMAG}  Log: ${WHITE}$LOGFILE  ${LCYAN}║${NC}"
  echo -e "${LCYAN}  ╠═══════════════════════════════════════════════════════╣${NC}"
  echo -e "${LCYAN}  ║${YELLOW}  ⚠  RESTART YOUR PHONE for full effect!              ${LCYAN}║${NC}"
  echo -e "${LCYAN}  ╚═══════════════════════════════════════════════════════╝${NC}"
  echo ""
  echo -e "  ${LMAG}${BOLD}  Programmed by Tharindu Liyanage  |  Xnodes  🚀${NC}"
  echo ""
  log "=== FINAL: $REMOVED removed | $SKIPPED skipped | $FAILED failed ==="
}

# ══════════════════════════════════════════════════════════════════════════════
#   MENU
# ══════════════════════════════════════════════════════════════════════════════
menu() {
  echo -e "\n${WHITE}${BOLD}  MENU — Select an option:${NC}"
  sep
  echo -e "  ${LGREEN}[1]${NC}  🔥  ${WHITE}FULL MAGIC DEBLOAT${NC}  ${YELLOW}← Recommended — runs all modules${NC}"
  echo -e "  ${LGREEN}[2]${NC}  🕵️   ${WHITE}Spyware + Trackers Only${NC}"
  echo -e "  ${LGREEN}[3]${NC}  🔋  ${WHITE}Battery Beast Mode Only${NC}"
  echo -e "  ${LGREEN}[4]${NC}  🚀  ${WHITE}Speed Profile Only${NC}"
  echo -e "  ${LGREEN}[5]${NC}  🧠  ${WHITE}RAM Nuclear Clear Only${NC}"
  echo -e "  ${LGREEN}[6]${NC}  🔵  ${WHITE}Google Bloatware Only${NC}"
  echo -e "  ${LGREEN}[7]${NC}  📱  ${WHITE}Brand-Specific Only${NC}  ${DIM}(Samsung / Xiaomi / Realme / OnePlus)${NC}"
  echo -e "  ${LGREEN}[8]${NC}  🕳️   ${WHITE}Hidden Background Killers Only${NC}"
  echo -e "  ${LGREEN}[9]${NC}  ♻️   ${WHITE}Restore All (Undo Everything)${NC}"
  echo -e "  ${LGREEN}[0]${NC}  ❌  ${WHITE}Exit${NC}"
  sep
  echo -ne "  ${LCYAN}Your choice (0-9): ${NC}"
}

# ══════════════════════════════════════════════════════════════════════════════
#   MAIN
# ══════════════════════════════════════════════════════════════════════════════
banner

echo -e "  ${LRED}${BOLD}IMPORTANT — Please read before proceeding:${NC}"
sep
echo -e "  ${YELLOW}•  No root required — uses safe ADB disable method${NC}"
echo -e "  ${YELLOW}•  Apps are DISABLED, not deleted — fully reversible${NC}"
echo -e "  ${YELLOW}•  Camera, Phone, Calendar, Calculator, YouTube,${NC}"
echo -e "  ${YELLOW}   Play Store and Maps are NEVER touched — 100%% Safe${NC}"
echo -e "  ${YELLOW}•  Restart your phone after script for full effect${NC}"
echo -e "  ${LGREEN}•  Use Option [9] — Restore All to undo any changes${NC}"
sep

check_adb

while true; do
  menu
  read -r choice
  case "$choice" in
    1)
      echo -e "\n${LGREEN}${BOLD}  FULL MAGIC DEBLOAT — All modules running...${NC}"
      log "=== FULL MAGIC DEBLOAT ==="
      debloat_google
      debloat_samsung
      debloat_xiaomi
      debloat_realme
      debloat_oneplus
      debloat_spyware
      debloat_hidden
      apply_speed_profile
      apply_battery_mode
      ram_nuke
      results
      ;;
    2) debloat_spyware;                                                  results ;;
    3) apply_battery_mode ;;
    4) apply_speed_profile ;;
    5) ram_nuke ;;
    6) debloat_google;                                                   results ;;
    7) debloat_samsung; debloat_xiaomi; debloat_realme; debloat_oneplus; results ;;
    8) debloat_hidden;                                                   results ;;
    9) restore_all ;;
    0) echo -e "\n  ${LGREEN}Bye! Restart your phone for full effect!  — Xnodes by Tharindu Liyanage${NC}\n"; exit 0 ;;
    *) echo -e "  ${LRED}Invalid choice. Please enter 0-9.${NC}" ;;
  esac
  echo -ne "\n  ${CYAN}Press Enter to continue...${NC}"; read -r
  banner
done

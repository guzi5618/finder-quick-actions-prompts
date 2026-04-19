#!/bin/bash
set -euo pipefail

WORKFLOW_NAME="打开 Terminal.workflow"
WORKFLOW_DIR="${HOME}/Library/Services/${WORKFLOW_NAME}"
CONTENTS_DIR="${WORKFLOW_DIR}/Contents"

mkdir -p "${CONTENTS_DIR}"

cat > "${CONTENTS_DIR}/Info.plist" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>NSServices</key>
  <array>
    <dict>
      <key>NSMenuItem</key>
      <dict>
        <key>default</key>
        <string>打开 Terminal</string>
      </dict>
      <key>NSMessage</key>
      <string>runWorkflowAsService</string>
      <key>NSRequiredContext</key>
      <dict>
        <key>NSTextContent</key>
        <string>FilePath</string>
      </dict>
      <key>NSSendFileTypes</key>
      <array>
        <string>public.item</string>
      </array>
      <key>NSSendTypes</key>
      <array>
        <string>public.plain-text</string>
      </array>
    </dict>
  </array>
</dict>
</plist>
PLIST

cat > "${CONTENTS_DIR}/document.wflow" <<'PLIST'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>AMApplicationBuild</key>
  <string>523</string>
  <key>AMApplicationVersion</key>
  <string>2.10</string>
  <key>actions</key>
  <array>
    <dict>
      <key>action</key>
      <dict>
        <key>ActionBundlePath</key>
        <string>/System/Library/Automator/Run Shell Script.action</string>
        <key>ActionName</key>
        <string>Run Shell Script</string>
        <key>ActionParameters</key>
        <dict>
          <key>COMMAND_STRING</key>
          <string>resolve_target_dir() {
    if [ "$#" -gt 0 ]; then
        local first="$1"
        if [ -d "$first" ]; then
            printf '%s\n' "$first"
        else
            dirname "$first"
        fi
        return 0
    fi

    /usr/bin/osascript &lt;&lt;'APPLESCRIPT'
tell application "Finder"
    if not (exists Finder window 1) then
        return POSIX path of (path to home folder)
    end if

    set selectedItems to selection
    if (count of selectedItems) &gt; 0 then
        set selectedAlias to (item 1 of selectedItems) as alias
        set selectedPath to POSIX path of selectedAlias
    else
        set selectedPath to POSIX path of (target of front Finder window as alias)
    end if
end tell

tell application "System Events"
    set isFolder to folder of disk item selectedPath
end tell

if isFolder then
    return selectedPath
else
    return do shell script "dirname " &amp; quoted form of selectedPath
end if
APPLESCRIPT
}

target_dir="$(resolve_target_dir "$@")"

if [ -z "$target_dir" ]; then
    exit 1
fi

/usr/bin/osascript &lt;&lt;APPLESCRIPT
tell application "Terminal"
    activate
    do script "cd " &amp; quoted form of "$(printf '%s' "$target_dir" | sed 's/\\/\\\\/g; s/\"/\\\"/g')"
end tell
APPLESCRIPT</string>
          <key>CheckedForUserDefaultShell</key>
          <integer>1</integer>
          <key>inputMethod</key>
          <integer>1</integer>
          <key>shell</key>
          <string>/bin/bash</string>
          <key>source</key>
          <string></string>
        </dict>
        <key>AMAccepts</key>
        <dict>
          <key>Container</key>
          <string>List</string>
          <key>Optional</key>
          <true/>
          <key>Types</key>
          <array>
            <string>com.apple.cocoa.string</string>
          </array>
        </dict>
        <key>AMActionVersion</key>
        <string>2.0.3</string>
        <key>AMApplication</key>
        <array>
          <string>Automator</string>
        </array>
        <key>AMBundleIdentifier</key>
        <string>com.apple.RunShellScript</string>
        <key>AMCategory</key>
        <array>
          <string>AMCategoryUtilities</string>
        </array>
        <key>AMIconName</key>
        <string>Automator</string>
        <key>AMName</key>
        <string>Run Shell Script</string>
        <key>AMProvides</key>
        <dict>
          <key>Container</key>
          <string>List</string>
          <key>Types</key>
          <array>
            <string>com.apple.cocoa.string</string>
          </array>
        </dict>
        <key>BundleIdentifier</key>
        <string>com.apple.RunShellScript</string>
        <key>CFBundleVersion</key>
        <string>2.0.3</string>
      </dict>
    </dict>
  </array>
  <key>connectors</key>
  <dict/>
  <key>workflowMetaData</key>
  <dict>
    <key>serviceInputTypeIdentifier</key>
    <string>com.apple.Automator.fileSystemObject</string>
    <key>serviceOutputTypeIdentifier</key>
    <string>com.apple.Automator.nothing</string>
    <key>serviceProcessesInput</key>
    <integer>0</integer>
    <key>workflowTypeIdentifier</key>
    <string>com.apple.Automator.servicesMenu</string>
  </dict>
</dict>
</plist>
PLIST

/usr/bin/plutil -lint "${CONTENTS_DIR}/Info.plist" >/dev/null
/usr/bin/plutil -lint "${CONTENTS_DIR}/document.wflow" >/dev/null

echo "Installed: ${WORKFLOW_DIR}"

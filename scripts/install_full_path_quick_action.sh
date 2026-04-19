#!/bin/bash
set -euo pipefail

WORKFLOW_NAME="显示并复制完整路径.workflow"
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
        <string>显示并复制完整路径</string>
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
          <string>if [ "$#" -eq 0 ]; then
    exit 0
fi

paths=""
count=0
for item in "$@"
do
    count=$((count + 1))
    if [ -z "$paths" ]; then
        paths="$item"
    else
        paths="$paths
$item"
    fi
done

printf '%s' "$paths" | pbcopy

if [ "$count" -eq 1 ]; then
    title="完整路径已复制"
else
    title="已复制 ${count} 个路径"
fi

/usr/bin/osascript &lt;&lt;'APPLESCRIPT' "$title" "$paths"
on run argv
    set dialogTitle to item 1 of argv
    set pathText to item 2 of argv
    display dialog pathText with title dialogTitle buttons {"好"} default button "好" with icon note
end run
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
echo "If Finder does not show it immediately, log out and back in or relaunch Finder."

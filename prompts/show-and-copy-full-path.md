# Prompt: Show And Copy Full Path

Please help me build a macOS Finder right-click action named `Show and Copy Full Path`.

Goal: when I select a file or folder in Finder and right-click it, I want to run this action from the Finder context menu.

Requirements:

1. The feature must be integrated into the macOS Finder right-click menu, preferably as a Finder Quick Action, Service, or an equivalent native solution.
2. When I select a file, the action should show that file's full absolute path.
3. When I select a folder, the action should show that folder's full absolute path.
4. The full path should also be copied to the system clipboard automatically.
5. Prefer showing a simple confirmation dialog so I can see what was copied.
6. If multi-selection is supported, copy all selected paths joined by line breaks.
7. Do not only explain the approach. Please provide a complete installable implementation.
8. Prefer a solution that can be installed into `~/Library/Services/` as a macOS Automator `.workflow`, or generate an installation script that creates the workflow automatically.
9. Make sure paths with spaces, non-English characters, and special characters are handled correctly.
10. If Finder does not show the menu item immediately, also explain how to refresh Finder.

Please format the response like this:

1. Short explanation of the implementation approach
2. Full working installation script
3. Installed menu item name
4. Usage instructions
5. Uninstall instructions if needed

Please provide executable content, not pseudocode.

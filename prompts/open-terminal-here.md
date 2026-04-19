# Prompt: Open Terminal From Finder

Please help me build a macOS Finder right-click action named `Open Terminal`.

Goal: when I work inside Finder, I want to open Terminal from the context menu and automatically land in the correct directory.

Requirements:

1. The feature must be integrated into the macOS Finder right-click menu, preferably as a Finder Quick Action, Service, or an equivalent native solution.
2. If I select a file, Terminal should open in that file's parent directory.
3. If I select a folder, Terminal should open in that folder itself.
4. If I do not select anything and trigger the action from the blank area of the current Finder window, Terminal should open in the directory currently shown by Finder.
5. The implementation must handle paths with spaces, non-English characters, and special characters correctly.
6. Prefer a solution that can be installed into `~/Library/Services/` as a macOS Automator `.workflow`, or generate an installation script that creates the workflow automatically.
7. Please provide a complete executable implementation, not just a description of the idea.
8. If Finder does not show the menu item immediately, also include how to refresh Finder.

Please format the response like this:

1. Short implementation overview
2. Full installation script
3. Installed menu item name
4. Behavior details
5. Uninstall instructions

Assume the target terminal app is the built-in macOS Terminal.

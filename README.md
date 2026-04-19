# Finder Quick Actions Prompts

`finder-quick-actions-prompts` 是一个面向 macOS Finder 右键菜单的小型提示词项目。

它把两个高频小工具整理成了可复用的 AI 提示词，方便其他用户直接把提示词交给 Codex、ChatGPT、Claude 或其他代码助手，快速生成自己的 Finder 快速操作工具。

这个项目的出发点很简单：现在很多人在 Mac 上配合 AI 工作时，经常会反复做两件小事：

1. 打开一个 Terminal
2. 找到当前文件或目录的完整路径

这两个动作看起来很小，但每天会重复很多次。这个项目把它们做成 Finder 右键菜单里的两个小补丁，尽量减少来回切换和手动复制路径的成本。

当前包含：

1. `显示并复制完整路径`
   选中文件或文件夹后，在 Finder 右键菜单中显示完整路径，并自动复制到剪贴板。
2. `打开 Terminal`
   在 Finder 中根据当前选择或当前目录，直接打开 Terminal 并切换到目标目录。

## 项目结构

- [prompts/show-and-copy-full-path.md](/Users/hao/finder-quick-actions-prompts/prompts/show-and-copy-full-path.md)
- [prompts/open-terminal-here.md](/Users/hao/finder-quick-actions-prompts/prompts/open-terminal-here.md)
- [scripts/install_full_path_quick_action.sh](/Users/hao/finder-quick-actions-prompts/scripts/install_full_path_quick_action.sh)
- [scripts/install_open_terminal_quick_action.sh](/Users/hao/finder-quick-actions-prompts/scripts/install_open_terminal_quick_action.sh)

## 如何使用这些提示词

1. 打开你常用的 AI 编程助手。
2. 复制 `prompts/` 目录中的对应提示词。
3. 让它在你的 Mac 上生成 Finder 快速操作工作流。
4. 按提示安装到 `~/Library/Services/`。
5. 刷新 Finder 或重新登录后，在右键菜单中使用。

## 两个提示词的定位

### 1. 显示并复制完整路径

适用于想在 Finder 中快速看到文件绝对路径，并且顺手复制出来的场景。

预期行为：

- 选中文件时可显示该文件完整路径
- 选中文件夹时可显示该文件夹完整路径
- 自动复制到系统剪贴板
- 最好弹窗确认当前复制的内容

### 2. 打开 Terminal

适用于希望从 Finder 直接跳转到命令行工作的场景。

预期行为：

- 选中文件时，Terminal 打开到该文件所在目录
- 选中文件夹时，Terminal 打开到该文件夹
- 未选中任何文件时，Terminal 打开到 Finder 当前显示的目录

## 附带脚本

`scripts/` 中放的是这两个功能的参考实现。它们会在当前用户目录下安装对应的 Finder 工作流。

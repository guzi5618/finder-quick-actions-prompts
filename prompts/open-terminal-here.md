# Prompt: Open Terminal From Finder

请帮我在 macOS 上开发一个 Finder 右键菜单功能，名称叫 `打开 Terminal`。

目标是：我在 Finder 中操作时，可以通过右键快速打开 Terminal，并自动切换到合适的目录。请满足以下规则：

1. 这个功能必须集成到 macOS Finder 的右键菜单中，推荐使用 Finder 快速操作、服务或等效方案。
2. 如果我选中了某个文件，打开 Terminal 时应自动切换到该文件所在的目录。
3. 如果我选中了某个文件夹，打开 Terminal 时应自动切换到该文件夹本身。
4. 如果我没有选中任何文件，而是在 Finder 当前窗口的空白区域触发右键菜单，则 Terminal 应自动切换到当前 Finder 正在显示的目录。
5. 生成的实现必须正确处理带空格、中文、特殊字符的路径。
6. 请优先输出一个可直接安装到 `~/Library/Services/` 的 macOS Automator `.workflow` 方案，或者生成一个安装脚本来自动创建这个工作流。
7. 请直接输出完整可执行实现，不要只解释思路。
8. 如果 Finder 不能立刻显示该菜单项，请附带 Finder 刷新方式。

请按下面的格式输出：

1. 实现思路简介
2. 完整安装脚本
3. 安装后菜单名称
4. 具体行为说明
5. 卸载方式

请默认目标终端是 macOS 自带的 Terminal。

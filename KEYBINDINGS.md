# Neovim 快捷键完全参考手册

> Leader 键 = `Space`  
> 本配置无方向键绑定，所有操作均使用 hjkl  
> 提示：按 `<Space>` 等待片刻可弹出 which-key 菜单查看所有 leader 快捷键

---

## 目录

- [1. 通用操作](#1-通用操作)
- [2. 窗口管理](#2-窗口管理)
- [3. 缓冲区 (Buffer)](#3-缓冲区-buffer)
- [4. 标签页 (Tab)](#4-标签页-tab)
- [5. 文件浏览 / 查找](#5-文件浏览--查找)
- [6. 搜索](#6-搜索)
- [7. LSP / 代码智能](#7-lsp--代码智能)
- [8. 补全 (blink.cmp)](#8-补全-blinkcmp)
- [9. 代码操作](#9-代码操作)
- [10. 诊断 / 问题列表](#10-诊断--问题列表)
- [11. Git](#11-git)
- [12. AI 编程 (Copilot)](#12-ai-编程-copilot)
- [13. 调试 (DAP)](#13-调试-dap)
- [14. 终端](#14-终端)
- [15. Treesitter / 文本对象](#15-treesitter--文本对象)
- [16. 快速跳转 (Flash)](#16-快速跳转-flash)
- [17. 环绕操作 (Surround)](#17-环绕操作-surround)
- [18. 注释](#18-注释)
- [19. 会话管理](#19-会话管理)
- [20. UI 切换](#20-ui-切换)
- [21. Noice 消息](#21-noice-消息)
- [22. 其他工具](#22-其他工具)
- [23. Neovim 原生重要快捷键](#23-neovim-原生重要快捷键)

---

## 1. 通用操作

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `j` / `k` | N, V | 智能上下移动（自动适应折行） | keymaps |
| `<A-j>` | N, I, V | 向下移动当前行 | keymaps |
| `<A-k>` | N, I, V | 向上移动当前行 | keymaps |
| `<C-s>` | N, I, V, S | 保存文件 | keymaps |
| `<Esc>` | N, I | 清除搜索高亮 + Esc | keymaps |
| `<` / `>` | V | 缩进/取消缩进（保持选中） | keymaps |
| `n` / `N` | N, V, O | 始终向前/向后搜索（修正原生行为） | keymaps |
| `gw` | N, V | 搜索光标下单词 | keymaps |
| `,` `.` `;` | I | 输入后创建 undo 断点 | keymaps |
| `jj` / `jk` | I | 退出插入模式（better-escape） | better-escape |
| `<Space>qq` | N | 退出全部 (`:qa`) | keymaps |
| `<Space>fn` | N | 新建文件 | keymaps |
| `<Space>K` | N | 查看光标下关键字帮助 | keymaps |
| `<Space>ur` | N | 重绘屏幕 / 清除搜索高亮 / 刷新 diff | keymaps |

## 2. 窗口管理

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<C-h>` | N | 跳到左侧窗口 | keymaps |
| `<C-j>` | N | 跳到下方窗口 | keymaps |
| `<C-k>` | N | 跳到上方窗口 | keymaps |
| `<C-l>` | N | 跳到右侧窗口 | keymaps |
| `<Space>wk` | N | 增加窗口高度 | keymaps |
| `<Space>wj` | N | 减少窗口高度 | keymaps |
| `<Space>wh` | N | 减少窗口宽度 | keymaps |
| `<Space>wl` | N | 增加窗口宽度 | keymaps |
| `<Space>ww` | N | 跳到上一个窗口 | keymaps |
| `<Space>wd` | N | 关闭当前窗口 | keymaps |
| `<Space>w-` 或 `<Space>-` | N | 水平分割窗口 | keymaps |
| `<Space>w\|` 或 `<Space>\|` | N | 垂直分割窗口 | keymaps |
| `<Space>wm` | N | 最大化当前窗口 | keymaps |
| `<Space>w=` | N | 均分窗口大小 | keymaps |

## 3. 缓冲区 (Buffer)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `S-h` | N | 上一个缓冲区 | bufferline |
| `S-l` | N | 下一个缓冲区 | bufferline |
| `[b` / `]b` | N | 上/下一个缓冲区 | bufferline |
| `[B` / `]B` | N | 将缓冲区向左/右移动 | bufferline |
| `<Space>bb` 或 `` <Space>` `` | N | 切换到上一个缓冲区 (`#`) | keymaps |
| `<Space>bn` | N | 下一个缓冲区 | keymaps |
| `<Space>bd` | N | 删除缓冲区 | mini.bufremove |
| `<Space>bD` | N | 强制删除缓冲区 | mini.bufremove |
| `<Space>bp` | N | 切换固定（Pin） | bufferline |
| `<Space>bP` | N | 删除所有未固定缓冲区 | bufferline |
| `<Space>bo` | N | 删除其他缓冲区 | bufferline |
| `<Space>br` | N | 删除右侧缓冲区 | bufferline |
| `<Space>bl` | N | 删除左侧缓冲区 | bufferline |
| `<Space>be` | N | 缓冲区浏览器（Neo-tree） | neo-tree |

## 4. 标签页 (Tab)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space><Tab><Tab>` | N | 新建标签页 | keymaps |
| `<Space><Tab>d` | N | 关闭标签页 | keymaps |
| `<Space><Tab>]` | N | 下一个标签页 | keymaps |
| `<Space><Tab>[` | N | 上一个标签页 | keymaps |
| `<Space><Tab>l` | N | 最后一个标签页 | keymaps |
| `<Space><Tab>f` | N | 第一个标签页 | keymaps |
| `<Space><Tab>o` | N | 关闭其他标签页 | keymaps |

## 5. 文件浏览 / 查找

### Neo-tree 文件浏览器

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>e` | N | 打开/关闭文件浏览器（工作目录） | neo-tree |
| `<Space>E` | N | 打开/关闭文件浏览器（当前文件目录） | neo-tree |
| `<Space>fe` | N | 同 `<Space>e` | neo-tree |
| `<Space>fE` | N | 同 `<Space>E` | neo-tree |
| `<Space>ge` | N | Git 状态浏览器 | neo-tree |

**Neo-tree 内部快捷键：**

| 快捷键 | 说明 |
|--------|------|
| `l` | 打开文件/展开目录 |
| `h` | 折叠目录 |
| `P` | 预览文件（浮窗） |
| `Y` | 复制文件路径到剪贴板 |
| `a` | 新建文件/目录 |
| `d` | 删除 |
| `r` | 重命名 |
| `c` | 复制 |
| `m` | 移动 |
| `q` | 关闭 |
| `?` | 显示帮助 |

### Telescope 模糊查找

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>ff` | N | 查找文件（工作目录） | telescope |
| `<Space>fF` | N | 查找文件（当前文件目录） | telescope |
| `<Space>fr` | N | 最近打开的文件 | telescope |
| `<Space>fb` | N | 切换缓冲区 | telescope |
| `<Space>fg` | N | 查找 Git 文件 | telescope |

**Telescope 内部快捷键（插入模式下）：**

| 快捷键 | 说明 |
|--------|------|
| `<C-j>` | 下一个历史记录 |
| `<C-k>` | 上一个历史记录 |
| `<C-f>` | 预览向下滚动 |
| `<C-b>` | 预览向上滚动 |
| `<CR>` | 确认选择 |
| `<Esc>` | 关闭（普通模式下按 `q`） |

## 6. 搜索

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>sg` | N | 全局文本搜索 Grep（工作目录） | telescope |
| `<Space>sG` | N | 全局文本搜索 Grep（当前文件目录） | telescope |
| `<Space>sw` | N | 搜索光标下单词（工作目录） | telescope |
| `<Space>sW` | N | 搜索光标下单词（当前文件目录） | telescope |
| `<Space>sb` | N | 当前缓冲区内搜索 | telescope |
| `<Space>ss` | N | 文档符号（LSP） | telescope |
| `<Space>sS` | N | 工作区符号（LSP） | telescope |
| `<Space>sd` | N | 当前文件诊断 | telescope |
| `<Space>sD` | N | 工作区诊断 | telescope |
| `<Space>sh` | N | 帮助页面 | telescope |
| `<Space>sH` | N | 高亮组 | telescope |
| `<Space>sk` | N | 快捷键列表 | telescope |
| `<Space>sm` | N | 标记 (marks) | telescope |
| `<Space>sM` | N | Man 手册 | telescope |
| `<Space>sj` | N | 跳转列表 | telescope |
| `<Space>sl` | N | 位置列表 | telescope |
| `<Space>sq` | N | 快速修复列表 | telescope |
| `<Space>so` | N | Vim 选项 | telescope |
| `<Space>sc` | N | 命令历史 | telescope |
| `<Space>sC` | N | 命令列表 | telescope |
| `<Space>s"` | N | 寄存器 | telescope |
| `<Space>sa` | N | 自动命令 | telescope |
| `<Space>sR` | N | 恢复上次搜索 | telescope |
| `<Space>sr` | N | 搜索替换（Spectre） | spectre |
| `<Space>st` | N | 搜索 TODO 注释 | todo-comments |
| `<Space>sT` | N | 搜索 TODO/FIX/FIXME | todo-comments |

## 7. LSP / 代码智能

> 以下快捷键在 LSP 附加到缓冲区时生效（buffer-local）

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `gd` | N | 跳转到定义 | lsp |
| `gr` | N | 查看引用 | lsp |
| `gD` | N | 跳转到声明 | lsp |
| `gI` | N | 跳转到实现 | lsp |
| `gy` | N | 跳转到类型定义 | lsp |
| `K` | N | 悬停文档 | lsp |
| `gK` | N | 签名帮助 | lsp |
| `<C-k>` | I | 签名帮助（插入模式） | lsp |
| `<Space>ca` | N, V | 代码操作 | lsp |
| `<Space>cA` | N | 源代码操作 | lsp |
| `<Space>cr` | N | 重命名 | lsp |
| `<Space>cl` | N | LSP 信息 | lsp |
| `<Space>cm` | N | 打开 Mason（管理 LSP/DAP/工具） | mason |
| `<Space>cv` | N | 选择虚拟环境 (Python) | venv-selector |
| `<Space>cC` | N | 选择缓存的虚拟环境 (Python) | venv-selector |
| `<Space>cd` | N | 行内诊断详情 | keymaps |

## 8. 补全 (blink.cmp)

> 以下快捷键在插入模式下生效

| 快捷键 | 说明 |
|--------|------|
| `<C-Space>` | 手动触发补全 / 切换文档显示 |
| `<C-n>` | 选择下一项 |
| `<C-p>` | 选择上一项 |
| `<CR>` | 确认补全 |
| `<C-e>` | 取消/隐藏补全 |
| `<Tab>` | 代码片段跳转到下一占位符 |
| `<S-Tab>` | 代码片段跳转到上一占位符 |
| `<C-f>` | 补全文档向下滚动 |
| `<C-b>` | 补全文档向上滚动 |

> **滚动级联说明：** `<C-f>`/`<C-b>` 在补全菜单文档 → LSP 悬停文档 → 原生翻页之间智能级联。

## 9. 代码操作

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>ca` | N, V | 代码操作 | lsp |
| `<Space>cA` | N | 源代码操作 | lsp |
| `<Space>cr` | N | 重命名符号 | lsp |
| `<Space>cF` | N, V | 格式化注入的代码 | conform |
| `<Space>cs` | N | 符号列表（Trouble） | trouble |
| `<Space>cS` | N | LSP 引用/定义（Trouble） | trouble |
| `<Space>cl` | N | LSP 信息 | lsp |
| `<Space>cm` | N | Mason 包管理 | mason |
| `<Space>cv` | N | 选择虚拟环境 (Python) | venv-selector |
| `<Space>cC` | N | 选择缓存的虚拟环境 (Python) | venv-selector |

## 10. 诊断 / 问题列表

### 诊断导航

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `]d` / `[d` | N | 下/上一个诊断 | keymaps |
| `]e` / `[e` | N | 下/上一个错误 | keymaps |
| `]w` / `[w` | N | 下/上一个警告 | keymaps |
| `<Space>cd` | N | 显示行内诊断浮窗 | keymaps |

### Trouble 问题列表

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>xx` | N | 工作区诊断（Trouble） | trouble |
| `<Space>xX` | N | 当前缓冲区诊断（Trouble） | trouble |
| `<Space>xl` | N | 位置列表 | keymaps |
| `<Space>xq` | N | 快速修复列表 | keymaps |
| `<Space>xL` | N | 位置列表（Trouble） | trouble |
| `<Space>xQ` | N | 快速修复列表（Trouble） | trouble |
| `<Space>xt` | N | TODO 列表（Trouble） | todo-comments |
| `<Space>xT` | N | TODO/FIX/FIXME（Trouble） | todo-comments |
| `[q` / `]q` | N | 上/下一个 Trouble/Quickfix 项 | trouble |

### TODO 注释导航

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `]t` / `[t` | N | 下/上一个 TODO 注释 | todo-comments |

## 11. Git

### Hunk 导航与操作 (gitsigns)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `]h` / `[h` | N | 下/上一个变更块 (hunk) | gitsigns |
| `]H` / `[H` | N | 最后/第一个变更块 | gitsigns |
| `<Space>ghs` | N, V | 暂存变更块 | gitsigns |
| `<Space>ghr` | N, V | 重置变更块 | gitsigns |
| `<Space>ghS` | N | 暂存整个缓冲区 | gitsigns |
| `<Space>ghu` | N | 撤销暂存 | gitsigns |
| `<Space>ghR` | N | 重置整个缓冲区 | gitsigns |
| `<Space>ghp` | N | 行内预览变更块 | gitsigns |
| `<Space>ghb` | N | 显示当前行 Blame | gitsigns |
| `<Space>ghB` | N | 显示缓冲区 Blame | gitsigns |
| `<Space>ghd` | N | Diff 当前文件 | gitsigns |
| `<Space>ghD` | N | Diff 当前文件 (~) | gitsigns |
| `ih` | O, V | 选择变更块（文本对象） | gitsigns |

### LazyGit

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>gg` | N | 打开 LazyGit | lazygit |
| `<Space>gG` | N | LazyGit（当前文件） | lazygit |
| `<Space>gl` | N | LazyGit 提交日志 | lazygit |
| `<Space>gL` | N | LazyGit 提交日志（当前文件） | lazygit |

### Diffview

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>gd` | N | 打开 Diffview | diffview |
| `<Space>gD` | N | 关闭 Diffview | diffview |
| `<Space>gf` | N | 文件历史（当前文件） | diffview |
| `<Space>gF` | N | 文件历史（全部） | diffview |

## 12. AI 编程 (Copilot)

### 核心建议 (Ghost Text)

这些快捷键仅在你处于**插入模式 (Insert Mode)** 且有 Copilot 透明文字提示时生效。

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<M-l>` | I | 接受整个 Copilot 补全建议 | copilot.lua |
| `<M-w>` | I | 仅接受建议中的下一个词/词组 | copilot.lua |
| `<M-]>` | I | 切换到**下一个**可用建议 | copilot.lua |
| `<M-[>` | I | 切换到**上一个**可用建议 | copilot.lua |
| `<C-]>` | I | 隐藏/放弃当前建议 | copilot.lua |

### Copilot Chat 会话

可以像使用 ChatGPT 一样选中文本与大模型进行交互。选中多行代码后按以下快捷键效果极佳。

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>pc` | N, V | 打开/隐藏 Copilot Chat 侧边栏 | CopilotChat |
| `<Space>pe` | N, V | 让 AI 解释 (Explain) 选中/当前区域代码 | CopilotChat |
| `<Space>pr` | N, V | 让 AI 审查 (Review) 选中代码并提出意见 | CopilotChat |
| `<Space>pf` | N, V | 让 AI 帮你修复 (Fix) 找出的隐患/Bug | CopilotChat |
| `<Space>po` | N, V | 优化 (Optimize) 选中的代码块 | CopilotChat |
| `<Space>pd` | N, V | 自动为高亮代码生成注释/文档 (Docs) | CopilotChat |
| `<Space>pt` | N, V | 自动生成单元测试 (Tests) | CopilotChat |
| `<Space>pm` | N | 用 AI 分析 Git 差异并生成 Commit Message | CopilotChat |

## 13. 调试 (DAP)

### 调试控制

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<F5>` | N | 继续 / 启动调试 | dap |
| `<F9>` | N | 切换断点 | dap |
| `<F10>` | N | 单步跳过 (Step Over) | dap |
| `<F11>` | N | 单步步入 (Step Into) | dap |
| `<S-F11>` | N | 单步跳出 (Step Out) | dap |
| `<Space>dc` | N | 继续 | dap |
| `<Space>da` | N | 带参数运行 | dap |
| `<Space>db` | N | 切换断点 | dap |
| `<Space>dB` | N | 条件断点 | dap |
| `<Space>dC` | N | 运行到光标 | dap |
| `<Space>dg` | N | 跳转到行（不执行） | dap |
| `<Space>di` | N | 步入 (Step Into) | dap |
| `<Space>do` | N | 步出 (Step Out) | dap |
| `<Space>dO` | N | 步过 (Step Over) | dap |
| `<Space>dp` | N | 暂停 | dap |
| `<Space>dt` | N | 终止调试 | dap |
| `<Space>dl` | N | 重新运行上次 | dap |
| `<Space>dj` | N | 调用栈向下 (Down) | dap |
| `<Space>dk` | N | 调用栈向上 (Up) | dap |
| `<Space>dr` | N | 切换 REPL | dap |
| `<Space>ds` | N | 查看会话 | dap |
| `<Space>dw` | N | 悬停查看变量 | dap |

### 调试 UI

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>du` | N | 切换 DAP UI | dap-ui |
| `<Space>de` | N, V | 求值表达式 | dap-ui |

### Python 调试

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>dPt` | N | 调试当前方法 (Python) | dap-python |
| `<Space>dPc` | N | 调试当前类 (Python) | dap-python |

## 13. 终端

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `` <C-\> `` | N | 切换浮动终端 | toggleterm |
| `<Space>tf` | N | 浮动终端 | toggleterm |
| `<Space>th` | N | 水平终端 | toggleterm |
| `<Space>tv` | N | 垂直终端 | toggleterm |
| `<Space>tt` | N | 切换终端 | toggleterm |

**终端模式内快捷键：**

| 快捷键 | 说明 |
|--------|------|
| `<Esc><Esc>` | 退出终端模式（回到普通模式） |
| `<C-h>` | 跳到左侧窗口 |
| `<C-j>` | 跳到下方窗口 |
| `<C-k>` | 跳到上方窗口 |
| `<C-l>` | 跳到右侧窗口 |
| `<C-w>` | 进入窗口命令模式 |

## 14. Treesitter / 文本对象

### 增量选择

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<C-Space>` | N | 初始化/扩大选择区域 | treesitter |
| `<BS>` | V | 缩小选择区域 | treesitter |

### 文本对象导航

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `]f` / `[f` | N | 下/上一个函数开头 | treesitter-textobjects |
| `]F` / `[F` | N | 下/上一个函数结尾 | treesitter-textobjects |
| `]c` / `[c` | N | 下/上一个类开头 | treesitter-textobjects |
| `]C` / `[C` | N | 下/上一个类结尾 | treesitter-textobjects |
| `]a` / `[a` | N | 下/上一个参数 | treesitter-textobjects |
| `]A` / `[A` | N | 下/上一个参数结尾 | treesitter-textobjects |
| `]]` / `[[` | N | 下/上一个引用（光标下单词） | vim-illuminate |

### mini.ai 文本对象

> 配合 `a`（around，包含周围）和 `i`（inside，仅内部）使用  
> 例如：`daf` = 删除整个函数，`cic` = 更改类内部

| 文本对象 | 说明 |
|----------|------|
| `f` | 函数 |
| `c` | 类 |
| `o` | 代码块 (block/conditional/loop) |
| `a` | 参数 |
| `t` | HTML/XML 标签 |
| `d` | 数字 |
| `e` | 单词（驼峰分段） |
| `u` | 函数调用 |
| `U` | 函数调用（不含点号） |
| `q` | 引号（原生） |
| `b` / `B` | 括号 / 大括号（原生） |

## 15. 快速跳转 (Flash)

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `s` | N, V, O | Flash 跳转 | flash |
| `S` | N, V, O | Flash Treesitter 选择 | flash |
| `r` | O | 远程 Flash（Operator-pending） | flash |
| `R` | O, V | Treesitter 搜索 | flash |
| `<C-s>` | C | 在搜索中切换 Flash | flash |

## 16. 环绕操作 (Surround)

> nvim-surround 快捷键

| 快捷键 | 模式 | 说明 |
|--------|------|------|
| `ys{motion}{char}` | N | 添加环绕字符。例如 `ysiw"` = 给单词加引号 |
| `ds{char}` | N | 删除环绕字符。例如 `ds"` = 删除引号 |
| `cs{old}{new}` | N | 替换环绕字符。例如 `cs"'` = 引号换单引号 |
| `yss{char}` | N | 给整行添加环绕 |
| `S{char}` | V | 给选中区域添加环绕 |

## 17. 注释

> Comment.nvim 快捷键

| 快捷键 | 模式 | 说明 |
|--------|------|------|
| `gcc` | N | 切换行注释 |
| `gbc` | N | 切换块注释 |
| `gc` | V | 切换选中区域行注释 |
| `gb` | V | 切换选中区域块注释 |
| `gcO` | N | 在上方插入注释 |
| `gco` | N | 在下方插入注释 |
| `gcA` | N | 在行尾追加注释 |

## 18. 会话管理

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>qs` | N | 恢复当前目录的会话 | persistence |
| `<Space>qS` | N | 选择会话 | persistence |
| `<Space>ql` | N | 恢复上次会话 | persistence |
| `<Space>qd` | N | 停止保存当前会话 | persistence |

## 19. UI 切换

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>uf` | N | 切换自动格式化 | keymaps |
| `<Space>us` | N | 切换拼写检查 | keymaps |
| `<Space>uw` | N | 切换自动换行 | keymaps |
| `<Space>ul` | N | 切换行号 | keymaps |
| `<Space>uL` | N | 切换相对行号 | keymaps |
| `<Space>ud` | N | 切换诊断显示 | keymaps |
| `<Space>uc` | N | 切换 conceal level | keymaps |
| `<Space>uh` | N | 切换内联提示 (Inlay Hints) | lsp |
| `<Space>uC` | N | 运行 CodeLens | lsp |
| `<Space>ut` | N | 切换 Treesitter 上下文（粘性滚动） | treesitter-context |
| `<Space>uu` | N | 切换 Undotree | undotree |
| `<Space>un` | N | 关闭所有通知 | notify |
| `<Space>ui` | N | 检查光标下高亮 | keymaps |
| `<Space>uI` | N | 检查语法树 | keymaps |
| `<Space>ur` | N | 重绘/清除/刷新 | keymaps |
| `<Space>?` | N | 显示缓冲区本地快捷键 (which-key) | which-key |

## 20. Noice 消息

| 快捷键 | 模式 | 说明 | 来源 |
|--------|------|------|------|
| `<Space>snl` | N | 上一条 Noice 消息 | noice |
| `<Space>snh` | N | Noice 历史 | noice |
| `<Space>sna` | N | Noice 全部消息 | noice |
| `<Space>snd` | N | 关闭所有消息 | noice |
| `<Space>snt` | N | Noice 选择器（Telescope） | noice |
| `<S-Enter>` | C | 重定向命令输出 | noice |
| `<C-f>` | I, N, S | LSP 文档向下滚动 | noice |
| `<C-b>` | I, N, S | LSP 文档向上滚动 | noice |

## 21. 其他工具

| 快捷键 | 说明 | 来源 |
|--------|------|------|
| `:Lazy` | 打开 lazy.nvim 插件管理器 | lazy.nvim |
| `:Mason` | 打开 Mason 包管理器 | mason |
| `:StartupTime` | 启动时间分析 | vim-startuptime |
| `:ConformInfo` | 格式化器信息 | conform |
| `:checkhealth` | 健康检查 | neovim |

## 22. Neovim 原生重要快捷键

> 以下为 Neovim 内建快捷键，不在配置中定义但非常常用

### 移动

| 快捷键 | 说明 |
|--------|------|
| `h` / `j` / `k` / `l` | 左 / 下 / 上 / 右 |
| `w` / `b` | 下一个 / 上一个单词 |
| `e` / `ge` | 到单词末尾 / 上一个单词末尾 |
| `W` / `B` / `E` | 同上（以空格分隔的 WORD） |
| `0` / `$` | 行首 / 行尾 |
| `^` | 行首第一个非空字符 |
| `gg` / `G` | 文件首 / 文件尾 |
| `{` / `}` | 上/下一个空行 |
| `%` | 跳转到匹配的括号 |
| `f{char}` / `F{char}` | 向前/向后找字符 |
| `t{char}` / `T{char}` | 向前/向后到字符前 |
| `;` / `,` | 重复/反向重复 f/t |
| `<C-u>` / `<C-d>` | 向上/下翻半页 |
| `<C-o>` / `<C-i>` | 跳回/跳进（跳转列表） |
| `H` / `M` / `L` | 屏幕顶/中/底 |
| `zz` / `zt` / `zb` | 当前行居中/顶/底 |

### 编辑

| 快捷键 | 说明 |
|--------|------|
| `i` / `a` | 在光标前/后进入插入 |
| `I` / `A` | 在行首/行尾进入插入 |
| `o` / `O` | 下方/上方新建行并插入 |
| `x` / `X` | 删除光标处/前一个字符 |
| `dd` | 删除整行 |
| `D` | 从光标删到行尾 |
| `cc` | 修改整行 |
| `C` | 从光标修改到行尾 |
| `yy` | 复制整行 |
| `p` / `P` | 在光标后/前粘贴 |
| `u` / `<C-r>` | 撤销 / 重做 |
| `.` | 重复上一次操作 |
| `~` | 切换大小写 |
| `J` | 合并下一行 |
| `=` | 自动缩进（配合动作） |

### 搜索

| 快捷键 | 说明 |
|--------|------|
| `/` / `?` | 向前/向后搜索 |
| `*` / `#` | 搜索光标下单词（向前/向后） |
| `n` / `N` | 下一个/上一个搜索结果（已被本配置优化） |

### 标记

| 快捷键 | 说明 |
|--------|------|
| `m{a-z}` | 设置局部标记 |
| `m{A-Z}` | 设置全局标记 |
| `` `{mark} `` | 跳转到标记 |
| `'{mark}` | 跳转到标记所在行 |

### 寄存器

| 快捷键 | 说明 |
|--------|------|
| `"{reg}` | 指定寄存器（如 `"ayy` 复制到 a） |
| `"+` | 系统剪贴板寄存器 |
| `"0` | 上一次复制的内容 |
| `<C-r>{reg}` | 在插入模式下粘贴寄存器内容 |

### 折叠

| 快捷键 | 说明 |
|--------|------|
| `za` | 切换折叠 |
| `zo` / `zc` | 打开/关闭折叠 |
| `zR` / `zM` | 打开/关闭所有折叠 |

### 宏

| 快捷键 | 说明 |
|--------|------|
| `q{a-z}` | 录制宏到寄存器 |
| `q` | 停止录制 |
| `@{a-z}` | 执行宏 |
| `@@` | 重复上一次宏 |

---

## Leader 键快速查找表

| 前缀 | 分组 | 说明 |
|------|------|------|
| `<Space>b` | Buffer | 缓冲区操作 |
| `<Space>c` | Code | 代码操作（LSP / 格式化 / Trouble） |
| `<Space>d` | Debug | 调试（DAP） |
| `<Space>dP` | Debug Python | Python 调试 |
| `<Space>e` | Explorer | 文件浏览器 |
| `<Space>f` | File/Find | 文件查找 |
| `<Space>g` | Git | Git 操作 |
| `<Space>gh` | Git Hunks | Git 变更块操作 |
| `<Space>q` | Quit/Session | 退出 / 会话管理 |
| `<Space>s` | Search | 搜索 |
| `<Space>sn` | Noice | Noice 消息 |
| `<Space>t` | Terminal | 终端 |
| `<Space>u` | UI | 界面切换 |
| `<Space>w` | Windows | 窗口管理 |
| `<Space>x` | Diagnostics | 诊断 / 问题列表 |
| `<Space><Tab>` | Tabs | 标签页 |

---

## [ / ] 导航快速查找表

| 快捷键 | 说明 |
|--------|------|
| `]b` / `[b` | 下/上一个缓冲区 |
| `]B` / `[B` | 移动缓冲区右/左 |
| `]d` / `[d` | 下/上一个诊断 |
| `]e` / `[e` | 下/上一个错误 |
| `]w` / `[w` | 下/上一个警告 |
| `]h` / `[h` | 下/上一个 Git 变更块 |
| `]H` / `[H` | 最后/第一个 Git 变更块 |
| `]q` / `[q` | 下/上一个 Quickfix/Trouble 项 |
| `]t` / `[t` | 下/上一个 TODO |
| `]f` / `[f` | 下/上一个函数 |
| `]c` / `[c` | 下/上一个类 |
| `]a` / `[a` | 下/上一个参数 |
| `]]` / `[[` | 下/上一个引用 |

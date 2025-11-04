# 更新日志 | Changelog

All notable changes to this project will be documented in this file.

## [2.3.6] - 2024-11-07

### 🔧 Critical Bug Fixes | 重要问题修复
- **修复游戏模式钢琴键无声音问题** ✅
  - 问题根源：音频文件名映射错误（使用C4.mp3而实际文件是a60.mp3）
  - 修复方案：更新Tone.Sampler使用正确的MIDI编号文件名
  - 白键映射：C4→a60, D4→a62, E4→a64, F4→a65, G4→a67, A4→a69, B4→a71, C5→a72, D5→a74
  - 黑键映射：F#4→b66, G#4→b68, C#5→b73（缺失的黑键使用相近音符）
  - 添加onerror错误处理回调
  - 现在钢琴键声音正常播放！

- **修复手机端开始按钮不可见问题** ✅
  - 增大开始按钮尺寸：width 85%, max-width 350px, font-size 1.3em
  - 增加底部内边距：padding-bottom 60-80px（不同屏幕尺寸）
  - 确保滚动可用：overflow-y: auto, -webkit-overflow-scrolling: touch
  - 增强视觉效果：绿色渐变背景 + 阴影效果
  - 在所有手机上开始按钮现在都清晰可见！

- **修复手机端音符不可见问题** ✅
  - Canvas明确设置：width/height 100% + display: block
  - 增加Canvas最小高度：移动端 min-height 250-280px
  - 增强音符亮度：从0.9提升到0.95透明度
  - 添加音符边框：2px彩色描边增强可见性
  - 增强键盘标签：更大的黄色提示（32x26px）+ 黑色边框
  - 增强轨道线：从0.1/1px提升到0.15/2px
  - 添加调试日志：每秒输出可见音符数量
  - 音符现在在所有手机上都清晰可见！

### 🎨 Mobile CSS Optimization | 移动端CSS优化
- **通用移动端（max-width: 768px）**
  - Canvas区域：min-height 250px, max-height 60vh
  - 开始按钮：width 85%, font-size 1.3em, 绿色渐变
  - 底部内边距：60px确保按钮可见

- **超小屏手机（max-width: 400px）**
  - 开始按钮：width 90%, font-size 1.2em
  - Canvas区域：min-height 200px, max-height 50vh
  - 更紧凑的布局

- **竖屏模式（portrait）**
  - Canvas区域：min-height 280px, max-height 55vh
  - 底部内边距：80px确保充足滚动空间

- **横屏模式（landscape）**
  - 优化水平空间利用
  - 虚拟钢琴高度70px（竖屏100px）

### 🔧 Technical Improvements | 技术改进
- **音频引擎改进**
  - 正确的MIDI编号文件名映射（a=白键, b=黑键）
  - 添加onerror错误处理
  - 缺失音符使用相近音符替代

- **Canvas渲染增强**
  - 明确设置Canvas尺寸和显示样式
  - 增强音符视觉效果（亮度、边框、阴影）
  - 添加可见音符计数日志
  - 改进屏幕旋转和调整大小处理

- **响应式设计优化**
  - 针对4种屏幕尺寸专门优化
  - 所有元素在所有设备上可见可点击
  - 触摸区域最小44x44px

### 📚 Documentation | 文档更新
- 📖 新增 `test_fixes.html` - 修复测试报告页面
  - 详细的问题描述和修复方案
  - 完整的测试步骤
  - 版本信息和已知问题

### ⚠️ Known Issues | 已知问题
- 主页换背景功能缺失（需要Vue源码才能修复）

## [2.3.5] - 2024-11-06

### 🐛 Critical Bug Fixes | 重要问题修复
- **修复游戏模式键盘按键完全无响应问题** ✅
  - 移除键盘事件监听器中的错误条件判断
  - 之前的条件 `if (!gameState.isPlaying || gameState.isPaused) return;` 导致游戏未开始时键盘完全不响应
  - 现在键盘在任何时候都可以使用（试音、游戏中、暂停时）
  - 修复后试音功能正常工作

- **修复游戏中按键总是判定为 Miss 的问题** ✅
  - 放宽判定窗口，使游戏更容易上手
  - 简单模式：Perfect 150ms, Good 300ms（原80ms/150ms）
  - 普通模式：Perfect 120ms, Good 250ms（原60ms/120ms）
  - 困难模式：Perfect 80ms, Good 180ms（原40ms/100ms）
  - 判定窗口扩大约2倍，大幅改善游戏体验

- **重构按键处理逻辑** ✅
  - onKeyPress 函数现在无论游戏状态如何都会播放声音
  - 只在游戏进行中才进行音符判定
  - 统一了试音和游戏内按键的处理流程
  - 保证每次按键都有即时的声音和视觉反馈

### 🔧 Technical Improvements | 技术改进
- **增强调试日志**
  - 按键时输出当前游戏状态（Playing、Paused）
  - 判定时显示当前时间和音符时间
  - 显示判定窗口和时间差
  - 显示判定结果（Perfect/Good/Miss）
  - 便于开发者和用户诊断问题

- **优化代码逻辑**
  ```javascript
  // 修改前：键盘事件直接return，阻止试音
  document.addEventListener('keydown', (e) => {
      if (!gameState.isPlaying || gameState.isPaused) return;
      // ...
  });
  
  // 修改后：始终调用onKeyPress，由函数内部处理
  document.addEventListener('keydown', (e) => {
      // 移除条件限制，允许任何时候响应键盘
      // ...
  });
  ```

### 📚 Documentation | 文档更新
- 📖 新增 `test-game-fix.html` - 修复测试报告页面
  - 详细的问题诊断
  - 修复方案说明
  - 完整的测试清单
  - 技术细节和预期效果

### 🎮 User Experience | 用户体验
- ✅ 试音功能完全正常 - 开始界面就可以测试钢琴声音
- ✅ 游戏判定更宽容 - 新手也能轻松上手
- ✅ 声音反馈即时 - 每次按键都有声音
- ✅ 调试信息完善 - 控制台有详细日志
- ✅ 视觉反馈清晰 - 钢琴键高亮效果

## [2.3.4] - 2024-11-06

### 🐛 Critical Bug Fixes | 重要问题修复
- **修复移动端开始界面显示问题** ✅
  - 开始界面改为可滚动（overflow-y: auto）
  - 调整布局使所有内容可见
  - 开始游戏按钮增大并居中显示
  - 确保在小屏幕设备上完全可访问

- **修复游戏模式钢琴键无声音问题** ✅
  - 添加音频初始化函数 `initAudio()`
  - 在用户首次交互时自动初始化 Tone.js
  - 允许游戏开始前就可以试音
  - 优化音频上下文启动流程

- **优化按键映射可视化** ✅
  - 虚拟钢琴键上显示清晰的键盘按键标签
  - 下落音符上显示对应的键盘字母（大号黄色背景）
  - 重新设计钢琴键显示结构（音符名 + 键盘按键）
  - 移动端针对性优化按键标签大小

### 🎨 UI/UX Improvements | 界面改进
- **钢琴键标签优化**
  - 添加 `.key-label` 类显示音符名称（Do、Re、Mi等）
  - 添加 `.key-binding` 类显示键盘按键（黄色背景高亮）
  - 针对白键和黑键分别优化字体大小
  - 移动端、平板、桌面分别适配

- **音符显示增强**
  - 音符上的按键提示字体增大到20px bold
  - 黄色背景方块 + 黑色字母，清晰可见
  - Canvas渲染优化，确保文字居中对齐

- **游戏说明更新**
  - 更清晰的操作说明
  - 添加"试音"提示，鼓励用户在开始前测试钢琴键
  - 明确说明"音符上的字母 = 键盘按键"

### 🔧 Technical Improvements | 技术改进
- **音频初始化机制**
  ```javascript
  async function initAudio() {
      if (!audioInitialized) {
          await Tone.start();
          audioInitialized = true;
      }
  }
  ```
  - 监听 click 和 touchstart 事件自动初始化
  - 在按键处理函数中确保音频已启动
  - 支持游戏外试音功能

- **钢琴键HTML结构优化**
  ```html
  <div class="key-label">Do</div>
  <div class="key-binding">A</div>
  ```
  - 使用flex布局垂直排列
  - 分离音符名称和按键显示
  - 更好的响应式支持

### 📱 Mobile Optimization | 移动端优化
- 所有屏幕尺寸的按键标签优化
  - 超小屏幕（<400px）
  - 移动端（<768px）
  - 横屏模式
  - 平板（768-1024px）
- 开始游戏按钮宽度80%，最大300px
- 最小触摸区域50px高度
- 改进滚动体验

### 📚 Documentation | 文档更新
- 📖 新增 `GAME-MODE-FIX-NOTES.md` - 详细的修复说明
- 包含完整的测试清单
- 技术细节和实现说明
- 快速测试指南

## [2.3.3] - 2024-11-05

### 📱 Mobile Optimization | 移动端优化
- **主页钢琴移动端优化** - 大幅改善移动设备体验
  - 新增 `piano-mobile.css` 专属移动端样式
  - 增大钢琴键尺寸：白键 45-50px，黑键 30-35px
  - 优化触摸交互，最小触摸区域 44x44px
  - 钢琴键盘支持横向滚动，查看完整键盘
  - 横屏/竖屏模式分别优化
  - 改进控制按钮大小和间距
  - 优化曲谱列表在移动端的显示

- **游戏模式移动端优化** - 修复关键问题并优化体验
  - ✅ **修复音符对齐问题** - 音符轨道和虚拟钢琴键盘完全对齐！
  - 新增 `game-mobile.css` 游戏模式专属移动端样式
  - 添加轨道辅助线，方便看清音符下落路径
  - 优化 Canvas 自适应屏幕大小
  - 增大虚拟钢琴键盘尺寸，方便触摸操作
  - 横屏模式体验大幅改善（推荐使用）
  - 竖屏模式空间分配优化
  - 添加移动端检测和横屏建议提示
  - 支持屏幕旋转自动适配

### 🔧 Technical Fixes | 技术修复
- **虚拟钢琴键盘对齐算法重构**
  - 使用统一的 `laneWidth` 和 `startX` 计算
  - 白键位置 = `lane * laneWidth`
  - 黑键位置 = `lane * laneWidth - blackKeyWidth / 2`
  - Canvas 音符位置 = `startX + lane * laneWidth + laneWidth / 2`
  - 确保音符和按键完美对齐

- **响应式 Canvas 优化**
  - 监听 `resize` 和 `orientationchange` 事件
  - 自动调整 Canvas 尺寸和分辨率
  - 动态重新计算虚拟钢琴键盘位置
  - 添加延迟处理确保布局更新完成

### 🎨 UI/UX Improvements | 界面改进
- 🎯 轨道辅助线 - 半透明竖线显示音符轨道
- 📱 移动端横屏提示 - 竖屏小屏幕会显示"建议横屏游玩"
- ✨ 改进游戏说明文字，添加 emoji 图标
- 🎹 优化触摸反馈效果
- 📊 优化分数和统计显示在小屏幕的布局

### 📚 Documentation | 文档更新
- 📖 新增 `MOBILE-TEST.md` - 移动端测试指南
  - 详细的测试步骤和检查清单
  - 不同屏幕尺寸测试方案
  - 已知问题和解决方案
  - 操作建议和最佳实践

### 🎮 Game Mode Updates | 游戏模式更新
- 改进游戏说明文字，更清晰明了
- 添加"音符轨道和钢琴键盘完全对齐"的提示
- 优化移动端的判定显示大小
- 改进触摸操作的响应性

### 📐 Responsive Enhancements | 响应式增强
- **超小屏** (<400px): 极致紧凑布局
- **小屏** (400-600px): 优化布局和字体
- **中屏** (600-768px): 平衡体验
- **横屏** (landscape): 充分利用水平空间
- **竖屏** (portrait): 优化垂直空间分配

### 🔍 Browser Compatibility | 浏览器兼容
- ✅ iOS Safari - 支持安全区域适配
- ✅ Android Chrome - 优化触摸体验
- ✅ 微信内置浏览器 - 测试通过
- ✅ 防止字体缩放 (iOS)
- ✅ 防止下拉刷新

## [2.3.2] - 2024-11-04

### 🎮 Game Mode Improvements | 游戏模式改进
- **新增更多歌曲** - 游戏模式现在支持 15 首歌曲
  - 添加：后来、时间煮雨、蒲公英的约定、下一个天亮、海角七号、牢不可破的联盟
  - 所有歌曲均来自 static/xmlscore/ 目录
  
- **增强调试和错误处理** - 大幅改进用户体验
  - 详细的控制台日志输出（emoji 标记便于识别）
  - 改进的加载状态提示（"⏳ 加载中..."）
  - 显示音符解析详情（总数、支持数、不支持音符列表）
  - 更友好的错误消息（针对 404、JSON 错误、格式错误）
  - 完整的加载流程日志（URL、HTTP 状态、measures 数量等）
  
- **音符解析优化** - 更智能的音符处理
  - 显示总音符数和可用音符数
  - 列出不支持的音符（超出 C4-D5 范围）
  - 难度配置日志输出
  - 音符限制信息提示

### 🗑️ Removed | 移除功能
- **移除跟随模式** - 根据用户反馈简化功能
  - 删除 follow-along.html
  - 删除 FOLLOW-ALONG-GUIDE.md
  - 从导航栏移除跟随模式链接
  - 更新文档移除相关引用
  
### 📚 Documentation | 文档更新
- 更新 README.md - 移除跟随模式引用，更新导航说明
- 更新所有文档中的模式列表

### 🔧 Technical Details | 技术改进
- 改进的 `loadSongData()` 函数，包含详细日志
- 改进的 `parseSongToNotes()` 函数，显示解析统计
- 更好的异步错误处理
- 用户友好的错误分类和提示

## [2.3.1] - 2024-11-04

### 🐛 Bug Fixes | 修复问题
- **主页钢琴音频修复** - 修复主页钢琴没有声音的问题
  - 在 `index.html` 中添加 Tone.js CDN 引用
  - 添加自动音频初始化脚本，在用户首次交互时初始化 Tone.js
  - 解决浏览器自动播放策略限制
  
- **游戏模式加载改进** - 改进歌曲加载体验
  - 增强错误处理，提供详细的错误信息
  - 添加加载状态提示（按钮显示"加载中..."）
  - 添加控制台调试日志，便于排查问题
  - 验证 HTTP 响应状态码和 JSON 数据格式
  - 改进用户反馈，明确告知错误原因

### 📚 Documentation | 文档更新
- 🔧 新增 `TROUBLESHOOTING.md` - 详细的问题排查指南
  - 主页钢琴音频问题的完整解决方案
  - 游戏模式歌曲加载失败的排查步骤
  - 常见问题和解决方案
  - 调试技巧和工具使用
  - 技术细节说明
- 📝 更新 README.md - 添加问题排查指南链接

### 🔧 Technical Details | 技术改进
- Tone.js CDN 版本：14.8.49
- 自动音频上下文初始化
- 改进的异步错误处理
- 详细的控制台日志输出
- 用户友好的错误消息

## [2.3.0] - 2024-11-04

### 🔗 Added | 新增
- **统一导航栏** - 三大模式无缝集成！
  - 新增 `nav-bar.css` 统一导航样式
  - 在 index.html、game-mode.html、follow-along.html 中添加统一导航栏
  - 支持响应式移动端汉堡菜单
  - 当前页面高亮显示
  - 美观的渐变设计，与应用整体风格一致
  - 一键在主页、跟弹模式、游戏模式之间切换

### 🎨 UI/UX Improvements | 界面改进
- 🔗 统一的导航体验，所有功能集中访问
- 📱 移动端汉堡菜单，节省屏幕空间
- 🎯 当前页面指示器，用户不会迷失方向
- ✨ 平滑的过渡动画和悬停效果
- 🎨 与应用整体设计风格完美融合

### 🔧 Changed | 改进
- 移除了独立的"返回主页"链接，统一使用导航栏
- 优化了页面高度计算，适配导航栏高度
- 改进了移动端布局，更好的用户体验

## [2.2.0] - 2024-11-04

### 🎮 Added | 新增
- **游戏模式 (Game Mode)** - 全新的节奏游戏体验！
  - 独立页面 `game-mode.html`
  - 类似 Synthesia 和 Piano Tiles 的落键游戏
  - 音符从上方落下，在判定线处按键
  - 精准判定系统：Perfect / Good / Miss
  - 三种难度选择：简单、普通、困难
  - 实时显示：分数、连击、准确率
  - 完整的进度条显示
  - 成就系统：完美演奏、连击大师、精准之神、高分达人
  - 本地最高分记录（localStorage）
  - 游戏结束统计：最终分数、最大连击、准确率、各判定数量
  - 支持键盘和触控操作
  - 虚拟钢琴键盘（可点击/触摸）
  - 使用 Canvas 进行高性能渲染
  - 完全响应式设计，支持移动端
  - 漂亮的游戏UI和动画效果
  - 8首内置歌曲支持

### 🎨 UI/UX Improvements | 界面改进
- 🎯 清晰的判定反馈（金色Perfect、绿色Good、红色Miss）
- ✨ 流畅的音符下落动画
- 🌟 按键高亮效果和视觉反馈
- 📊 实时更新的游戏统计
- 🏆 精美的成就徽章显示
- 🎭 沉浸式的游戏界面

### 📚 Documentation | 文档更新
- 📖 新增 `GAME-MODE-GUIDE.md` - 游戏模式完整使用指南
- 📝 更新 README.md - 添加游戏模式说明
- 💡 详细的游戏规则、技巧和常见问题

### 🔧 Technical Details | 技术细节
- Canvas 2D 渲染引擎
- requestAnimationFrame 游戏循环
- Tone.js 音频引擎集成
- 精确的时间同步机制
- localStorage 数据持久化
- 动态难度配置系统

## [2.1.0] - 2024-11-04

### ✨ Added | 新增
- 🎓 **跟着弹模式 (Follow-Along Mode)** - 全新的零基础学习功能
  - 独立页面 `follow-along.html`
  - 实时高亮下一个要弹的音符
  - 即时反馈（正确/错误提示）
  - 必须弹对才能继续，确保学习质量
  - 实时进度显示和百分比
  - 支持多首歌曲选择
  - 完美适合零基础用户
  - 键盘和鼠标双重操作支持
  - 漂亮的渐变UI设计
  - 完全响应式，支持移动端

### 📚 Documentation | 文档更新
- 📖 更新 README.md - 添加跟着弹模式说明
- 📝 更新 README_CN.md - 添加零基础推荐提示
- ✨ 强调零基础用户优先使用跟着弹模式

### 🎨 UI/UX Improvements | 界面改进
- 🎨 现代化渐变配色方案
- 💫 流畅的动画和过渡效果
- 🎯 清晰的视觉层次
- 📊 直观的进度显示
- ✨ 琴键高亮动画效果

## [2.0.0] - 2024-11-03

### ✨ Added | 新增
- 📱 完整的移动端响应式支持 - Complete mobile responsive design
- 🎨 新增 `mobile-responsive.css` 移动端优化样式文件
- 📖 详尽的中英文 README 文档
- 🚀 快速启动脚本 (start.sh / start.bat)
- 📄 LICENSE 文件 (MIT)
- 🙈 .gitignore 文件
- 📝 中文使用说明 (README_CN.md)

### 🔧 Changed | 改进
- 📱 优化 viewport meta 标签，支持真正的响应式
  - 从 `user-scalable=no` 改为 `width=device-width, initial-scale=1.0, maximum-scale=5.0`
- 🌐 添加 lang="zh-CN" 属性
- 📝 完善 meta 描述和关键词
- 🎨 增强移动端触摸交互体验
- 📊 优化小屏幕设备的布局

### 📱 Mobile Optimizations | 移动端优化
- ✅ 响应式钢琴键盘 - 自动适配屏幕宽度
- ✅ 触摸优化 - 支持多点触控和滑动
- ✅ 横屏支持 - 自动调整布局
- ✅ iOS 安全区域适配
- ✅ 深色模式支持
- ✅ 触摸反馈优化
- ✅ 可访问性增强

### 🎯 Browser Support | 浏览器支持
- ✅ Chrome/Edge ≥ 60
- ✅ Firefox ≥ 55
- ✅ Safari ≥ 11
- ✅ iOS Safari ≥ 11
- ✅ Android Chrome ≥ 60

### 📐 Responsive Breakpoints | 响应式断点
- 📱 手机: ≤ 480px
- 📱 大屏手机: 481px - 768px
- 📱 平板: 769px - 1024px
- 💻 桌面: > 1024px

### 🎨 CSS Improvements | CSS 改进
```css
/* 移动端优化 */
- 触摸区域最小 44x44px (符合 WCAG 标准)
- 流畅的触摸动画
- 优化的字体大小
- 自适应的间距和边距
- 横屏模式专属样式
```

### 📚 Documentation | 文档
- 📖 完整的项目说明
- 🎹 详细的使用指南
- 🛠️ 技术栈介绍
- 🔧 自定义配置说明
- 🤝 贡献指南
- 📞 联系方式

### 🔍 SEO Improvements | SEO 优化
- 添加 meta description
- 添加 meta keywords
- 添加 theme-color
- 优化页面标题

---

## [1.0.0] - Original Release

### Features | 原始功能
- 🎹 钢琴键盘弹奏 - Piano keyboard playing
- 🎵 Tone.js 音频引擎 - Tone.js audio engine
- 🎼 MIDI 文件播放 - MIDI file playback
- 📜 曲谱自动演奏 - Automatic score playback
- 📝 手动练习模式 - Manual practice mode
- 🎨 随机壁纸切换 - Random wallpaper switching
- 💝 捐赠和分享功能 - Donation and sharing features

### Included Content | 包含内容
- 🎵 15+ 内置曲谱 - 15+ built-in scores
- 🎹 88 键钢琴音频采样 - 88-key piano samples
- 🖼️ 6 张精美壁纸 - 6 beautiful wallpapers
- 🎼 2 个 MIDI 演示文件 - 2 MIDI demo files

---

## Future Plans | 未来计划

### 🚀 Version 2.1.0 (计划中)
- [ ] PWA 支持 - 可离线使用
- [ ] 更多曲谱 - 持续添加
- [ ] 录音功能 - 记录演奏
- [ ] 乐谱编辑器 - 自定义曲谱
- [ ] 多语言支持 - 国际化
- [ ] 性能仪表板 - 显示延迟和性能指标

### 🎯 Version 3.0.0 (远期)
- [ ] WebRTC 实时合奏
- [ ] AI 辅助练习
- [ ] 云端曲谱库
- [ ] 社区功能
- [ ] 学习进度追踪
- [ ] VR/AR 支持

---

## Contributing | 贡献

欢迎提交 Issue 和 Pull Request！

See [README.md](README.md) for contribution guidelines.

---

## License | 许可证

MIT License - See [LICENSE](LICENSE) for details.

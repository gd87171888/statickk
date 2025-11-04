# 🎹 在线钢琴练习平台 | Piano Online Practice Platform

<div align="center">

![Piano Online](https://img.shields.io/badge/Piano-Online-blue?style=for-the-badge)
![Vue 2](https://img.shields.io/badge/Vue-2.x-brightgreen?style=for-the-badge&logo=vue.js)
![Tone.js](https://img.shields.io/badge/Tone.js-Audio-orange?style=for-the-badge)
![Mobile Friendly](https://img.shields.io/badge/Mobile-Friendly-success?style=for-the-badge)

一个功能丰富的在线钢琴练习平台，支持键盘弹奏、MIDI播放、自动演奏和曲谱练习。

A feature-rich online piano practice platform with keyboard playing, MIDI playback, auto-play, and sheet music practice.

[中文](#中文文档) | [English](#english-documentation)

</div>

---

## 中文文档

### ✨ 核心特性

- 🎵 **真实钢琴音色** - 使用Tone.js加载真实钢琴采样，提供高质量音频体验
- ⌨️ **键盘弹奏** - 支持电脑键盘映射到钢琴键，即点即弹
- 🎼 **MIDI播放** - 支持导入和播放MIDI文件，自动演奏
- 📜 **曲谱练习** - 内置多首流行歌曲的数字简谱和MusicXML曲谱
- 🎯 **分步练习** - 提供手动分步练习模式，适合初学者
- 🎓 **跟着弹模式** - 零基础学习模式，高亮提示+即时反馈，弹对才能继续
- 🎮 **游戏模式（最新！）** - 类似Synthesia/Piano Tiles的落键游戏，边玩边学，支持难度选择和成就系统
- 🔗 **统一导航** - 三大模式无缝切换，所有功能一站式体验
- 📱 **移动端优化** - 完全响应式设计，支持手机和平板访问
- 🎨 **随机壁纸** - 精美背景壁纸随机切换
- 💝 **社交分享** - 支持多平台分享功能

### 🎼 内置曲谱

项目包含以下精选曲谱：

**流行歌曲：**
- 🎵 成都 / 后来 / 七里香 / 告白气球
- 🎵 简单爱 / 纸短情长 / 时间煮雨
- 🎵 蒲公英的约定 / 下一个天亮 / 海角七号

**经典名曲：**
- 🎵 Canon（卡农）
- 🎵 千与千寻 / One Summer's Day
- 🎵 Songs For You

**MIDI文件：**
- 🎵 晴天.mid / 等你下课.mid

### 🚀 快速开始

#### 在线访问
直接打开 `index.html` 文件或部署到任意Web服务器即可使用。

#### 本地运行

```bash
# 方法1: 使用Python快速启动
python -m http.server 8080

# 方法2: 使用Node.js
npx serve .

# 方法3: 使用任意Web服务器
# 将项目文件复制到服务器的public目录
```

然后在浏览器访问：`http://localhost:8080`

#### 导航切换

所有页面都配备了统一的导航栏，可以轻松在三大模式之间切换：

- 🏠 **主页** - 自由弹奏、MIDI播放、曲谱练习
- 📚 **跟弹模式** - 零基础学习，音符高亮引导
- 🎮 **游戏模式** - 节奏游戏，边玩边学

**桌面端：** 点击顶部导航栏即可切换  
**移动端：** 点击右上角 ☰ 汉堡菜单，选择要去的模式

> 💡 更多使用技巧请查看 [功能整合使用指南](INTEGRATION-GUIDE.md)

### 📱 移动端使用

项目已针对移动端进行全面优化：

- ✅ 响应式布局自动适配屏幕尺寸
- ✅ 触摸操作优化，支持滑动和点击
- ✅ 横屏模式自动调整布局
- ✅ iOS安全区域适配
- ✅ 触摸反馈优化
- ✅ 性能优化，流畅运行
- ✅ 响应式导航菜单，移动端汉堡菜单

**建议：** 在移动浏览器中，可以将网页"添加到主屏幕"获得类似原生应用的体验。

### 🎹 使用指南

#### 键盘映射

电脑键盘按键对应钢琴键：

```
白键：A S D F G H J K L
黑键：W E   T Y U   O P
低八度：Z X C V B N M
```

#### 功能说明

1. **游戏模式（最新推荐！）🎮**
   - 访问 `game-mode.html` 页面
   - 类似 Synthesia 和 Piano Tiles 的节奏游戏体验
   - 音符从上方落下，在到达判定线时按键
   - 判定系统：Perfect（+100分）、Good（+50分）、Miss（连击清零）
   - 三种难度：简单、普通、困难
   - 实时分数、连击、准确率显示
   - 成就系统和本地最高分记录
   - 完全支持键盘和触控操作
   - 适合想要以游戏方式学习的用户

2. **跟着弹模式（零基础推荐！）**
   - 访问 `follow-along.html` 页面
   - 选择想要学习的歌曲
   - 琴键高亮提示下一个要弹的音符
   - 弹对了才能继续，弹错可以重试
   - 实时进度显示和即时反馈

3. **自动演奏模式**
   - 选择曲谱列表中的歌曲
   - 点击播放按钮自动演奏
   - 可暂停、停止、调整速度

4. **手动练习模式**
   - 选择练习曲目
   - 按步骤跟随提示弹奏
   - 适合初学者学习

5. **MIDI播放**
   - 导入MIDI文件
   - 自动解析并播放
   - 可视化音符显示

6. **自由弹奏**
   - 使用鼠标点击琴键
   - 或使用键盘按键
   - 实时音频反馈

### 🏗️ 项目结构

```
piano-online/
├── index.html                 # 主页面
├── game-mode.html            # 游戏模式（新增）
├── follow-along.html         # 跟着弹模式
├── favicon.png               # 网站图标
├── static/                   # 静态资源目录
│   ├── css/                  # 样式文件
│   │   ├── app.*.css        # 主样式（编译后）
│   │   ├── share.min.css    # 社交分享样式
│   │   └── mobile-responsive.css  # 移动端响应式样式
│   ├── js/                   # JavaScript文件
│   │   ├── app.*.js         # 主应用（编译后）
│   │   ├── vendor.*.js      # 第三方库
│   │   ├── jquery3.min.js   # jQuery
│   │   └── *.js             # 其他工具库
│   ├── fonts/                # 字体文件
│   ├── images/               # 背景壁纸
│   │   ├── 1.png - 6.jpg    # 多张精美壁纸
│   │   └── 5.webp           # WebP格式壁纸
│   ├── img/                  # UI图标
│   │   └── sprite.png       # 图标精灵图
│   ├── goodsImgs/            # 商品图片
│   ├── samples/              # 钢琴音频采样
│   │   └── piano/            # 88键钢琴音频文件
│   ├── xmlscore/             # MusicXML曲谱
│   │   └── *.json           # JSON格式曲谱数据
│   └── midi/                 # MIDI文件
│       ├── 晴天.mid
│       └── 等你下课.mid
└── README.md                 # 项目文档
```

### 🛠️ 技术栈

- **前端框架**: Vue 2.x
- **路由管理**: Vue Router (Hash模式)
- **状态管理**: Vuex
- **音频引擎**: Tone.js
- **MIDI解析**: Tone.Midi
- **UI交互**: jQuery
- **样式处理**: Normalize.css + 自定义响应式CSS

### 🎨 功能模块

#### 核心组件

1. **PageHeader** - 页面头部
   - 导航菜单
   - 壁纸切换控制

2. **RandomLyric** - 随机歌词
   - 轮播显示精选歌词
   - 网易云音乐搜索集成

3. **Piano** - 钢琴组件
   - Tone.js音频引擎
   - 键盘事件绑定
   - MIDI播放支持
   - 音频采样加载

4. **AutoPlayScoreList** - 自动演奏列表
   - 数字简谱
   - MusicXML支持
   - MIDI文件播放
   - 事件总线通信

5. **ManualPlayScoreList** - 手动练习列表
   - 分步练习
   - 抽屉式UI
   - 进度跟踪

6. **CommodityList** - 商品展示
   - 联盟商品卡片
   - 远程JSON数据
   - 响应式布局

7. **PageFooter** - 页面底部
   - 捐赠二维码
   - 版权信息
   - 社交链接

### 📊 浏览器兼容性

| 浏览器 | 版本 | 支持状态 |
|--------|------|---------|
| Chrome | ≥ 60 | ✅ 完全支持 |
| Firefox | ≥ 55 | ✅ 完全支持 |
| Safari | ≥ 11 | ✅ 完全支持 |
| Edge | ≥ 79 | ✅ 完全支持 |
| iOS Safari | ≥ 11 | ✅ 完全支持 |
| Android Chrome | ≥ 60 | ✅ 完全支持 |
| IE | 11 | ⚠️ 部分支持 |

### 🔧 自定义配置

#### 添加新曲谱

1. 准备JSON格式的曲谱文件
2. 放置到 `static/xmlscore/` 目录
3. 确保包含必要的字段：`musicName`, `measures`, `divisions`等

#### 添加MIDI文件

1. 将MIDI文件放置到 `static/midi/` 目录
2. 文件名使用中文或英文
3. 系统会自动识别并加载

#### 更换钢琴音色

1. 准备新的音频采样文件（支持mp3, ogg等格式）
2. 放置到 `static/samples/piano/` 目录
3. 命名格式：`音符名-八度.mp3`（如：C4.mp3, A#3.mp3）

#### 自定义壁纸

1. 准备图片文件（建议分辨率：1920x1080或更高）
2. 放置到 `static/images/` 目录
3. 支持格式：jpg, png, webp

### 🎯 性能优化

项目已进行以下优化：

- ✅ 代码分割和懒加载
- ✅ 资源压缩和混淆
- ✅ 图片格式优化（WebP支持）
- ✅ CSS精灵图减少HTTP请求
- ✅ 音频采样按需加载
- ✅ 移动端性能优化
- ✅ 触摸事件防抖

### 📝 开发建议

如需进行二次开发，建议：

1. 这是编译后的生产版本，源代码需要Vue CLI项目
2. 核心逻辑在编译后的 `app.*.js` 中
3. 可以直接修改 `mobile-responsive.css` 调整样式
4. 可以添加新的曲谱和MIDI文件而无需重新编译

### 🤝 贡献指南

欢迎提交Issue和Pull Request！

1. Fork本项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启Pull Request

### 📄 许可证

本项目采用 MIT 许可证。详见 [LICENSE](LICENSE) 文件。

### 🙏 致谢

- [Tone.js](https://tonejs.github.io/) - 强大的Web音频框架
- [Vue.js](https://vuejs.org/) - 渐进式JavaScript框架
- 所有音频采样和曲谱来源
- 开源社区的支持

### 📮 联系方式

如有问题或建议，欢迎通过以下方式联系：

- 提交Issue: [GitHub Issues](../../issues)
- 邮件联系: [您的邮箱]

---

## English Documentation

### ✨ Core Features

- 🎵 **Authentic Piano Sound** - High-quality audio using Tone.js with real piano samples
- ⌨️ **Keyboard Playing** - Computer keyboard mapped to piano keys for instant playing
- 🎼 **MIDI Playback** - Import and play MIDI files with automatic performance
- 📜 **Sheet Music Practice** - Built-in popular songs with numeric notation and MusicXML
- 🎯 **Step-by-Step Practice** - Manual practice mode perfect for beginners
- 📱 **Mobile Optimized** - Fully responsive design for phones and tablets
- 🎨 **Random Wallpapers** - Beautiful background images with random switching
- 💝 **Social Sharing** - Multi-platform sharing support

### 🎼 Built-in Repertoire

**Popular Songs:**
- 🎵 Chengdu / Later / Qi Li Xiang / Confession Balloon
- 🎵 Simple Love / Paper Is Short / Time Boils the Rain
- 🎵 Dandelion's Promise / Next Dawn / Cape No. 7

**Classical Pieces:**
- 🎵 Canon
- 🎵 Spirited Away / One Summer's Day
- 🎵 Songs For You

**MIDI Files:**
- 🎵 Sunny Day / Waiting For You After Class

### 🚀 Quick Start

#### Online Access
Simply open the `index.html` file or deploy to any web server.

#### Local Development

```bash
# Method 1: Using Python
python -m http.server 8080

# Method 2: Using Node.js
npx serve .

# Method 3: Using any web server
# Copy project files to your server's public directory
```

Then visit: `http://localhost:8080`

### 📱 Mobile Usage

The project is fully optimized for mobile devices:

- ✅ Responsive layout adapts to screen sizes automatically
- ✅ Touch-optimized interactions with swipe and tap
- ✅ Landscape mode auto-adjustment
- ✅ iOS safe area adaptation
- ✅ Touch feedback optimization
- ✅ Performance optimized for smooth operation

**Tip:** Add the webpage to your home screen for an app-like experience.

### 🎹 User Guide

#### Keyboard Mapping

Computer keyboard keys mapped to piano keys:

```
White Keys: A S D F G H J K L
Black Keys: W E   T Y U   O P
Lower Octave: Z X C V B N M
```

#### Features

1. **Auto-Play Mode**
   - Select a song from the score list
   - Click play for automatic performance
   - Pause, stop, or adjust tempo

2. **Manual Practice Mode**
   - Choose a practice piece
   - Follow step-by-step prompts
   - Perfect for beginners

3. **MIDI Playback**
   - Import MIDI files
   - Automatic parsing and playback
   - Visual note display

4. **Free Play**
   - Click piano keys with mouse
   - Or use keyboard shortcuts
   - Real-time audio feedback

### 🏗️ Project Structure

```
piano-online/
├── index.html                 # Main page
├── favicon.png               # Site icon
├── static/                   # Static resources
│   ├── css/                  # Stylesheets
│   │   ├── app.*.css        # Main styles (compiled)
│   │   ├── share.min.css    # Social sharing styles
│   │   └── mobile-responsive.css  # Mobile responsive styles
│   ├── js/                   # JavaScript files
│   │   ├── app.*.js         # Main app (compiled)
│   │   ├── vendor.*.js      # Third-party libraries
│   │   ├── jquery3.min.js   # jQuery
│   │   └── *.js             # Other utilities
│   ├── fonts/                # Font files
│   ├── images/               # Background wallpapers
│   │   ├── 1.png - 6.jpg    # Beautiful wallpapers
│   │   └── 5.webp           # WebP format wallpaper
│   ├── img/                  # UI icons
│   │   └── sprite.png       # Icon sprite
│   ├── goodsImgs/            # Product images
│   ├── samples/              # Piano audio samples
│   │   └── piano/            # 88-key piano audio files
│   ├── xmlscore/             # MusicXML scores
│   │   └── *.json           # JSON format score data
│   └── midi/                 # MIDI files
│       ├── 晴天.mid
│       └── 等你下课.mid
└── README.md                 # Documentation
```

### 🛠️ Tech Stack

- **Frontend Framework**: Vue 2.x
- **Router**: Vue Router (Hash mode)
- **State Management**: Vuex
- **Audio Engine**: Tone.js
- **MIDI Parser**: Tone.Midi
- **UI Interaction**: jQuery
- **Styling**: Normalize.css + Custom Responsive CSS

### 🎨 Modules

#### Core Components

1. **PageHeader** - Page header with navigation and wallpaper controls
2. **RandomLyric** - Rotating lyrics with NetEase Music integration
3. **Piano** - Piano component with Tone.js engine and keyboard bindings
4. **AutoPlayScoreList** - Auto-play list for numeric, MusicXML, and MIDI
5. **ManualPlayScoreList** - Step-by-step practice with drawer UI
6. **CommodityList** - Product cards with remote JSON
7. **PageFooter** - Footer with donation QR and social links

### 📊 Browser Compatibility

| Browser | Version | Support |
|---------|---------|---------|
| Chrome | ≥ 60 | ✅ Full Support |
| Firefox | ≥ 55 | ✅ Full Support |
| Safari | ≥ 11 | ✅ Full Support |
| Edge | ≥ 79 | ✅ Full Support |
| iOS Safari | ≥ 11 | ✅ Full Support |
| Android Chrome | ≥ 60 | ✅ Full Support |
| IE | 11 | ⚠️ Partial Support |

### 🔧 Customization

#### Adding New Scores

1. Prepare JSON format score file
2. Place in `static/xmlscore/` directory
3. Ensure required fields: `musicName`, `measures`, `divisions`, etc.

#### Adding MIDI Files

1. Place MIDI files in `static/midi/` directory
2. Use Chinese or English filenames
3. System auto-recognizes and loads

#### Changing Piano Timbre

1. Prepare new audio sample files (mp3, ogg supported)
2. Place in `static/samples/piano/` directory
3. Naming: `Note-Octave.mp3` (e.g., C4.mp3, A#3.mp3)

#### Custom Wallpapers

1. Prepare images (recommended: 1920x1080 or higher)
2. Place in `static/images/` directory
3. Formats: jpg, png, webp

### 🎯 Performance

Optimizations applied:

- ✅ Code splitting and lazy loading
- ✅ Resource compression and minification
- ✅ Image format optimization (WebP)
- ✅ CSS sprites for reduced HTTP requests
- ✅ On-demand audio sample loading
- ✅ Mobile performance tuning
- ✅ Touch event debouncing

### 📝 Development Notes

For secondary development:

1. This is a compiled production build; source requires Vue CLI
2. Core logic in compiled `app.*.js`
3. Modify `mobile-responsive.css` directly for styling
4. Add scores and MIDI without recompilation

### 🤝 Contributing

Issues and Pull Requests welcome!

1. Fork the project
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

### 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) file for details.

### 🙏 Acknowledgments

- [Tone.js](https://tonejs.github.io/) - Powerful Web Audio framework
- [Vue.js](https://vuejs.org/) - Progressive JavaScript framework
- All audio samples and sheet music sources
- Open source community support

### 📮 Contact

For questions or suggestions:

- Submit Issue: [GitHub Issues](../../issues)
- Email: [Your Email]

---

<div align="center">

**Made with ❤️ for Piano Learners Worldwide**

⭐ Star this repo if you find it helpful!

</div>

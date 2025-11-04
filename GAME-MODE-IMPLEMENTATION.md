# 🎮 游戏模式实现文档 | Game Mode Implementation

## 概述

本文档详细说明了 v2.2.0 版本中新增的游戏模式功能的实现细节。

## 📋 实现目标

创建一个类似 **Synthesia** 和 **Piano Tiles** 的节奏游戏，让用户能够：
- 在游戏中学习钢琴
- 获得即时反馈和成就感
- 通过游戏化方式提高学习兴趣
- 追踪进度和挑战高分

## 🏗️ 技术架构

### 核心技术栈

1. **渲染引擎**
   - HTML5 Canvas 2D Context
   - requestAnimationFrame 游戏循环
   - 高性能实时渲染

2. **音频引擎**
   - Tone.js v14.8.49 (CDN)
   - Sampler 加载钢琴音频样本
   - 低延迟音频播放

3. **数据解析**
   - 复用现有 JSON 曲谱数据
   - 从 MusicXML 转换的 JSON 格式
   - 动态解析 measures 结构

4. **状态管理**
   - 原生 JavaScript 对象
   - 实时游戏状态追踪
   - localStorage 持久化存储

### 文件结构

```
game-mode.html              # 单文件应用 (42KB)
├── HTML 结构
│   ├── 开始界面
│   ├── 游戏界面
│   │   ├── 顶部状态栏
│   │   ├── 进度条
│   │   ├── Canvas 画布
│   │   └── 虚拟键盘
│   └── 结束界面
├── CSS 样式 (内联)
│   ├── 响应式布局
│   ├── 动画效果
│   └── 移动端优化
└── JavaScript 逻辑
    ├── 游戏配置
    ├── 音频引擎初始化
    ├── 歌曲数据加载
    ├── 游戏循环
    ├── 判定系统
    ├── UI 更新
    └── 事件处理
```

## 🎯 核心功能实现

### 1. 难度系统

```javascript
const CONFIG = {
    easy: {
        speed: 150,         // 下落速度（像素/秒）
        perfectWindow: 80,  // Perfect 判定窗口（毫秒）
        goodWindow: 150,    // Good 判定窗口（毫秒）
        noteLimit: 50       // 音符数量限制
    },
    normal: {
        speed: 200,
        perfectWindow: 60,
        goodWindow: 120,
        noteLimit: 100
    },
    hard: {
        speed: 250,
        perfectWindow: 40,
        goodWindow: 100,
        noteLimit: null     // 无限制（完整曲目）
    }
};
```

### 2. 音符映射

将 MusicXML 音符名称映射到琴键位置和键盘按键：

```javascript
const NOTE_TO_KEY_MAP = {
    'C4': { lane: 0, isBlack: false, key: 'a', display: 'Do' },
    'D4': { lane: 1, isBlack: false, key: 's', display: 'Re' },
    'E4': { lane: 2, isBlack: false, key: 'd', display: 'Mi' },
    // ... 更多映射
    'C#4': { lane: 0.5, isBlack: true, key: 'w', display: 'C#' },
    // ... 黑键映射
};
```

### 3. 歌曲解析

从 JSON 格式的曲谱数据中提取游戏音符：

```javascript
function parseSongToNotes(songData, difficulty) {
    const notes = [];
    let currentTime = 0;
    
    // 遍历所有小节
    songData.measures.forEach(measure => {
        if (measure.staff1 && measure.staff1.voice1) {
            // 只取主旋律（voice1）
            measure.staff1.voice1.forEach(note => {
                if (!note.rest && note.noteName && NOTE_TO_KEY_MAP[note.noteName]) {
                    const mapping = NOTE_TO_KEY_MAP[note.noteName];
                    notes.push({
                        pitch: note.noteName,
                        startTime: currentTime / 1000,  // 转换为秒
                        duration: note.duration / 1000,
                        lane: mapping.lane,
                        isBlack: mapping.isBlack,
                        key: mapping.key,
                        judged: false
                    });
                }
                currentTime += note.duration;
            });
        }
    });
    
    // 根据难度限制音符数量
    if (CONFIG[difficulty].noteLimit && notes.length > CONFIG[difficulty].noteLimit) {
        return notes.slice(0, CONFIG[difficulty].noteLimit);
    }
    
    return notes;
}
```

### 4. 游戏循环

使用 requestAnimationFrame 实现流畅的游戏循环：

```javascript
function gameLoop() {
    if (!gameState.isPlaying || gameState.isPaused) return;
    
    const now = (Date.now() - gameState.startTime) / 1000;
    
    // 清空画布
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    
    // 绘制判定线
    drawJudgmentLine();
    
    // 绘制下落音符
    const config = CONFIG[gameState.difficulty];
    const speed = config.speed;
    
    for (const note of gameState.notes) {
        if (note.judged) continue;
        
        // 计算音符位置
        const timeDiff = note.startTime - now;
        const y = judgeLineY - timeDiff * speed;
        
        // 只渲染可见范围内的音符
        if (y < -100 || y > canvas.height) continue;
        
        // 绘制音符矩形
        drawNote(note, y);
    }
    
    // 检查漏掉的音符
    checkMissedNotes();
    
    // 检查游戏是否结束
    if (gameState.judgedNotes.size >= gameState.notes.length) {
        endGame();
        return;
    }
    
    requestAnimationFrame(gameLoop);
}
```

### 5. 判定系统

精确的时间判定系统：

```javascript
function judgeNote(pressedNote) {
    const now = (Date.now() - gameState.startTime) / 1000;
    const config = CONFIG[gameState.difficulty];
    
    // 找到该音符最近的、未判定的 note
    let closestNote = null;
    let minDelta = Infinity;
    
    for (const note of gameState.notes) {
        if (note.judged || note.pitch !== pressedNote) continue;
        
        const delta = Math.abs(note.startTime - now);
        if (delta < minDelta) {
            minDelta = delta;
            closestNote = note;
        }
    }
    
    if (!closestNote) return;
    
    closestNote.judged = true;
    const deltaMs = minDelta * 1000;
    
    // 判定等级
    if (deltaMs <= config.perfectWindow) {
        // Perfect: +100分，连击+1
        handlePerfect();
    } else if (deltaMs <= config.goodWindow) {
        // Good: +50分，连击+1
        handleGood();
    } else {
        // Miss: 0分，连击清零
        handleMiss();
    }
}
```

### 6. 视觉反馈

动态的判定反馈动画：

```javascript
function showJudgment(text, type) {
    judgmentDisplay.textContent = text;
    judgmentDisplay.className = `judgment-display judgment-${type}`;
    judgmentDisplay.style.animation = 'judgmentPop 0.5s ease-out';
}

// CSS 动画
@keyframes judgmentPop {
    0% {
        transform: translate(-50%, -50%) scale(0);
        opacity: 1;
    }
    50% {
        transform: translate(-50%, -50%) scale(1.2);
        opacity: 1;
    }
    100% {
        transform: translate(-50%, -50%) scale(1);
        opacity: 0;
    }
}
```

## 📊 数据持久化

使用 localStorage 保存最高分：

```javascript
// 保存格式：highscore_{歌曲名}_{难度}
const storageKey = `highscore_${gameState.selectedSong}_${gameState.difficulty}`;
const currentHighScore = localStorage.getItem(storageKey) || 0;

if (gameState.score > currentHighScore) {
    localStorage.setItem(storageKey, gameState.score);
}
```

## 🎨 UI/UX 设计

### 颜色方案

- 主题色：紫色渐变 (#667eea → #764ba2)
- Perfect：金色 (#FFD700)
- Good：绿色 (#51CF66)
- Miss：红色 (#FF6B6B)
- 连击：橙色 (#FFA500)

### 响应式断点

```css
/* 移动端 */
@media (max-width: 768px) {
    .score-value { font-size: 1.3em; }
    .white-key { width: 40px; height: 120px; }
    .black-key { width: 25px; height: 80px; }
}
```

## 🔧 性能优化

1. **渲染优化**
   - 只渲染可见范围内的音符
   - 使用 Canvas 硬件加速
   - 避免不必要的重绘

2. **内存管理**
   - 音符判定后标记为已处理
   - 使用 Set 追踪已判定音符
   - 及时清理不需要的对象

3. **音频优化**
   - 使用 Tone.js Sampler 预加载音频
   - 低延迟音频播放
   - 避免音频重叠

## 🎯 成就系统

根据游戏表现解锁成就：

```javascript
const achievements = [];

if (accuracy >= 95) 
    achievements.push('🏆 完美演奏');

if (gameState.maxCombo >= 50) 
    achievements.push('🔥 连击大师');

if (gameState.perfect >= totalNotes * 0.8) 
    achievements.push('⭐ 精准之神');

if (gameState.score >= 5000) 
    achievements.push('💎 高分达人');
```

## 📱 移动端适配

1. **触摸事件**
   ```javascript
   key.addEventListener('touchstart', (e) => {
       e.preventDefault();  // 防止双击缩放
       onKeyPress(note);
   });
   ```

2. **虚拟键盘**
   - 黑键使用绝对定位
   - 白键使用 flex 布局
   - 适当的最小点击区域

3. **横屏优化**
   - Canvas 自动调整大小
   - 虚拟键盘缩放
   - 状态栏紧凑布局

## 🐛 已知限制

1. **音符类型**
   - 当前只支持单音符（不支持和弦）
   - 只解析 staff1 voice1（主旋律）

2. **浏览器兼容性**
   - 需要现代浏览器支持 Canvas 和 Web Audio
   - iOS Safari 可能需要用户手势才能播放音频

3. **性能考虑**
   - 大量音符同时显示可能影响性能
   - 建议限制同时渲染的音符数量

## 🚀 未来扩展方向

1. **功能增强**
   - [ ] 和弦支持
   - [ ] 左右手分开判定
   - [ ] 多轨道模式
   - [ ] 自定义皮肤
   - [ ] 回放功能

2. **游戏性**
   - [ ] 更多难度等级
   - [ ] 额外的判定等级（如 Great, Bad）
   - [ ] 技能道具系统
   - [ ] 关卡系统

3. **社交功能**
   - [ ] 在线排行榜
   - [ ] 好友对战
   - [ ] 分享功能
   - [ ] 录像回放

4. **音频**
   - [ ] MIDI 键盘支持
   - [ ] 延迟校准工具
   - [ ] 多种音色选择

## 📝 开发日志

**2024-11-04**
- ✅ 完成基础游戏框架
- ✅ 实现判定系统
- ✅ 添加三种难度
- ✅ 实现成就系统
- ✅ 完成移动端适配
- ✅ 添加本地排行榜
- ✅ 完善文档

## 🙏 致谢

- **Tone.js** - 优秀的音频引擎
- **Synthesia** - 游戏灵感来源
- **Piano Tiles** - 玩法参考
- 所有测试和反馈的用户

---

<div align="center">

**游戏模式 v2.2.0**

Made with 🎮 and ❤️

</div>

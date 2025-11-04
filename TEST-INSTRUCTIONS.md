# 测试说明 / Test Instructions

## 版本 2.3.1 修复验证 / Version 2.3.1 Fix Verification

### 修复内容 / Fixed Issues
1. ✅ 主页钢琴音频问题
2. ✅ 游戏模式歌曲加载优化

---

## 测试 1: 主页钢琴声音 / Test 1: Home Page Piano Audio

### 测试步骤 / Test Steps

1. **启动服务器 / Start Server**
   ```bash
   cd /home/engine/project
   ./start.sh
   # 或者 / or
   python3 -m http.server 8000
   ```

2. **打开浏览器 / Open Browser**
   - 访问: `http://localhost:8000`
   - 打开开发者工具（F12）
   - 切换到 Console 标签

3. **首次交互 / First Interaction**
   - 在页面上点击任意位置
   - **预期结果**: Console 显示 "Tone.js audio context initialized"

4. **测试键盘弹奏 / Test Keyboard Playing**
   - 按下键盘键：A S D F G H J K L
   - **预期结果**: 每个键都应该发出对应的钢琴音
   - **预期结果**: 虚拟钢琴键应该有视觉高亮反馈

5. **测试鼠标点击 / Test Mouse Click**
   - 用鼠标点击虚拟钢琴键
   - **预期结果**: 点击的琴键应该发出声音
   - **预期结果**: 琴键应该有视觉反馈

6. **测试 MIDI 播放 / Test MIDI Playback**
   - 滚动到 "自动演奏乐谱" 部分
   - 点击任意 MIDI 文件（如 "晴天.mid"）
   - **预期结果**: 应该能听到自动播放的音乐

### 常见问题排查 / Troubleshooting

❌ **如果没有声音**:
1. 检查 Console 是否有错误
2. 确认浏览器音量未静音
3. 刷新页面并重新点击
4. 检查是否成功加载 Tone.js CDN（Network 标签）

✅ **成功标志**:
- Console 显示: "Tone.js audio context initialized"
- Console 显示: "Piano samples loaded"
- 键盘按键和鼠标点击都有声音

---

## 测试 2: 游戏模式歌曲加载 / Test 2: Game Mode Song Loading

### 测试步骤 / Test Steps

1. **打开游戏模式 / Open Game Mode**
   - 访问: `http://localhost:8000/game-mode.html`
   - 或从主页导航栏点击 "🎮 游戏模式"

2. **打开开发者工具 / Open Developer Tools**
   - 按 F12
   - 切换到 Console 标签

3. **选择歌曲 / Select a Song**
   - 从下拉菜单选择任意歌曲（建议：简单爱）
   - **预期结果**: 下拉菜单应该显示 8 首歌曲

4. **选择难度 / Select Difficulty**
   - 点击难度按钮（简单/普通/困难）
   - **预期结果**: 选中的按钮应该高亮显示

5. **开始游戏 / Start Game**
   - 点击 "开始游戏 🚀" 按钮
   - **预期结果**: 
     - 按钮文字变为 "加载中..."
     - Console 显示: `Loading song: 简单爱`
     - Console 显示: `Song loaded successfully. Measures: xxx`
     - Console 显示: `Parsed xxx notes from song`
     - 按钮恢复为 "开始游戏 🚀"

6. **游戏启动 / Game Starts**
   - **预期结果**: 
     - 屏幕显示倒计时：3, 2, 1, GO!
     - 音符开始从上方落下
     - 可以使用键盘（A S D F G H J K L）演奏
     - 点击虚拟钢琴键也可以演奏

7. **测试所有歌曲 / Test All Songs**
   重复测试以下歌曲：
   - ✅ 简单爱
   - ✅ 告白气球
   - ✅ 七里香
   - ✅ 成都
   - ✅ 纸短情长
   - ✅ 千与千寻
   - ✅ One Summer's Day
   - ✅ Canon in D

### 常见问题排查 / Troubleshooting

❌ **如果加载失败**:
1. 检查 Console 的错误消息
2. 检查 Network 标签，看 JSON 文件是否返回 404
3. 确认文件路径：`./static/xmlscore/歌曲名.json`
4. 检查文件是否存在：
   ```bash
   ls -lh static/xmlscore/*.json
   ```

❌ **如果显示"没有可用的音符"**:
- 这是正常的，说明该歌曲的音符超出了 C4-D5 范围
- 尝试其他歌曲

✅ **成功标志**:
- Console 显示加载日志
- 游戏成功启动，显示倒计时
- 音符正常下落
- 按键有声音和判定反馈

---

## 测试 3: 跟弹模式（确保未受影响）/ Test 3: Follow-Along Mode (Ensure No Regression)

### 测试步骤 / Test Steps

1. **打开跟弹模式 / Open Follow-Along Mode**
   - 访问: `http://localhost:8000/follow-along.html`
   - 或从导航栏点击 "📚 跟弹模式"

2. **选择歌曲 / Select a Song**
   - 选择任意歌曲（建议：小星星）

3. **开始练习 / Start Practice**
   - 点击 "开始练习" 按钮
   - **预期结果**: 第一个音符高亮显示

4. **演奏测试 / Play Test**
   - 按下高亮音符对应的键
   - **预期结果**: 
     - 听到声音
     - 高亮移动到下一个音符
     - 进度条前进

✅ **成功标志**:
- 音符高亮正常
- 按键有声音
- 进度正常推进

---

## 测试 4: 导航功能 / Test 4: Navigation

### 测试步骤 / Test Steps

1. **桌面端导航 / Desktop Navigation**
   - 在主页点击 "🎮 游戏模式"
   - 从游戏模式点击 "📚 跟弹模式"
   - 从跟弹模式点击 "🏠 主页"
   - **预期结果**: 每次切换都正常，当前页面高亮显示

2. **移动端导航（调整浏览器窗口宽度 ≤768px）/ Mobile Navigation**
   - 点击右上角 ☰ 汉堡菜单
   - **预期结果**: 菜单展开
   - 点击任一模式
   - **预期结果**: 成功导航到对应页面

✅ **成功标志**:
- 所有导航链接工作正常
- 当前页面正确高亮
- 移动端菜单展开/收起正常

---

## 性能测试 / Performance Test

### 检查项 / Checklist

1. **页面加载速度 / Page Load Speed**
   - 打开 Network 标签
   - 刷新页面
   - **预期**: index.html < 100KB, 总加载时间 < 3秒

2. **音频延迟 / Audio Latency**
   - 按键后立即听到声音
   - **预期**: 延迟 < 100ms

3. **游戏帧率 / Game Frame Rate**
   - 游戏模式下流畅运行
   - **预期**: 60 FPS（在 Console 用 `performance.now()` 测试）

4. **移动端性能 / Mobile Performance**
   - 在移动设备或模拟器中测试
   - **预期**: 流畅无卡顿

---

## 浏览器兼容性测试 / Browser Compatibility Test

测试以下浏览器 / Test in the following browsers:

- ✅ Chrome 60+
- ✅ Firefox 55+
- ✅ Safari 11+
- ✅ Edge 79+
- ✅ Mobile Safari (iOS 11+)
- ✅ Mobile Chrome (Android 5+)

每个浏览器都应该：
- 主页钢琴有声音
- 游戏模式正常加载
- 跟弹模式正常工作
- 导航功能正常

---

## 测试报告模板 / Test Report Template

```markdown
## 测试日期 / Test Date: YYYY-MM-DD
## 测试人员 / Tester: [Name]
## 浏览器 / Browser: [Name + Version]
## 操作系统 / OS: [OS + Version]

### 测试结果 / Test Results

- [ ] 测试 1: 主页钢琴声音
- [ ] 测试 2: 游戏模式歌曲加载
- [ ] 测试 3: 跟弹模式
- [ ] 测试 4: 导航功能

### 发现的问题 / Issues Found

1. [描述问题]
2. [描述问题]

### 屏幕截图 / Screenshots

[附加截图]

### 控制台日志 / Console Logs

```
[粘贴相关日志]
```

### 备注 / Notes

[其他说明]
```

---

## 回归测试清单 / Regression Test Checklist

确保所有原有功能仍然正常工作：

- [ ] 主页随机壁纸切换
- [ ] 主页键盘弹奏
- [ ] 主页 MIDI 播放
- [ ] 主页曲谱自动演奏
- [ ] 主页手动练习模式
- [ ] 跟弹模式所有功能
- [ ] 游戏模式所有功能
- [ ] 导航栏在所有页面正常
- [ ] 移动端响应式布局
- [ ] 捐赠和分享功能

---

## 自动化测试脚本 / Automated Test Script

```bash
#!/bin/bash
# quick-test.sh

echo "🧪 Starting Quick Test..."

# 启动服务器
python3 -m http.server 8000 > /dev/null 2>&1 &
SERVER_PID=$!
echo "✅ Server started (PID: $SERVER_PID)"

sleep 2

# 测试文件是否可访问
echo "🔍 Testing file access..."

curl -s http://localhost:8000/index.html > /dev/null && echo "✅ index.html accessible" || echo "❌ index.html failed"
curl -s http://localhost:8000/game-mode.html > /dev/null && echo "✅ game-mode.html accessible" || echo "❌ game-mode.html failed"
curl -s http://localhost:8000/follow-along.html > /dev/null && echo "✅ follow-along.html accessible" || echo "❌ follow-along.html failed"

# 测试歌曲文件
echo "🎵 Testing song files..."
for song in "简单爱" "告白气球" "七里香" "成都" "纸短情长" "千与千寻" "one_summers_day" "canon"; do
    curl -s -o /dev/null -w "%{http_code}" "http://localhost:8000/static/xmlscore/${song}.json" | grep -q 200 && echo "✅ $song.json" || echo "❌ $song.json"
done

# 清理
kill $SERVER_PID
echo "✅ Test completed!"
```

使用方法：
```bash
chmod +x quick-test.sh
./quick-test.sh
```

---

## 需要手动测试的项目 / Items Requiring Manual Testing

以下项目无法自动化，需要人工测试：

1. 🎵 音频播放（听觉测试）
2. 🎮 游戏体验（交互测试）
3. 📱 移动端触摸（真机测试）
4. 🎹 键盘弹奏（按键测试）
5. 🎨 UI/UX（视觉测试）
6. ⚡ 性能（流畅度测试）

---

## 联系信息 / Contact

如果测试中发现问题，请提供：
- 详细的重现步骤
- 浏览器和系统信息
- 控制台截图
- Network 标签截图

If you find issues during testing, please provide:
- Detailed reproduction steps
- Browser and system information
- Console screenshots
- Network tab screenshots

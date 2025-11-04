# 问题排查指南 / Troubleshooting Guide

## 已修复的问题 / Fixed Issues

### 1. 主页钢琴没有声音 / Home Page Piano No Audio

**问题原因 / Root Cause:**
- 主页是编译好的 Vue 应用，Tone.js 需要通过 CDN 引入
- 浏览器的自动播放策略要求用户先交互才能播放音频
- Tone.js 音频上下文需要在用户交互后初始化

**修复方案 / Solution:**
1. ✅ 在 `index.html` 中添加了 Tone.js CDN：
   ```html
   <script src="https://cdn.jsdelivr.net/npm/tone@14.8.49/build/Tone.js"></script>
   ```

2. ✅ 添加了自动初始化脚本，在用户首次点击、触摸或按键时初始化音频：
   ```javascript
   ['click', 'touchstart', 'keydown'].forEach(event => {
       document.addEventListener(event, initAudio, { once: true });
   });
   ```

**测试方法 / How to Test:**
1. 启动本地服务器：`./start.sh` 或 `start.bat`
2. 打开浏览器访问 `http://localhost:8000`
3. 点击页面任意位置（触发音频初始化）
4. 尝试点击钢琴键或使用键盘弹奏
5. 检查浏览器控制台是否显示 "Tone.js audio context initialized"

**预期结果 / Expected Result:**
- 点击钢琴键应该能听到声音
- 使用键盘（如 A S D F G H J 等）应该能弹奏音符
- MIDI 自动播放应该有声音

---

### 2. 游戏模式歌曲加载失败 / Game Mode Song Loading Failed

**问题原因 / Root Cause:**
- 错误处理不够详细，无法显示具体的错误信息
- 没有加载状态提示，用户不知道是否正在加载
- HTTP 响应状态码未检查

**修复方案 / Solution:**
1. ✅ 改进了 `loadSongData` 函数的错误处理：
   ```javascript
   - 检查 HTTP 响应状态码
   - 验证 JSON 数据格式
   - 提供详细的错误消息
   ```

2. ✅ 添加了加载状态提示：
   ```javascript
   - 按钮显示 "加载中..."
   - 控制台输出加载进度
   - 显示解析的音符数量
   ```

3. ✅ 添加了控制台调试信息：
   ```javascript
   console.log(`Loading song: ${gameState.selectedSong}`);
   console.log(`Song loaded successfully. Measures: ${songData.measures?.length}`);
   console.log(`Parsed ${gameState.notes.length} notes from song`);
   ```

**可用歌曲列表 / Available Songs:**
所有歌曲文件都存在于 `static/xmlscore/` 目录：
- ✅ 简单爱 - 周杰伦
- ✅ 告白气球 - 周杰伦
- ✅ 七里香 - 周杰伦
- ✅ 成都 - 赵雷
- ✅ 纸短情长 - 烟把儿
- ✅ 千与千寻 - 久石让
- ✅ One Summer's Day (one_summers_day.json)
- ✅ Canon in D - 卡农 (canon.json)

**测试方法 / How to Test:**
1. 启动本地服务器：`./start.sh` 或 `start.bat`
2. 打开浏览器访问 `http://localhost:8000/game-mode.html`
3. 从下拉菜单选择一首歌曲
4. 选择难度（简单/普通/困难）
5. 点击"开始游戏"按钮
6. 观察按钮是否显示"加载中..."
7. 检查浏览器控制台的日志信息

**预期结果 / Expected Result:**
- 按钮显示"加载中..."然后恢复为"开始游戏"
- 控制台显示加载日志和解析的音符数量
- 游戏成功开始，显示倒计时 3, 2, 1, GO!
- 音符从上方落下

**如果仍然失败 / If Still Failing:**
1. 打开浏览器开发者工具（F12）
2. 切换到 Console 标签
3. 查看错误信息
4. 切换到 Network 标签
5. 重新加载歌曲，检查 JSON 文件的请求状态
6. 确认文件路径是否正确：`./static/xmlscore/歌曲名.json`

---

## 常见问题 / Common Issues

### 问题：CORS 错误 / CORS Error
**解决方案：**
- 使用本地服务器运行（不要直接打开 HTML 文件）
- 运行 `./start.sh` 或 `start.bat` 启动服务器
- 访问 `http://localhost:8000` 而不是 `file:///...`

### 问题：Tone.js 未定义 / Tone.js is not defined
**解决方案：**
- 检查网络连接，确保能访问 CDN
- 如果 CDN 被屏蔽，可以下载 Tone.js 到本地并修改引用路径

### 问题：音符范围超出 / Notes out of range
**说明：**
- 游戏模式只支持 C4-D5（包括黑键 C#4, D#4, F#4, G#4, A#4, C#5, D#5）
- 如果歌曲包含其他音符，它们会被过滤掉
- 如果所有音符都被过滤，会显示"这首歌没有可用的音符"

### 问题：浏览器自动播放策略 / Browser Autoplay Policy
**说明：**
- 现代浏览器要求用户先交互才能播放音频
- 修复：在页面加载后点击任意位置即可激活音频
- 代码已添加自动初始化，首次点击会自动启动 Tone.js

---

## 调试技巧 / Debugging Tips

1. **检查控制台日志 / Check Console Logs:**
   - 打开浏览器开发者工具（F12）
   - 查看 Console 标签的日志和错误

2. **检查网络请求 / Check Network Requests:**
   - 打开 Network 标签
   - 重新加载页面或歌曲
   - 查看 JSON 文件是否成功加载（状态码应为 200）

3. **验证文件存在 / Verify File Exists:**
   ```bash
   # 列出所有歌曲文件
   ls -lh static/xmlscore/*.json
   
   # 检查特定文件
   ls -lh static/xmlscore/简单爱.json
   ```

4. **测试 JSON 格式 / Test JSON Format:**
   ```bash
   # 验证 JSON 格式是否正确
   cat static/xmlscore/简单爱.json | python3 -m json.tool > /dev/null && echo "Valid JSON"
   ```

5. **查看服务器日志 / Check Server Logs:**
   ```bash
   # 查看最近的服务器日志
   tail -f server.log
   ```

---

## 技术细节 / Technical Details

### Tone.js 版本 / Tone.js Version
- 使用版本：14.8.49
- CDN 链接：`https://cdn.jsdelivr.net/npm/tone@14.8.49/build/Tone.js`
- 文档：https://tonejs.github.io/

### 音频采样 / Audio Samples
- 位置：`static/samples/piano/`
- 格式：MP3
- 音符：C4, D4, E4, F4, G4, A4, B4, C5, D5

### 支持的浏览器 / Supported Browsers
- ✅ Chrome 60+
- ✅ Firefox 55+
- ✅ Safari 11+
- ✅ Edge 79+
- ✅ 移动端 Safari (iOS 11+)
- ✅ 移动端 Chrome (Android 5+)

---

## 联系支持 / Contact Support

如果问题仍未解决，请提供以下信息：
- 浏览器类型和版本
- 操作系统
- 控制台错误日志截图
- Network 标签的请求详情

If the issue persists, please provide:
- Browser type and version
- Operating system
- Console error log screenshot
- Network tab request details

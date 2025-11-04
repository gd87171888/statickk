#!/bin/bash
echo "==================================="
echo "Testing v2.3.2 Changes"
echo "==================================="
echo ""

# Test 1: Check if follow-along files are removed
echo "1. Testing file removal..."
if [ ! -f "follow-along.html" ]; then
    echo "   ✅ follow-along.html removed"
else
    echo "   ❌ follow-along.html still exists"
fi

if [ ! -f "FOLLOW-ALONG-GUIDE.md" ]; then
    echo "   ✅ FOLLOW-ALONG-GUIDE.md removed"
else
    echo "   ❌ FOLLOW-ALONG-GUIDE.md still exists"
fi
echo ""

# Test 2: Check navigation in index.html
echo "2. Testing navigation in index.html..."
if grep -q "follow-along.html" index.html; then
    echo "   ❌ Still references follow-along in index.html"
else
    echo "   ✅ No follow-along references in index.html"
fi
echo ""

# Test 3: Check navigation in game-mode.html
echo "3. Testing navigation in game-mode.html..."
if grep -q "follow-along.html" game-mode.html; then
    echo "   ❌ Still references follow-along in game-mode.html"
else
    echo "   ✅ No follow-along references in game-mode.html"
fi
echo ""

# Test 4: Check if all new songs are in game-mode.html
echo "4. Testing new songs in game-mode.html..."
new_songs=("后来" "时间煮雨" "蒲公英的约定" "下一个天亮" "海角七号" "牢不可破的联盟")
for song in "${new_songs[@]}"; do
    if grep -q "$song" game-mode.html; then
        echo "   ✅ Found: $song"
    else
        echo "   ❌ Missing: $song"
    fi
done
echo ""

# Test 5: Check if song files exist
echo "5. Testing song file availability..."
for song in "${new_songs[@]}"; do
    if [ -f "static/xmlscore/${song}.json" ]; then
        echo "   ✅ File exists: ${song}.json"
    else
        echo "   ❌ File missing: ${song}.json"
    fi
done
echo ""

# Test 6: Check for enhanced error handling in game-mode.html
echo "6. Testing enhanced error handling..."
if grep -q "🎵 Loading song:" game-mode.html; then
    echo "   ✅ Found emoji logging markers"
else
    echo "   ❌ Missing emoji logging markers"
fi

if grep -q "⏳ 加载中..." game-mode.html; then
    echo "   ✅ Found improved loading text"
else
    echo "   ❌ Missing improved loading text"
fi
echo ""

# Test 7: Check CHANGELOG.md
echo "7. Testing CHANGELOG.md..."
if grep -q "2.3.2" CHANGELOG.md; then
    echo "   ✅ Version 2.3.2 added to CHANGELOG"
else
    echo "   ❌ Version 2.3.2 not found in CHANGELOG"
fi
echo ""

echo "==================================="
echo "Test Summary Complete"
echo "==================================="

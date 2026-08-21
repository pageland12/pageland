<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트 팝업</title>
<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html, body {
    width: 100%;
    height: 100%;
    overflow: hidden; /* 스크롤바 방지 */
    user-select: none;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans KR", sans-serif;
    background-color: #5c4738;
}

/* 팝업 전체 레이아웃 (푸터 높이 40px 제외한 영역에 이미지 배치) */
.popup-wrap {
    position: relative;
    width: 100vw;
    height: 100vh;
    padding-bottom: 40px; /* 푸터 바 공간 확보 */
    background-color: #ffffff;
}

/* 500x500 이미지 원본 비율과 크기 절대 고정 */
.popup-img {
    width: 500px;
    height: 500px;
    display: block;
    flex-shrink: 0;
}

/* 하단 푸터 바 (40px) */
.footer-bar {
    width: 500px;
    height: 40px;
    background-color: #5c4738;
    color: #f7f3ee;
    display: flex;
    justify-content: space-between;
    align-items: top;
    padding: 0 16px;
    font-size: 13px;
    flex-shrink: 0;
}

.hide-btn {
    cursor: pointer;
    letter-spacing: -0.3px;
    transition: color 0.2s;
}

.hide-btn:hover {
    color: #ffd8a8;
}

.close-btn {
    cursor: pointer;
    font-weight: 600;
    padding: 3px 6px;
    border-radius: 4px;
    transition: background-color 0.2s, color 0.2s;
}

.close-btn:hover {
    color: #ffffff;
    background-color: rgba(255, 255, 255, 0.15);
}
</style>
<link rel="stylesheet" href="/css/mainPopup.css" >
<script src="/js/mainPopup.js">
//브라우저 프레임(주소창/테두리)에 의해 줄어든 내부 크기를 정확히 500x540으로 자동 보정
window.onload = function() {
    const targetWidth = 500;
    const targetHeight = 540;
    
    const diffWidth = window.outerWidth - window.innerWidth;
    const diffHeight = window.outerHeight - window.innerHeight;
    
    window.resizeTo(targetWidth + diffWidth, targetHeight + diffHeight);
};
</script>
</head>
<body>
	<img src="/images/mainPopup.png" class="popup-img"> <br>
	
	<div class="footer-bar">
        <span class="hide-btn" onclick="hidePopupForDay()">오늘 하루 동안 보지 않기</span>
        <span class="close-btn" onclick="window.close()">[닫기]</span>
    </div>
</body>
</html>
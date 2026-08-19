<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
    /* 1. 페이지 전체(body)가 최소한 모니터 화면 전체 높이(100vh)를 차지하도록 설정 */
    html, body {
        height: 100%;
        margin: 0;
    }

    body {
        display: flex;
        flex-direction: column;
        min-height: 100vh;
    }

    /* 2. 본문 영역(header와 footer 사이의 컨테이너들)이 남는 공간을 모두 채우도록 설정 */
    header {
        flex-shrink: 0;
    }

    /* header 다음, footer 바로 앞에 오는 모든 요소(본문 컨테이너)가 팽창하도록 처리 */
    header ~ *:not(footer) {
        flex: 1 0 auto;
    }

    /* 3. 하단 푸터 */
    footer {
        background-color: #FAF0E6; /* 헤더와 동일한 크림색 */
        color: #7A6A60;
        padding: 20px;
        text-align: center;
        border-top: 1px solid #EFE0D3;
        flex-shrink: 0; /* 높이 줄어듦 방지 */
        width: 100%;
        box-sizing: border-box;
    }

    .footer-content {
        max-width: 1200px;
        margin: 0 auto;
        font-size: 14px;
    }
</style>

<footer>
    <div class="footer-content">
        <p>Copyright © Pageland. All rights reserved.</p>
    </div>
</footer>
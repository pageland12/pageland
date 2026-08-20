<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    header {
        width: 100%;
        background-color: #FAF0E6;
        color: #5A4A42;
        border-bottom: 1px solid #EFE0D3;
        font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
    }

    /* 상단 배너 영역 */
    .top-banner {
        background-color: #F5C042;
        color: #FFFFFF;
        width: 100%;
        height: 44px;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 14px;
        font-weight: bold;
        transition: background-color 0.5s ease;
        overflow: hidden;
    }

    .top-banner span {
        position: absolute;
        transition: opacity 0.3s ease, transform 0.3s ease;
        opacity: 1;
        transform: translateY(0);
        white-space: nowrap;
    }

    .top-banner span.fade-out {
        opacity: 0;
        transform: translateY(-5px);
    }

    /* 메인 헤더 컨테이너 */
    .header-container {
        width: 100%;
        max-width: 1680px;
        margin: 0 auto;
        padding: 15px 50px 20px 50px;
        box-sizing: border-box;

        display: flex;
        flex-direction: column;
        align-items: center;
        position: relative;
    }

    /* 최상단 유저 바 (로그인/마이페이지 등)는 오른쪽 정렬 고정 */
    .top-user-bar {
        position: absolute;
        right: 50px;
        top: 15px;
        display: flex;
        align-items: center;
    }

    .user-menu {
        display: flex;
        gap: 12px;
        align-items: center;
        font-size: 14px;
    }

    .user-menu a {
        color: #7A6A60;
        text-decoration: none;
    }

    .user-menu a:hover {
        color: #2C221E;
    }

    .user-menu .divider {
        color: #D4C4B7;
        font-size: 12px;
        margin: 0 2px;
    }

    /* 로고 영역 (헤더 정중앙 배치) */
    .logo-area {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 15px;
    }

    .logo-area img {
        height: 100px;
        width: auto;
        object-fit: contain;
        display: block;
        cursor: pointer;
    }

    /* 네비게이션 바 영역 (화면 중앙 정렬) */
    .nav-bar {
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        padding-top: 5px;
        position: relative;
    }

    /* 햄버거 아이콘 (상품 영역의 가장 왼쪽 패딩선에 일치시킴) */
    .menu-icon {
        position: absolute;
        left: 0px;
        font-size: 28px;
        cursor: pointer;
        color: #222;
        display: flex;
        align-items: center;
    }

    /* 6개 메뉴 리스트 (정중앙 대칭 배치) */
    .nav-menu {
        display: flex;
        gap: 60px;
        list-style: none;
        margin: 0;
        padding: 0;
        align-items: center;
    }

    .nav-menu li {
        white-space: nowrap;
    }

    .nav-menu a {
        color: #222222;
        text-decoration: none;
        font-weight: bold;
        font-size: 20px;
        letter-spacing: -0.5px;
    }

    .nav-menu a:hover {
        color: #8B5E3C;
    }

    .nav-select {
        border: none;
        background: transparent;
        font-weight: bold;
        font-size: 20px;
        color: #222;
        cursor: pointer;
        outline: none;
        padding: 0;
    }
</style>

<header>
    <!-- 상단 배너 -->
    <div class="top-banner" id="topBanner">
        <span id="bannerText">사자니 부담되고~ 사고나니 후회될 땐, 빌려보세요!</span>
    </div>

    <!-- 메인 헤더 영역 -->
    <div class="header-container">
        <!-- 유저 메뉴 (오른쪽 상단 고정) -->
        <div class="top-user-bar">
            <div class="user-menu">
                <sec:authorize access="isAnonymous()">
                    <a href="/loginForm">로그인</a>
                    <span class="divider">|</span>
                    <a href="/guest/writeForm">회원가입</a>
                </sec:authorize>

                <sec:authorize access="hasAnyRole('NORMAL', 'SUBSCRIBER')">
                    <a href="/logout">로그아웃</a>
                    <span class="divider">|</span>
                    <a href="/member/memberMain">마이페이지</a>
                    <span class="divider">|</span>
                    <a href="/cart/cartList">장바구니</a>
                    <span class="divider">|</span>
                    <a href="/member/orderList">주문조회</a>
                </sec:authorize>

                <sec:authorize access="hasRole('ADMIN')">
                    <a href="/logout">로그아웃</a>
                    <span class="divider">|</span>
                    <a href="/admin/adminMain">관리자페이지</a>
                </sec:authorize>
            </div>
        </div>

        <!-- 로고 (logo1.png 기본 / 마우스 올리면 logo2.png로 변경) -->
        <div class="logo-area">
            <a href="/">
                <img src="/images/logo1.png" 
                     alt="페이지랜드" 
                     id="mainLogo"
                     onmouseover="this.src='/images/logo2.png'" 
                     onmouseout="this.src='/images/logo1.png'">
            </a>
        </div>

        <!-- 네비게이션 바 (햄버거 + 중앙 정렬된 6개 메뉴) -->
        <nav class="nav-bar">
            <span class="menu-icon">☰</span>
            <ul class="nav-menu">
                <li><a href="/guest/allBookList">전체 상품</a></li>
                <li><a href="/guest/allBookAgeList">연령별</a></li>
                <li><a href="/guest/allBookGenreList">분야별</a></li>
                <li><a href="/guest/allBookPublisherList">출판사별</a></li>
                <li><a href="/guest/allPassList">구독 서비스</a></li>
                <li>
                    <select class="nav-select" onchange="if(this.value) location.href=this.value;">
                        <option value="">고객센터</option>
                        <option value="/guest/noticeList">공지사항</option>
                        <option value="/guest/eventList">이벤트</option>
                        <option value="/guest/qnaList">Q&A</option>
                        <option value="/guest/ratingList">후기</option>
                    </select>
                </li>
            </ul>
        </nav>
    </div>
</header>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const bannerData = [
            {
                text: "사자니 부담되고~ 사고나니 후회될 땐, 빌려보세요!",
                bg: "#F5C042"
            },
            {
                text: "[No.1 어린이 도서대여] 신간, 인기도서 매주 업데이트",
                bg: "#72B0DC"
            }
        ];

        let currentIndex = 0;
        const bannerEl = document.getElementById("topBanner");
        const textEl = document.getElementById("bannerText");

        setInterval(function() {
            textEl.classList.add("fade-out");

            setTimeout(function() {
                currentIndex = (currentIndex + 1) % bannerData.length;
                textEl.textContent = bannerData[currentIndex].text;
                bannerEl.style.backgroundColor = bannerData[currentIndex].bg;

                textEl.classList.remove("fade-out");
            }, 300);
        }, 3000);
    });
</script>
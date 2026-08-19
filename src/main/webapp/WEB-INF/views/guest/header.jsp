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

    .top-banner {
        background-color: #F5C042;
        color: #FFFFFF;
        text-align: center;
        padding: 12px 0;
        font-size: 14px;
        font-weight: bold;
        transition: background-color 0.5s ease;
    }

    .top-banner span {
        display: inline-block;
        transition: opacity 0.3s ease, transform 0.3s ease;
        opacity: 1;
        transform: translateY(0);
    }

    .top-banner span.fade-out {
        opacity: 0;
        transform: translateY(-5px);
    }

    .header-container {
        width: 100%;
        max-width: 1680px;
        margin: 0 auto;
        padding: 15px 50px 20px 50px;
        box-sizing: border-box;

        display: grid;
        grid-template-columns: auto 1fr;
        column-gap: 50px;
        align-items: center;
    }

    .logo-area {
        grid-row: span 2; 
        display: flex;
        align-items: center;
    }

    .logo-area img {
        height: 120px;
        width: auto;
        object-fit: contain;
        display: block;
    }

    .top-user-bar {
        display: flex;
        justify-content: flex-end;
        padding-bottom: 5px;
    }

    .user-menu {
        display: flex;
        gap: 18px;
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

    .nav-bar {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-top: 5px;
    }

    .nav-center-group {
        display: flex;
        align-items: center;
        gap: 35px;
    }

    .menu-icon {
        font-size: 28px;
        cursor: pointer;
        color: #222;
        display: flex;
        align-items: center;
    }

    .nav-menu {
        display: flex;
        gap: 50px;
        list-style: none;
        margin: 0;
        padding: 0;
        align-items: center;
    }

    .nav-menu a {
        color: #222222;
        text-decoration: none;
        font-weight: bold;
        font-size: 20px;
        letter-spacing: -0.5px;
        white-space: nowrap;
    }

    .nav-menu a.highlight {
        color: #000000;
        font-weight: 900;
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

    .icon-menu {
        display: flex;
        align-items: center;
    }

    .icon-btn {
        background: none;
        border: none;
        font-size: 28px;
        cursor: pointer;
        color: #333;
        text-decoration: none;
    }
</style>

<header>
    <div class="top-banner" id="topBanner">
        <span id="bannerText">사자니 부담되고~ 사고나니 후회될 땐, 빌려보세요!</span>
    </div>

    <div class="header-container">
        <div class="logo-area">
            <a href="/">
                <img src="/images/logo.png" alt="페이지랜드">
            </a>
        </div>

        <div class="top-user-bar">
            <div class="user-menu">
                <sec:authorize access="isAnonymous()">
                    <a href="/loginForm">로그인</a>
                    <a href="/guest/writeForm">회원가입</a>
                </sec:authorize>

                <sec:authorize access="hasAnyRole('NORMAL', 'SUBSCRIBER')">
                    <a href="/logout">로그아웃</a>
                    <a href="/member/memberMain">마이페이지</a>
                    <a href="/member/orderList">주문조회</a>
                </sec:authorize>

                <sec:authorize access="hasRole('ADMIN')">
                    <a href="/logout">로그아웃</a>
                    <a href="/admin/adminMain">관리자페이지</a>
                </sec:authorize>
            </div>
        </div>

        <div class="nav-bar">
            <div class="nav-center-group">
                <span class="menu-icon">☰</span>
                <ul class="nav-menu">
                    <li><a href="/guest/allBookList" class="highlight">BEST</a></li>
                    <li><a href="/guest/allBookAgeList">연령별</a></li>
                    <li><a href="/guest/allBookList">전체 상품</a></li>
                    <li><a href="/guest/allPassList">구독 서비스</a></li>
                    <li><a href="/guest/allBookGenreList">분야별</a></li>
                    <li><a href="/guest/allBookPublisherList">출판사별</a></li>
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
            </div>

            <div class="icon-menu">
                <a href="/cart/cartList" class="icon-btn" title="장바구니">🛍️</a>
            </div>
        </div>
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
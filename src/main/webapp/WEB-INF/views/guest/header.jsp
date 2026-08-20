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
        position: relative;
        z-index: 100;
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
        max-width: 1200px;
        margin: 0 auto;
        padding: 15px 20px 20px 20px;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
        align-items: center;
        position: relative;
    }

    /* 최상단 유저 바 */
    .top-user-bar {
        position: absolute;
        right: 20px;
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

    /* 로고 영역 */
    .logo-area {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 15px;
        height: 100px;
    }

    .logo-area img {
        width: 250px;
        height: 100px;
        object-fit: contain;
        display: block;
        cursor: pointer;
        transition: transform 0.2s ease;
    }

    .logo-area img.logo-hover-effect {
        transform: scale(1.05);
    }

    /* 네비게이션 바 영역 */
    .nav-bar {
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        padding-top: 5px;
        position: relative;
    }

    /* 햄버거 아이콘 */
    .menu-icon {
        position: absolute;
        left: 10px;
        font-size: 28px;
        cursor: pointer;
        color: #222;
        display: flex;
        align-items: center;
        user-select: none;
        transition: color 0.2s ease;
    }

    .menu-icon:hover {
        color: #8B5E3C;
    }

    /* 상단 네비게이션 메뉴 그리드 */
    .menu-grid-wrapper {
        width: 100%;
        max-width: 960px;
        display: grid;
        grid-template-columns: repeat(6, 1fr);
        align-items: center;
        margin: 0 auto;
        padding: 0;
        list-style: none;
    }

    /* 네비게이션 드롭다운 내부 그리드 (상단 정렬) */
    .dropdown-grid-wrapper {
        width: 100%;
        max-width: 960px;
        display: grid;
        grid-template-columns: repeat(6, 1fr);
        align-items: start;
        margin: 0 auto;
        padding: 0;
    }

    .nav-menu > li {
        position: relative;
        white-space: nowrap;
        text-align: center;
        padding: 10px 0;
    }

    .nav-menu > li > a {
        color: #222222;
        text-decoration: none;
        font-weight: bold;
        font-size: 19px;
        letter-spacing: -0.5px;
        display: inline-block;
    }

    .nav-menu > li > a:hover {
        color: #8B5E3C;
    }

    /* --- [복구] 마우스 호버 시 나오는 개별 소메뉴(submenu) --- */
    .submenu {
        position: absolute;
        top: 100%;
        left: 50%;
        transform: translateX(-50%);
        background-color: #FFFFFF;
        border: 1px solid #EFE0D3;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.08);
        list-style: none;
        padding: 10px 0;
        margin: 0;
        min-width: 130px;
        display: none;
        z-index: 10;
        border-radius: 4px;
    }

    .nav-menu > li:hover .submenu {
        display: block;
    }

    .submenu li {
        padding: 6px 15px;
        text-align: center;
    }

    .submenu li a {
        color: #5A4A42;
        text-decoration: none;
        font-size: 14px;
        font-weight: normal;
        display: block;
        white-space: nowrap;
        transition: color 0.2s ease;
    }

    .submenu li a:hover {
        color: #8B5E3C;
        font-weight: bold;
    }

    /* 전체 메뉴 드롭다운 (햄버거 메뉴 클릭) 스타일 */
    .all-menu-dropdown {
        display: none;
        position: absolute;
        top: 100%;
        left: 0;
        width: 100%;
        background-color: #FFFFFF;
        border-bottom: 2px solid #8B5E3C;
        box-shadow: 0 10px 15px rgba(0, 0, 0, 0.08);
        z-index: 1000;
        padding: 30px 0;
    }

    .all-menu-dropdown.active {
        display: block;
        animation: slideDown 0.25s ease-out forwards;
    }

    @keyframes slideDown {
        from { opacity: 0; transform: translateY(-10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .all-menu-container {
        width: 100%;
        display: flex;
        justify-content: center;
        padding: 0 20px;
        box-sizing: border-box;
    }

    .menu-category {
        text-align: center;
    }

    .menu-category h4 {
        margin: 0 0 15px 0;
        padding-bottom: 8px;
        font-size: 18px;
        color: #8B5E3C;
        border-bottom: 2px solid #FAF0E6;
        white-space: nowrap;
        display: inline-block;
    }

    .menu-category ul {
        list-style: none;
        padding: 0;
        margin: 0;
    }

    .menu-category ul li {
        margin-bottom: 10px;
        white-space: nowrap;
    }

    .menu-category ul li a {
        color: #555;
        text-decoration: none;
        font-size: 15px;
        transition: color 0.2s;
    }

    .menu-category ul li a:hover {
        color: #8B5E3C;
        font-weight: bold;
    }
</style>

<header>
    <!-- 상단 배너 -->
    <div class="top-banner" id="topBanner">
        <span id="bannerText">사자니 부담되고~ 사고나니 후회될 땐, 빌려보세요!</span>
    </div>

    <!-- 메인 헤더 영역 -->
    <div class="header-container">
        <!-- 유저 메뉴 -->
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

        <!-- 로고 영역 -->
        <div class="logo-area">
            <a href="/">
                <img src="/images/logo1.png" 
                     alt="페이지랜드" 
                     id="mainLogo"
                     onmouseover="this.src='/images/logo2.png'; this.classList.add('logo-hover-effect');" 
                     onmouseout="this.src='/images/logo1.png'; this.classList.remove('logo-hover-effect');">
            </a>
        </div>

        <!-- 네비게이션 바 (개별 마우스 호버 소메뉴 포함) -->
        <nav class="nav-bar">
            <span class="menu-icon" id="allMenuBtn">☰</span>
            <ul class="nav-menu menu-grid-wrapper">
                <!-- 1. 전체 상품 -->
                <li>
                    <a href="/guest/allBookList">전체 상품</a>
                </li>
                <!-- 2. 연령별 -->
                <li>
                    <a href="/guest/allBookAgeList">연령별</a>
                    <ul class="submenu">
                        <li><a href="/guest/allBookAgeList?category=0-3세">0 - 3세</a></li>
                        <li><a href="/guest/allBookAgeList?category=4-7세">4 - 7세</a></li>
                        <li><a href="/guest/allBookAgeList?category=초등 저학년">초등 저학년</a></li>
                        <li><a href="/guest/allBookAgeList?category=초등 고학년">초등 고학년</a></li>
                    </ul>
                </li>
                <!-- 3. 분야별 -->
                <li>
                    <a href="/guest/allBookGenreList">분야별</a>
                    <ul class="submenu">
                        <li><a href="/guest/allBookGenreList?genre=생활/창작">생활/창작</a></li>
                        <li><a href="/guest/allBookGenreList?genre=수학/영어">수학/영어</a></li>
                        <li><a href="/guest/allBookGenreList?genre=자연/과학">자연/과학</a></li>
                        <li><a href="/guest/allBookGenreList?genre=전래/명작">전래/명작</a></li>
                    </ul>
                </li>
                <!-- 4. 출판사별 -->
                <li>
                    <a href="/guest/allBookPublisherList">출판사별</a>
                    <ul class="submenu">
                        <li><a href="/guest/allBookPublisherList?publisher=그레이트북스">그레이트북스</a></li>
                        <li><a href="/guest/allBookPublisherList?publisher=아람북스">아람북스</a></li>
                        <li><a href="/guest/allBookPublisherList?publisher=키즈스콜레">키즈스콜레</a></li>
                        <li><a href="/guest/allBookPublisherList?publisher=프뢰벨">프뢰벨</a></li>
                    </ul>
                </li>
                <!-- 5. 구독 서비스 -->
                <li>
                    <a href="/guest/allPassList">구독 서비스</a>
                </li>
                <!-- 6. 고객센터 -->
                <li>
                    <a href="/guest/noticeList">고객센터</a>
                    <ul class="submenu">
                    	<li><a href="/guest/qnaList">Q&A</a></li>
                    	<li><a href="/guest/eventList">이벤트</a></li>
                        <li><a href="/guest/noticeList">공지사항</a></li>
                        <li><a href="/guest/ratingList">후기</a></li>
                    </ul>
                </li>
            </ul>
        </nav>
    </div>

    <!-- 전체 메뉴 드롭다운 영역 (☰ 클릭 시) -->
    <div class="all-menu-dropdown" id="allMenuDropdown">
        <div class="all-menu-container">
            <div class="dropdown-grid-wrapper">
                <!-- 1. 전체 상품 -->
                <div class="menu-category">
                    <h4>전체 상품</h4>
                </div>

                <!-- 2. 연령별 -->
                <div class="menu-category">
                    <h4>연령별</h4>
                    <ul>
                        <li><a href="/guest/allBookAgeList?category=0-3세">0 - 3세</a></li>
                        <li><a href="/guest/allBookAgeList?category=4-7세">4 - 7세</a></li>
                        <li><a href="/guest/allBookAgeList?category=초등 저학년">초등 저학년</a></li>
                        <li><a href="/guest/allBookAgeList?category=초등 고학년">초등 고학년</a></li>
                    </ul>
                </div>

                <!-- 3. 분야별 -->
                <div class="menu-category">
                    <h4>분야별</h4>
                    <ul>
                        <li><a href="/guest/allBookGenreList?genre=생활/창작">생활/창작</a></li>
                        <li><a href="/guest/allBookGenreList?genre=수학/영어">수학/영어</a></li>
                        <li><a href="/guest/allBookGenreList?genre=자연/과학">자연/과학</a></li>
                        <li><a href="/guest/allBookGenreList?genre=전래/명작">전래/명작</a></li>
                    </ul>
                </div>

                <!-- 4. 출판사별 -->
                <div class="menu-category">
                    <h4>출판사별</h4>
                    <ul>
                        <li><a href="/guest/allBookPublisherList?publisher=그레이트북스">그레이트북스</a></li>
                        <li><a href="/guest/allBookPublisherList?publisher=아람북스">아람북스</a></li>
                        <li><a href="/guest/allBookPublisherList?publisher=키즈스콜레">키즈스콜레</a></li>
                        <li><a href="/guest/allBookPublisherList?publisher=프뢰벨">프뢰벨</a></li>
                    </ul>
                </div>

                <!-- 5. 구독 서비스 -->
                <div class="menu-category">
                    <h4>구독 서비스</h4>
                </div>

                <!-- 6. 고객센터 -->
                <div class="menu-category">
                    <h4>고객센터</h4>
                    <ul>
                        <li><a href="/guest/qnaList">Q&A</a></li>
                        <li><a href="/guest/eventList">이벤트</a></li>
                        <li><a href="/guest/noticeList">공지사항</a></li>
                        <li><a href="/guest/ratingList">후기</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</header>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        // 상단 배너 롤링
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

        // 전체 메뉴 드롭다운 토글 (☰ 버튼)
        const allMenuBtn = document.getElementById("allMenuBtn");
        const allMenuDropdown = document.getElementById("allMenuDropdown");

        if (allMenuBtn && allMenuDropdown) {
            allMenuBtn.addEventListener("click", function(e) {
                e.stopPropagation();
                allMenuDropdown.classList.toggle("active");
            });

            document.addEventListener("click", function(e) {
                if (!allMenuDropdown.contains(e.target) && e.target !== allMenuBtn) {
                    allMenuDropdown.classList.remove("active");
                }
            });
        }
    });
</script>
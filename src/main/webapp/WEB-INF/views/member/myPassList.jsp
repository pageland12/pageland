<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 내 구독권 / N회권</title>
<style>
    .mypage-wrapper {
        width: 100%;
        max-width: 1400px;
        margin: 0 auto;
        padding: 50px 30px 60px 30px;
        box-sizing: border-box;
        display: flex;
        gap: 40px;
        align-items: flex-start;
    }

    .mypage-main {
        flex: 1;
        background-color: #FFFFFF;
        border-radius: 12px;
        padding: 30px;
        border: 1px solid #EFE0D3;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
        box-sizing: border-box;
    }

    .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 18px;
        margin-bottom: 25px;
        border-bottom: 2px solid #5A4A42;
    }

    .content-title {
        font-size: 1.45rem;
        font-weight: 800;
        color: #2C221E;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .tab-container {
        margin-bottom: 20px;
    }

    .tab-btn {
        display: inline-block;
        padding: 8px 18px;
        background-color: #8B5E3C;
        color: #FFFFFF;
        font-weight: 700;
        font-size: 0.95rem;
        border-radius: 8px;
        text-decoration: none;
    }

    /* 패스 리스트 카드 스타일 */
    .pass-list-container {
        display: flex;
        flex-direction: column;
        gap: 16px;
    }

    .pass-card {
        display: flex;
        align-items: center;
        padding: 20px;
        background-color: #FCF9F6;
        border: 1px solid #EFE0D3;
        border-radius: 10px;
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .pass-card:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }

    .pass-img-wrapper {
        margin-right: 22px;
        flex-shrink: 0;
    }

    .pass-thumb {
        width: 85px;
        height: 85px;
        object-fit: cover;
        border-radius: 8px;
        border: 1px solid #E8D8CA;
        display: block;
    }

    .no-img-box {
        width: 85px;
        height: 85px;
        background-color: #EFE0D3;
        color: #7A6A60;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 12px;
        font-weight: 700;
        border-radius: 8px;
    }

    .pass-info {
        flex-grow: 1;
    }

    .pass-name-row {
        display: flex;
        align-items: center;
        gap: 8px;
        margin-bottom: 8px;
    }

    .pass-name {
        font-size: 1.15rem;
        font-weight: 800;
        color: #2C221E;
    }

    .badge {
        display: inline-block;
        padding: 4px 10px;
        font-size: 0.8rem;
        font-weight: 700;
        border-radius: 20px;
    }

    .badge-npass {
        background-color: #E3F2FD;
        color: #1976D2;
        border: 1px solid #BBDEFB;
    }

    .badge-sub {
        background-color: #E8F5E9;
        color: #2E7D32;
        border: 1px solid #C8E6C9;
    }

    .pass-detail-text {
        font-size: 0.95rem;
        color: #555555;
        margin-bottom: 4px;
    }

    .pass-detail-sub {
        font-size: 0.85rem;
        color: #888888;
    }

    .pass-status-box {
        text-align: right;
        min-width: 90px;
        flex-shrink: 0;
    }

    .status-active {
        color: #2E7D32;
        font-weight: 800;
        font-size: 1rem;
        background-color: #E8F5E9;
        padding: 6px 12px;
        border-radius: 6px;
        border: 1px solid #C8E6C9;
    }

    .empty-msg {
        text-align: center;
        padding: 60px 0;
        color: #888888;
        font-size: 1rem;
    }

    /* 페이징 영역 */
    .pagination {
        text-align: center;
        margin-top: 30px;
    }

    .pagination a {
        display: inline-block;
        padding: 6px 12px;
        margin: 0 3px;
        color: #5A4A42;
        text-decoration: none;
        border: 1px solid #E0D2C7;
        border-radius: 4px;
        font-size: 0.9rem;
    }

    .pagination a:hover {
        background-color: #F2E3D5;
    }

    .pagination .current-page {
        display: inline-block;
        padding: 6px 12px;
        margin: 0 3px;
        background-color: #8B5E3C;
        color: #FFFFFF;
        font-weight: 700;
        border-radius: 4px;
        border: 1px solid #8B5E3C;
        font-size: 0.9rem;
    }
</style>
</head>
<body>
    <!-- 상단 헤더 include -->
    <%@ include file="../guest/header.jsp" %>

    <div class="mypage-wrapper">
        <!-- 좌측 사이드바 include -->
        <%@ include file="memberSidebar.jsp" %>

        <!-- 우측 본문 영역 -->
        <main class="mypage-main">
            <div class="content-header">
                <h2 class="content-title">내 구독권 / N회권 정보</h2>
            </div>

            <!-- 탭 영역 -->
            <div class="tab-container">
                <span class="tab-btn">사용 중인 이용권</span>
            </div>

            <!-- 이용권 카드 리스트 -->
            <div class="pass-list-container">
                <c:choose>
                    <c:when test="${empty passList}">
                        <div class="empty-msg">
                            현재 사용 중인 이용권 정보가 없습니다.
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="pass" items="${passList}">
                            <div class="pass-card">
                                <!-- 1. 이용권 이미지 -->
                                <div class="pass-img-wrapper">
                                    <c:choose>
                                        <c:when test="${not empty pass.pimg}">
                                            <img src="${pass.pimg}" alt="${pass.pname}" class="pass-thumb">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="no-img-box">NO IMAGE</div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <!-- 2. 이용권 상세 정보 -->
                                <div class="pass-info">
                                    <div class="pass-name-row">
                                        <span class="pass-name">${pass.pname}</span>
                                        <c:choose>
                                            <c:when test="${pass.ptype eq 'N회권'}">
                                                <span class="badge badge-npass">N회권</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-sub">정기 구독권</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>

                                    <!-- N회권 세부 -->
                                    <c:if test="${pass.ptype eq 'N회권'}">
                                        <div class="pass-detail-text">
                                            잔여 횟수: <strong style="color: #1976D2; font-size: 1.05rem;">${pass.mpcount}회</strong>
                                        </div>
                                    </c:if>

                                    <!-- 정기권 세부 -->
                                    <c:if test="${pass.ptype eq '정기권'}">
                                        <div class="pass-detail-text">
                                            남은 기간: 
                                            <c:choose>
                                                <c:when test="${pass.daysLeft > 0}">
                                                    <strong style="color: #2E7D32;">D-${pass.daysLeft}</strong> (${pass.daysLeft}일 남음)
                                                </c:when>
                                                <c:when test="${pass.daysLeft == 0}">
                                                    <strong style="color: #D32F2F;">D-Day (오늘 만료)</strong>
                                                </c:when>
                                                <c:otherwise>
                                                    <span style="color: #888;">기간 만료</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="pass-detail-sub">
                                            이용 기간: ${pass.mpstart} ~ ${pass.mpend}
                                        </div>
                                    </c:if>
                                </div>

                                <!-- 3. 상태 표시 -->
                                <div class="pass-status-box">
                                    <span class="status-active">${pass.mpstatus}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 페이징 영역 -->
            <c:if test="${not empty passList}">
                <div class="pagination">
                    <c:if test="${startPage > 1}">
                        <a href="/member/myPassList?pageNum=${startPage - 1}">[이전]</a>
                    </c:if>

                    <c:forEach begin="${startPage}" end="${endPage}" var="num">
                        <c:choose>
                            <c:when test="${pageNum == num}">
                                <span class="current-page">${num}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="/member/myPassList?pageNum=${num}">${num}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${endPage < totalPages}">
                        <a href="/member/myPassList?pageNum=${endPage + 1}">[다음]</a>
                    </c:if>
                </div>
            </c:if>
        </main>
    </div>

    <!-- 하단 푸터 include -->
    <%@ include file="../guest/footer.jsp" %>
</body>
</html>
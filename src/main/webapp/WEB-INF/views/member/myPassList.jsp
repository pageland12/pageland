<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 내 구독권 / N회권</title>
<link rel="stylesheet" href="/css/myList.css">
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
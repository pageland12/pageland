<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 구독권 / N회권 정보</title>
<style>
    .all-btn {
        display: inline-block;
        padding: 6px 14px;
        margin-right: 4px;
        background-color: #f8f9fa;
        color: #333;
        text-decoration: none;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .all-btn.active {
        background-color: #212529;
        color: #ffffff;
        font-weight: bold;
        border-color: #212529;
    }
    .no-img-box {
        width: 80px;
        height: 80px;
        background-color: #f0f0f0;
        color: #aaa;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 11px;
        border-radius: 6px;
    }
    .badge {
        display: inline-block;
        padding: 3px 8px;
        font-size: 12px;
        font-weight: bold;
        border-radius: 12px;
        margin-left: 6px;
    }
    .badge-count { background-color: #e3f2fd; color: #0d6efd; }
    .badge-sub { background-color: #e8f5e9; color: #2e7d32; }
    .status-active { color: #198754; font-weight: bold; }
</style>
</head>
<body>

    <!-- 상단 메인 이동 링크 -->
    <div style="text-align: right; margin-bottom: 10px;">
        <a href="/" style="text-decoration: none; color: #555; font-size: 14px;">🏠 메인 페이지로 이동</a>
    </div>

    <!-- 헤더 영역 -->
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
        <h2>🎫 내 구독권 / N회권 정보</h2>
        <button type="button" onclick="history.back()" style="padding: 6px 12px; background-color: #6c757d; color: white; border: none; border-radius: 4px; cursor: pointer;">뒤로 가기</button>
    </div>

    <!-- 탭 영역 -->
    <div style="margin-bottom: 20px;">
        <a href="/member/myPassList" class="all-btn active">사용 중인 이용권</a>
    </div>

    <hr>

    <!-- 이용권 목록 카드 영역 -->
    <div style="width: 100%; max-width: 800px; margin: 0 auto;">
        
        <c:if test="${empty passList}">
            <div style="text-align: center; padding: 40px 0; color: #777;">
                사용 중인 이용권 정보가 없습니다.
            </div>
        </c:if>

        <c:forEach var="pass" items="${passList}">
            <div style="display: flex; align-items: center; padding: 16px 10px; border-bottom: 1px solid #ddd;">
                
                <!-- 1. 이용권 이미지 -->
                <div style="margin-right: 18px;">
                    <c:choose>
                        <c:when test="${not empty pass.pimg}">
                            <img src="${pass.pimg}" width="80" height="80" style="object-fit: cover; border-radius: 6px; border: 1px solid #eee;">
                        </c:when>
                        <c:otherwise>
                            <div class="no-img-box">NO IMAGE</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 2. 이용권 정보 -->
                <div style="flex-grow: 1;">
                    <div style="font-size: 17px; font-weight: bold; color: #333; margin-bottom: 6px;">
                        ${pass.pname}
                        <c:choose>
                            <c:when test="${pass.ptype eq 'N회권'}">
                                <span class="badge badge-count">N회권</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge badge-sub">정기 구독권</span>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- N회권 상세 -->
                    <c:if test="${pass.ptype eq 'N회권'}">
                        <div style="font-size: 14px; color: #555; margin-bottom: 2px;">
                            남은 횟수: <strong style="color: #0d6efd; font-size: 15px;">${pass.mpcount}회</strong>
                        </div>
                    </c:if>

                    <!-- 정기권 상세 -->
                    <c:if test="${pass.ptype eq '정기권'}">
                        <div style="font-size: 14px; color: #555; margin-bottom: 2px;">
                            남은 기간: 
                            <c:choose>
                                <c:when test="${pass.daysLeft > 0}">
                                    <strong style="color: #2e7d32;">D-${pass.daysLeft}</strong> (${pass.daysLeft}일 남음)
                                </c:when>
                                <c:when test="${pass.daysLeft == 0}">
                                    <strong style="color: #d32f2f;">D-Day (오늘 만료)</strong>
                                </c:when>
                                <c:otherwise>
                                    <span style="color: #777;">기간 만료</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div style="font-size: 13px; color: #888;">
                            이용 기간: ${pass.mpstart} ~ ${pass.mpend}
                        </div>
                    </c:if>
                </div>

                <!-- 3. 상태 표시 -->
                <div style="text-align: right; min-width: 80px;">
                    <span class="status-active">${pass.mpstatus}</span>
                </div>

            </div>
        </c:forEach>
    </div>

    <!-- 페이지 번호 이동 영역 (최대 5개씩) -->
    <c:if test="${not empty passList}">
        <div style="text-align: center; margin-top: 25px;">
        
            <%-- 이전 버튼 --%>
            <c:if test="${startPage > 1}">
                <a href="/member/myPassList?pageNum=${startPage - 1}" style="margin-right: 5px; text-decoration: none; color: black;">[이전]</a>
            </c:if>

            <%-- 페이지 번호 --%>
            <c:forEach begin="${startPage}" end="${endPage}" var="num">
                <c:choose>
                    <c:when test="${pageNum == num}">
                        <span style="font-weight: bold; color: red; margin: 0 5px; font-size: 16px;">${num}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="/member/myPassList?pageNum=${num}" style="margin: 0 5px; text-decoration: none; color: black;">${num}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <%-- 다음 버튼 --%>
            <c:if test="${endPage < totalPages}">
                <a href="/member/myPassList?pageNum=${endPage + 1}" style="margin-left: 5px; text-decoration: none; color: black;">[다음]</a>
            </c:if>

        </div>
    </c:if>

</body>
</html>
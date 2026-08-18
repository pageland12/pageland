<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 구독권</title>
<style>
    /* 버튼 탭 스타일 */
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
    /* 현재 선택된 버튼 스타일 */
    .all-btn.active {
        background-color: #212529;
        color: #ffffff;
        font-weight: bold;
        border-color: #212529;
    }
</style>
</head>
<body>

    <!-- 상단 메인 이동 링크 -->
    <div style="text-align: right; margin-bottom: 10px;">
        <a href="/" style="text-decoration: none; color: #555; font-size: 14px;">🏠 메인 페이지로 이동</a>
    </div>

    <!-- 헤더 타이틀 -->
    <h2>🎟️ 전체 구독권</h2>

    <!-- 탭 버튼 영역 -->
    <div style="margin-bottom: 20px;">
        <a href="/guest/allPassList" class="all-btn active">전체</a>
    </div>

    <hr>

    <!-- 전체 구독권 목록 출력 -->
    <div style="width: 100%; max-width: 800px; margin: 0 auto;">
        <c:forEach var="pass" items="${passes}">
            <div onclick="location.href='/guest/passDetail?pno=${pass.pno}'" 
                 style="display: flex; align-items: center; padding: 12px; border-bottom: 1px solid #ddd; cursor: pointer; transition: background-color 0.2s;"
                 onmouseover="this.style.backgroundColor='#f9f9f9';" 
                 onmouseout="this.style.backgroundColor='transparent';">
                
                <!-- 1. 이미지 -->
                <div style="margin-right: 15px;">
                    <img src="${pass.pimg}" width="80" height="80" style="object-fit: cover; border-radius: 4px;">
                </div>
                
                <!-- 2. 구독권 이름 및 혜택 설명 -->
                <div style="flex-grow: 1;">
                    <div style="font-weight: bold; font-size: 16px; margin-bottom: 5px; color: #333;">
                        ${pass.pname}
                    </div>
                    <div style="font-size: 13px; color: #666;">
                        <span style="background-color: #e9ecef; padding: 2px 6px; border-radius: 3px; margin-right: 5px;">${pass.ptype}</span>
                        <c:choose>
                            <c:when test="${not empty pass.pperiod}">
                                ${pass.pperiod}일 동안 무제한 이용
                            </c:when>
                            <c:when test="${not empty pass.pcount}">
                                총 ${pass.pcount}회 대여 가능
                            </c:when>
                        </c:choose>
                    </div>
                </div>
                
                <!-- 3. 가격 -->
                <div style="font-weight: bold; font-size: 16px; color: #212529;">
                    <fmt:formatNumber value="${pass.pprice}" type="number"/>원
                </div>
                
            </div>
        </c:forEach>
    </div>
    
    <!-- 페이지 번호 이동 영역 (최대 5개씩 표시) -->
    <div style="text-align: center; margin-top: 20px;">
    
        <%-- 이전 버튼 --%>
        <c:if test="${startPage > 1}">
            <a href="/guest/allPassList?pageNum=${startPage - 1}" style="margin-right: 5px; text-decoration: none; color: black;">[이전]</a>
        </c:if>

        <%-- 5개 단위 페이지 번호 출력 --%>
        <c:forEach begin="${startPage}" end="${endPage}" var="num">
            <c:choose>
                <c:when test="${pageNum == num}">
                    <span style="font-weight: bold; color: red; margin: 0 5px; font-size: 16px;">${num}</span>
                </c:when>
                <c:otherwise>
                    <a href="/guest/allPassList?pageNum=${num}" style="margin: 0 5px; text-decoration: none; color: black;">${num}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <%-- 다음 버튼 --%>
        <c:if test="${endPage < totalPages}">
            <a href="/guest/allPassList?pageNum=${endPage + 1}" style="margin-left: 5px; text-decoration: none; color: black;">[다음]</a>
        </c:if>

    </div>

</body>
</html>
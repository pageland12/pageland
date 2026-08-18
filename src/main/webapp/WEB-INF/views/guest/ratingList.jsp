<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 목록</title>
<style>
    /* 탭 버튼 스타일 */
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
    /* 작성 버튼 스타일 */
    .write-btn {
        display: inline-block;
        padding: 6px 12px;
        background-color: #0d6efd;
        color: #fff;
        text-decoration: none;
        border-radius: 4px;
        font-size: 14px;
    }
    /* 이미지 더미 전용 스타일 */
    .no-img-box {
        width: 70px;
        height: 70px;
        background-color: #eee;
        color: #aaa;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 11px;
        border-radius: 4px;
    }
</style>
</head>
<body>

    <!-- 상단 메인 이동 링크 -->
    <div style="text-align: right; margin-bottom: 10px;">
        <a href="/" style="text-decoration: none; color: #555; font-size: 14px;">🏠 메인 페이지로 이동</a>
    </div>

    <!-- 헤더 및 작성 버튼 영역 -->
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
        <h2>⭐ 구매 후기</h2>
        <a href="/board/ratingWriteForm" class="write-btn">✏️ 후기 작성</a>
    </div>

    <!-- 탭 버튼 영역 -->
    <div style="margin-bottom: 20px;">
        <a href="/guest/ratingList" class="all-btn active">전체</a>
    </div>

    <hr>

    <!-- 후기 목록 출력 (표 제거) -->
    <div style="width: 100%; max-width: 800px; margin: 0 auto;">
        <c:forEach var="list" items="${list}">
            <div onclick="location.href='/guest/ratingView?rno=${list.rno}'" 
                 style="display: flex; align-items: center; padding: 14px 10px; border-bottom: 1px solid #ddd; cursor: pointer; transition: background-color 0.2s;"
                 onmouseover="this.style.backgroundColor='#f9f9f9';" 
                 onmouseout="this.style.backgroundColor='transparent';">
                
                <!-- 1. 첨부 이미지 썸네일 -->
                <div style="margin-right: 15px;">
                    <c:choose>
                        <c:when test="${not empty list.rfiles}">
                            <img src="/images/${list.rfiles}" width="70" height="70" style="object-fit: cover; border-radius: 4px;">
                        </c:when>
                        <c:otherwise>
                            <div class="no-img-box">NO IMAGE</div>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- 2. 제목, 별점, 작성자 -->
                <div style="flex-grow: 1; padding-right: 15px;">
                    <div style="font-weight: bold; font-size: 16px; margin-bottom: 4px; color: #333;">
                        ${list.rtitle}
                    </div>
                    <div style="font-size: 13px; color: #ff9800; margin-bottom: 4px;">
                        ★ 평점: ${list.rrate}점
                    </div>
                    <div style="font-size: 13px; color: #777;">
                        <span>작성자: ${list.mname ne null ? list.mname : '익명'}</span>
                    </div>
                </div>
                
                <!-- 3. 작성일 및 조회수 -->
                <div style="text-align: right; font-size: 13px; color: #888; white-space: nowrap;">
                    <div><fmt:formatDate value="${list.rdate}" pattern="yyyy-MM-dd" /></div>
                    <div style="margin-top: 4px;">조회수 ${list.rhit}</div>
                </div>

            </div>
        </c:forEach>
    </div>
    
    <!-- 페이지 번호 이동 영역 (최대 5개씩 표시) -->
    <div style="text-align: center; margin-top: 25px;">
    
        <%-- 이전 버튼 --%>
        <c:if test="${startPage > 1}">
            <a href="/guest/ratingList?pageNum=${startPage - 1}" style="margin-right: 5px; text-decoration: none; color: black;">[이전]</a>
        </c:if>

        <%-- 5개 단위 페이지 번호 --%>
        <c:forEach begin="${startPage}" end="${endPage}" var="num">
            <c:choose>
                <c:when test="${pageNum == num}">
                    <span style="font-weight: bold; color: red; margin: 0 5px; font-size: 16px;">${num}</span>
                </c:when>
                <c:otherwise>
                    <a href="/guest/ratingList?pageNum=${num}" style="margin: 0 5px; text-decoration: none; color: black;">${num}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <%-- 다음 버튼 --%>
        <c:if test="${endPage < totalPages}">
            <a href="/guest/ratingList?pageNum=${endPage + 1}" style="margin-left: 5px; text-decoration: none; color: black;">[다음]</a>
        </c:if>

    </div>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${view.abtitle} - 페이지랜드</title>
	<link rel="stylesheet" href="/css/abView.css">
</head>
<body>

    <!-- 헤더 인클루드 -->
    <%@ include file="header.jsp" %>

    <div class="view-container">
        
        <!-- 상단 카테고리 타이틀 -->
        <div class="page-category-title">
            <c:choose>
                <c:when test="${view.abcategory == 'NOTICE'}">공지사항</c:when>
                <c:when test="${view.abcategory == 'EVENT'}">이벤트</c:when>
                <c:otherwise>고객센터</c:otherwise>
            </c:choose>
        </div>

        <!-- 게시글 헤더 (제목 및 정보) -->
        <div class="article-header">
            <div class="article-title">${view.abtitle}</div>
            <div class="article-meta">
                <span>${view.mname ne null ? view.mname : '페이지랜드'}</span>
                <span>|</span>
                <span><fmt:formatDate value="${view.abdate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                <span>|</span>
                <span>조회 ${view.abhit}</span>
            </div>
        </div>

        <!-- 게시글 본문 (이미지 우선 -> 텍스트 내용) -->
        <div class="article-body">
            <!-- 1. 이미지 먼저 출력 -->
            <c:if test="${not empty view.abfiles}">
                <div class="article-image-area">
                    <img src="/images/${view.abfiles}" alt="첨부 이미지">
                </div>
            </c:if>

            <!-- 2. 작성한 내용(타이핑 한 글) 출력 -->
            <div class="article-content-text">
                ${view.abcontent}
            </div>
        </div>

        <!-- 하단 버튼 영역 -->
        <div class="btn-group">
            <div class="btn-left">
                <c:if test="${view.abcategory == 'NOTICE'}">
                    <a href="/guest/noticeList" class="btn btn-default">목록</a>
                </c:if>
                <c:if test="${view.abcategory == 'EVENT'}">
                    <a href="/guest/eventList" class="btn btn-default">목록</a>
                </c:if>
                <c:if test="${view.abcategory ne 'NOTICE' and view.abcategory ne 'EVENT'}">
                    <a href="javascript:history.back();" class="btn btn-default">목록</a>
                </c:if>
            </div>

            <!-- 관리자 수정/삭제 버튼 -->
            <sec:authorize access="hasRole('ADMIN') or hasRole('ROLE_ADMIN') or hasAuthority('ADMIN') or hasAuthority('ROLE_ADMIN')">
                <div class="btn-right">
                    <a href="/admin/abUpdateForm?abno=${view.abno}" class="btn btn-admin">수정</a>
                    <a href="/admin/abDelete?abno=${view.abno}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                </div>
            </sec:authorize>
        </div>

    </div>

    <!-- 푸터 인클루드 -->
    <%@ include file="footer.jsp" %>

</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${view.rtitle} - 페이지랜드</title>
    <link rel="stylesheet" href="/css/ratingView.css">
</head>
<body>

    <sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal.username" var="memail" />
    </sec:authorize>

    <%@ include file="header.jsp" %>

    <div class="view-container">
        
        <div class="page-category-title">대여 후기</div>

        <div class="article-header">
            
            <div class="title-book-wrapper">
                <span class="article-title">${view.rtitle}</span>

                <c:if test="${not empty view.bname}">
                    <a href="/guest/bookDetail?bno=${view.bno}" class="rented-book-card" title="${view.bname} 상세정보 보기">
                        <c:if test="${not empty view.bimg}">
                            <img src="${view.bimg.startsWith('http') ? view.bimg : '/images/'.concat(view.bimg)}" 
                                 class="book-cover-square" alt="표지" onerror="this.style.display='none';">
                        </c:if>
                        
                        <div class="book-info-stacked">
                            <span class="book-label">대여한 도서</span>
                            <span class="book-title-name">${view.bname}</span>
                        </div>
                    </a>
                </c:if>
            </div>

            <div class="article-meta">
                <span class="star-rating">
                    <c:choose>
                        <c:when test="${view.rrate == 5.0}">★★★★★</c:when>
                        <c:when test="${view.rrate == 4.0}">★★★★☆</c:when>
                        <c:when test="${view.rrate == 3.0}">★★★☆☆</c:when>
                        <c:when test="${view.rrate == 2.0}">★★☆☆☆</c:when>
                        <c:otherwise>★☆☆☆☆</c:otherwise>
                    </c:choose>
                    ${view.rrate}점
                </span>
                <span>|</span>
                <span>작성자: ${view.mname ne null ? view.mname : '익명'}</span>
                <span>|</span>
                <span><fmt:formatDate value="${view.rdate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                <span>|</span>
                <span>조회 ${view.rhit}</span>
            </div>
        </div>

        <div class="article-body">
            <c:if test="${not empty view.rfiles}">
                <div class="article-image-area">
                    <img src="/images/${view.rfiles}" alt="후기 첨부 사진">
                </div>
            </c:if>

            <div class="article-content-text">
                ${view.rcontent}
            </div>
        </div>

        <div class="btn-group">
            <div class="btn-left">
                <a href="/guest/ratingList" class="btn btn-default">목록</a>
            </div>

            <div class="btn-right">
                <c:if test="${not empty memail and memail == view.memail}">
                    <a href="/board/ratingUpdateForm?rno=${view.rno}" class="btn btn-edit">수정</a>
                    <a href="/board/ratingDelete?rno=${view.rno}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                </c:if>

                <sec:authorize access="hasRole('ADMIN') or hasRole('ROLE_ADMIN') or hasAuthority('ADMIN') or hasAuthority('ROLE_ADMIN')">
                    <c:if test="${empty memail or memail != view.memail}">
                        <a href="/board/ratingDelete?rno=${view.rno}" class="btn btn-danger" onclick="return confirm('관리자 권한으로 삭제하시겠습니까?');">삭제</a>
                    </c:if>
                </sec:authorize>
            </div>
        </div>

    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>
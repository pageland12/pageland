<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${view.qtitle} - 페이지랜드</title>
    <link rel="stylesheet" href="/css/qnaView.css">
</head>
<body>

    <sec:authorize access="isAuthenticated()">
        <sec:authentication property="principal.username" var="memail" />
    </sec:authorize>
	
    <%@ include file="header.jsp" %>

    <div class="view-container">
        
        <div class="page-category-title">Q&A</div>

        <div class="article-header">
            <div class="title-wrapper">
                <span class="article-title">${view.qtitle}</span>

                <c:if test="${view.qsecret == '비밀글'}">
                    <span class="secret-badge">🔒 비밀글</span>
                </c:if>
            </div>

            <div class="article-meta">
                <span>작성자: ${view.mname ne null ? view.mname : '익명'}</span>
                <span>|</span>
                <span><fmt:formatDate value="${view.qdate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                <span>|</span>
                <span>조회 ${view.qhit}</span>
            </div>
        </div>

        <div class="article-body">
            <c:if test="${not empty view.qfiles}">
                <div class="article-image-area">
                    <img src="/images/${view.qfiles}" alt="QnA 첨부 사진">
                </div>
            </c:if>

            <div class="article-content-text">
                ${view.qcontent}
            </div>
        </div>

        <div class="btn-group">
            <div class="btn-left">
                <a href="/guest/qnaList" class="btn btn-default">목록</a>
            </div>

            <div class="btn-right">
                <c:if test="${not empty memail and memail == view.memail}">
                    <a href="/board/qnaUpdateForm?qno=${view.qno}" class="btn btn-edit">수정</a>
                    <a href="/board/qnaDelete?qno=${view.qno}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                </c:if>

                <sec:authorize access="hasRole('ADMIN') or hasRole('ROLE_ADMIN') or hasAuthority('ADMIN') or hasAuthority('ROLE_ADMIN')">
                    <c:if test="${empty memail or memail != view.memail}">
                        <a href="/board/qnaDelete?qno=${view.qno}" class="btn btn-danger" onclick="return confirm('관리자 권한으로 삭제하시겠습니까?');">삭제</a>
                    </c:if>
                </sec:authorize>
            </div>
        </div>

    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>
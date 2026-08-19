<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${view.rtitle} - 페이지랜드</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #ffffff;
            color: #333333;
            font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
        }

        .view-container {
            width: 100%;
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px 80px 20px;
            box-sizing: border-box;
        }

        .page-category-title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color: #111111;
            margin-bottom: 40px;
        }

        .article-header {
            border-top: 1px solid #111111;
            border-bottom: 1px solid #eeeeee;
            padding: 25px 10px;
            margin-bottom: 30px;
        }

        .title-book-wrapper {
            display: flex;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
            margin-bottom: 20px;
        }

        .article-title {
            font-size: 22px;
            font-weight: bold;
            color: #111111;
            line-height: 1.3;
        }

        a.rented-book-card {
            display: inline-flex !important;
            align-items: center;
            gap: 10px;
            background-color: #f8f9fa;
            border: 1px solid #e9ecef;
            border-radius: 6px;
            padding: 6px 12px 6px 6px;
            text-decoration: none !important;
            cursor: pointer !important;       
            transition: all 0.2s ease-in-out;
        }

        a.rented-book-card * {
            cursor: pointer !important;
        }

        a.rented-book-card:hover {
            background-color: #f1f3f5;
            border-color: #ced4da;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
            transform: translateY(-1px);
        }

        .book-cover-square {
            width: 44px;
            height: 44px;
            object-fit: cover;
            border-radius: 4px;
            border: 1px solid #dddddd;
            flex-shrink: 0;
        }

        .book-info-stacked {
            display: flex;
            flex-direction: column;
            justify-content: center;
            gap: 2px;
        }

        .book-label {
            font-size: 11px;
            color: #888888;
            font-weight: 600;
            line-height: 1;
        }

        .book-title-name {
            font-size: 13.5px;
            font-weight: bold;
            color: #222222;
            line-height: 1.2;
            max-width: 250px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        a.rented-book-card:hover .book-title-name {
            color: #0056b3;
            text-decoration: underline;
        }

        .article-meta {
            font-size: 13.5px;
            color: #777777;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .star-rating {
            color: #ff9800;
            font-weight: bold;
            font-size: 15px;
        }

        .article-body {
            min-height: 200px;
            line-height: 1.7;
            font-size: 15px;
            color: #333333;
            margin-bottom: 50px;
        }

        .article-image-area {
            text-align: center;
            margin-bottom: 30px;
        }

        .article-image-area img {
            max-width: 100%;
            height: auto;
            border-radius: 4px;
        }

        .article-content-text {
            white-space: pre-line;
            word-break: break-all;
        }

        .btn-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #eeeeee;
            padding-top: 25px;
        }

        .btn-left, .btn-right {
            display: flex;
            gap: 8px;
        }

        .btn {
            display: inline-block;
            padding: 9px 20px;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.2s;
        }

        .btn-default {
            background-color: #f4f4f4;
            color: #333333;
            border: 1px solid #dddddd;
        }
        .btn-default:hover {
            background-color: #e8e8e8;
        }

        .btn-edit {
            background-color: #222222;
            color: #ffffff;
            border: 1px solid #222222;
        }
        .btn-edit:hover {
            background-color: #444444;
        }

        .btn-danger {
            background-color: #e74c3c;
            color: #ffffff;
            border: 1px solid #e74c3c;
        }
        .btn-danger:hover {
            background-color: #c0392b;
        }
    </style>
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
                <a href="/guest/ratingList" class="btn btn-default">목록으로</a>
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
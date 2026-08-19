<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구매 후기 - 페이지랜드</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #ffffff;
            color: #333333;
            font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
        }

        .page-container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            padding: 40px 20px 80px 20px;
            box-sizing: border-box;
        }

        .breadcrumb {
            font-size: 13px;
            color: #888888;
            margin-bottom: 30px;
            display: flex;
            align-items: center;
            gap: 6px;
        }
        .breadcrumb a {
            color: #888888;
            text-decoration: none;
        }

        .page-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #111111;
            margin-bottom: 30px;
        }

        .sub-tab-menu {
            display: flex;
            justify-content: center;
            gap: 25px;
            margin-bottom: 45px;
        }
        
        .sub-tab-menu a {
            text-decoration: none;
            color: #888888;
            font-size: 15px;
            font-weight: 500;
            transition: color 0.2s;
        }
        .sub-tab-menu a:hover,
        .sub-tab-menu a.active {
            color: #111111;
            font-weight: bold;
        }

        .btn-write {
            background-color: #222222;
            color: #ffffff;
            padding: 8px 16px;
            border-radius: 4px;
            text-decoration: none;
            font-size: 13px;
            font-weight: bold;
        }

        .rating-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        
        .rating-table th {
            background-color: #f7f7f7;
            color: #111111;
            font-weight: bold;
            padding: 16px 10px;
            border-top: 1px solid #e2e2e2;
            border-bottom: 1px solid #e2e2e2;
            text-align: center;
        }
        
        .rating-table td {
            padding: 14px 10px;
            border-bottom: 1px solid #eeeeee;
            color: #666666;
            text-align: center;
            vertical-align: middle;
        }

        .rating-table tr {
            cursor: pointer;
            transition: background-color 0.15s ease;
        }
        
        .rating-table tr:hover {
            background-color: #fcfcfc;
        }

        .title-td {
            text-align: left !important;
            color: #222222 !important;
        }

        .review-title {
            font-size: 14px;
            font-weight: 500;
            color: #111111;
            margin-bottom: 6px;
        }

        .purchased-book-tag {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            background-color: #f5f5f5;
            padding: 3px 8px 3px 4px;
            border-radius: 4px;
            font-size: 12px;
            color: #666666;
            max-width: 100%;
        }
        
        .book-mini-img {
            width: 18px;
            height: 24px;
            object-fit: cover;
            border-radius: 2px;
            vertical-align: middle;
        }
        .book-title-text {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 320px;
        }

        .thumb-img {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 4px;
            vertical-align: middle;
        }
        .no-img-box {
            width: 50px;
            height: 50px;
            background-color: #f2f2f2;
            color: #aaaaaa;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 10px;
            border-radius: 4px;
            vertical-align: middle;
        }

        .star-rate {
            color: #ff9800;
            font-weight: bold;
        }

        .hit-badge {
            display: inline-block;
            background-color: #2ecc71;
            color: #ffffff;
            font-size: 11px;
            font-weight: bold;
            padding: 2px 6px;
            border-radius: 3px;
            margin-left: 6px;
            vertical-align: middle;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 40px;
        }
        .page-link {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            width: 32px;
            height: 32px;
            border-radius: 50%;
            border: 1px solid #e2e2e2;
            color: #555555;
            text-decoration: none;
            font-size: 13px;
            transition: all 0.2s ease;
        }
        .page-link:hover {
            border-color: #999999;
            color: #111111;
        }
        .page-link.active {
            border-color: transparent;
            font-weight: bold;
            color: #111111;
        }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="page-container">
        <div class="page-title">후기</div>

        <div class="sub-tab-menu">
            <a href="/guest/qnaList">Q&A</a>
            <a href="/guest/eventList">이벤트</a>
            <a href="/guest/noticeList">공지사항</a>
            <a href="/guest/ratingList" class="active">후기</a>
        </div>

        <table class="rating-table">
            <thead>
                <tr>
                    <th style="width: 8%;">번호</th>
                    <th style="width: 8%;">후기사진</th>
                    <th style="width: 44%;">제목 및 구매도서</th>
                    <th style="width: 12%;">평점</th>
                    <th style="width: 12%;">작성자</th>
                    <th style="width: 10%;">작성일</th>
                    <th style="width: 6%;">조회</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="list" items="${list}">
                    <tr onclick="location.href='/guest/ratingView?rno=${list.rno}'">
                        <td>${list.rno}</td>

                        <td>
                            <c:choose>
                                <c:when test="${not empty list.rfiles}">
                                    <img src="/images/${list.rfiles}" class="thumb-img" alt="후기 이미지">
                                </c:when>
                                <c:otherwise>
                                    <div class="no-img-box">NO IMG</div>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td class="title-td">
                            <div class="review-title">
                                ${list.rtitle}
                                <c:if test="${list.rhit >= 100}">
                                    <span class="hit-badge">HIT</span>
                                </c:if>
                            </div>

                            <div class="purchased-book-tag">
                                <c:choose>
                                    <c:when test="${not empty list.bname}">
                                        <c:if test="${not empty list.bimg}">
                                            <img src="${list.bimg}" class="book-mini-img" alt="도서 표지">
                                        </c:if>
                                        <span class="book-title-text">${list.bname}</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="book-title-text" style="color: #999;">상품 정보가 없습니다.</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </td>

                        <td class="star-rate">⭐ ${list.rrate}</td>

                        <td>${list.mname ne null ? list.mname : '익명'}</td>

                        <td><fmt:formatDate value="${list.rdate}" pattern="yy.MM.dd" /></td>

                        <td>${list.rhit}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="pagination">
            <c:if test="${startPage > 1}">
                <a href="/guest/ratingList?pageNum=${startPage - 1}" class="page-link">&lt;</a>
            </c:if>

            <c:forEach begin="${startPage}" end="${endPage}" var="num">
                <c:choose>
                    <c:when test="${pageNum == num}">
                        <span class="page-link active">${num}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="/guest/ratingList?pageNum=${num}" class="page-link">${num}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${endPage < totalPages}">
                <a href="/guest/ratingList?pageNum=${endPage + 1}" class="page-link">&gt;</a>
            </c:if>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>
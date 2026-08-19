<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>구매 후기 - 페이지랜드</title>
    <link rel="stylesheet" href="/css/ratingList.css">
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
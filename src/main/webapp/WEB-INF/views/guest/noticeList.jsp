<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 - 페이지랜드</title>
    <link rel="stylesheet" href="/css/noticeList.css">
</head>
<body>
    <%@ include file="header.jsp" %>

    <div class="page-container">
        <div class="page-title">공지사항</div>

        <div class="sub-tab-menu">
		    <a href="/guest/qnaList">Q&A</a>
		    <a href="/guest/eventList">이벤트</a>
		    <a href="/guest/noticeList" class="active">공지사항</a>
		    <a href="/guest/ratingList">후기</a>
		</div>

        <sec:authorize access="hasRole('ADMIN')">
            <div class="admin-btn-area">
                <a href="/admin/abWriteForm?category=NOTICE" class="btn-write">✏️ 공지사항 작성</a>
            </div>
        </sec:authorize>

        <table class="notice-table">
            <thead>
                <tr>
                    <th style="width: 8%;">번호</th>
                    <th style="width: 52%;">제목</th>
                    <th style="width: 12%;">카테고리</th>
                    <th style="width: 12%;">작성자</th>
                    <th style="width: 10%;">작성일</th>
                    <th style="width: 6%;">조회</th>
                </tr>
            </thead>
            <tbody>
			    <c:forEach var="item" items="${notice}">
			        <tr onclick="location.href='/guest/abView?abno=${item.abno}'">
			            <!-- 바로 게시글 번호 출력 -->
			            <td>${item.abno}</td>
			
			            <td class="title-td">
			                ${item.abtitle}
			                <c:if test="${item.abhit >= 100}">
			                    <span class="hit-badge">HIT</span>
			                </c:if>
			            </td>
			
			            <td>공지사항</td>
			            <td>${item.mname ne null ? item.mname : '페이지랜드'}</td>
			            <td><fmt:formatDate value="${item.abdate}" pattern="yy.MM.dd" /></td>
			            <td>${item.abhit}</td>
			        </tr>
			    </c:forEach>
			</tbody>
        </table>

        <div class="pagination">
            <c:if test="${startPage > 1}">
                <a href="/guest/noticeList?pageNum=${startPage - 1}" class="page-link">&lt;</a>
            </c:if>

            <c:forEach begin="${startPage}" end="${endPage}" var="num">
                <c:choose>
                    <c:when test="${pageNum == num}">
                        <span class="page-link active">${num}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="/guest/noticeList?pageNum=${num}" class="page-link">${num}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${endPage < totalPages}">
                <a href="/guest/noticeList?pageNum=${endPage + 1}" class="page-link">&gt;</a>
            </c:if>
        </div>
    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>
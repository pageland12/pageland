<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A - 페이지랜드</title>
    <link rel="stylesheet" href="/css/qnaList.css">
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="page-container">
        <div class="page-title">Q&A</div>

        <div class="sub-tab-menu">
		    <a href="/guest/qnaList" class="active">Q&A</a>
		    <a href="/guest/eventList">이벤트</a>
		    <a href="/guest/noticeList">공지사항</a>
		    <a href="/guest/ratingList">후기</a>
		</div>

		<sec:authorize access="isAuthenticated()">
		    <div class="btn-area">
		        <a href="/board/qnaWriteForm" class="btn-write">✏️ Q&A 작성</a>
		    </div>
		</sec:authorize>

        <table class="qna-table">
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
                <c:forEach var="list" items="${qnaList}">
                    <sec:authorize access="hasRole('ADMIN')">
                    	<c:set var="targetUrl" value="/guest/qnaView?qno=${list.qno}" />
                    </sec:authorize>
                    
                    <sec:authorize access="hasAnyRole('NORMAL', 'SUBSCRIBER')">
                    	<c:set var="targetUrl" value="${list.qsecret == '비밀글' ? '/board/qnaPasswordCheckForm?qno='.concat(list.qno).concat('&mode=view') : '/guest/qnaView?qno='.concat(list.qno)}" />
					</sec:authorize>

                    <tr onclick="location.href='${targetUrl}'">
                        <td>${list.qno}</td>

                        <td class="title-td">
                            <c:choose>
                                <c:when test="${list.qsecret == '비밀글'}">
                                    <span class="secret-text">🔒 비밀글입니다.</span>
                                </c:when>
                                <c:otherwise>
                                    ${list.qtitle}
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${list.qhit >= 100}">
                                <span class="hit-badge">HIT</span>
                            </c:if>
                        </td>

                        <td>Q&A</td>

                        <td>${list.mname ne null ? list.mname : '익명'}</td>

                        <td><fmt:formatDate value="${list.qdate}" pattern="yy.MM.dd" /></td>

                        <td>${list.qhit}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <div class="pagination">
            <%-- 이전 버튼 --%>
            <c:if test="${startPage > 1}">
                <a href="/guest/qnaList?pageNum=${startPage - 1}" class="page-link">&lt;</a>
            </c:if>

            <c:forEach begin="${startPage}" end="${endPage}" var="num">
                <c:choose>
                    <c:when test="${pageNum == num}">
                        <span class="page-link active">${num}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="/guest/qnaList?pageNum=${num}" class="page-link">${num}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${endPage < totalPages}">
                <a href="/guest/qnaList?pageNum=${endPage + 1}" class="page-link">&gt;</a>
            </c:if>
        </div>
    </div>

    <!-- 푸터 인클루드 -->
    <%@ include file="footer.jsp" %>

</body>
</html>
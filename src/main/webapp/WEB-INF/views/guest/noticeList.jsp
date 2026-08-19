<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>공지사항 - 페이지랜드</title>
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

        .admin-btn-area {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 12px;
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

        .notice-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 14px;
        }
        .notice-table th {
            background-color: #f7f7f7;
            color: #111111;
            font-weight: bold;
            padding: 16px 10px;
            border-top: 1px solid #e2e2e2;
            border-bottom: 1px solid #e2e2e2;
            text-align: center;
        }
        .notice-table td {
            padding: 18px 10px;
            border-bottom: 1px solid #eeeeee;
            color: #666666;
            text-align: center;
        }

        .notice-table tr {
            cursor: pointer;
            transition: background-color 0.15s ease;
        }
        .notice-table tr:hover {
            background-color: #fcfcfc;
        }

        .title-td {
            text-align: left !important;
            color: #222222 !important;
            font-weight: 500;
        }

        .hit-badge {
            display: inline-block;
            background-color: #2ecc71;
            color: #ffffff;
            font-size: 11px;
            font-weight: bold;
            padding: 2px 6px;
            border-radius: 3px;
            margin-left: 8px;
            vertical-align: middle;
        }

        .notice-badge {
            color: #888888;
            font-weight: 500;
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
    <!-- 헤더 지시자 인클루드 -->
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
                <a href="/admin/abWriteForm" class="btn-write">✏️ 공지사항 작성</a>
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
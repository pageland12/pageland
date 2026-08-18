<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 회원 관리</title>
</head>
<body>
	<!-- 상단 이동 링크 -->
    <div style="text-align: right; margin-bottom: 10px;">
        <a href="/" style="text-decoration: none; color: #555; font-size: 14px;">🏠 홈으로 이동</a>
    </div>

    <!-- 헤더 타이틀 -->
    <h2>등록 도서 관리</h2>

    <hr>

    <!-- 관리자 도서 목록 테이블 -->
    <table>
        <thead>
            <tr>
                <th>회원번호</th>
				<th>이메일</th>
				<th>이름</th>
				<th>연락처</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="list" items="${lists}">
				<tr>
					<td>${list.mno}</td>
					<td><a href="/admin/memberView?mno=${list.mno}">${list.memail}</a></td>
					<td>${list.mname}</td>
					<td>${list.mtel}</td>
				</tr>
			</c:forEach>
        </tbody>
    </table>

    <!-- 관리자 페이지 번호 이동 영역 (최대 5개씩 표시) -->
    <div style="text-align: center; margin-top: 20px;">
        
        <%-- [이전] 버튼 --%>
        <c:if test="${startPage > 1}">
            <a href="/admin/memberList?pageNum=${startPage - 1}" style="margin-right: 5px; text-decoration: none; color: black;">[이전]</a>
        </c:if>

        <%-- 페이지 번호 (5개 단위) --%>
        <c:forEach begin="${startPage}" end="${endPage}" var="num">
            <c:choose>
                <c:when test="${pageNum == num}">
                    <span style="font-weight: bold; color: red; margin: 0 5px; font-size: 16px;">${num}</span>
                </c:when>
                <c:otherwise>
                    <a href="/admin/memberList?pageNum=${num}" style="margin: 0 5px; text-decoration: none; color: black;">${num}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>

        <%-- [다음] 버튼 --%>
        <c:if test="${endPage < totalPages}">
            <a href="/admin/memberList?pageNum=${endPage + 1}" style="margin-left: 5px; text-decoration: none; color: black;">[다음]</a>
        </c:if>

    </div>
	
	<a href="/admin/adminMain">관리자페이지로 이동</a>
</body>
</html>
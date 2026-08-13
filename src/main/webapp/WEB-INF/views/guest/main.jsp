<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pageland</title>
</head>
<body>
	<!-- 공통 -->
	<h2>페이지랜드</h2>
		<p>반갑습니다. 환상의 나라 페이지랜드입니다. ^_^~*</p>
	<!-- 비회원 -->
	<sec:authorize access="isAnonymous()">
		<a href="/loginForm">로그인</a><br>
		<a href="/guest/writeForm">회원가입</a>
	</sec:authorize>
	<!-- 회원 -->
	<sec:authorize access="hasRole('NORMAL')">
		<a href="/member/main">마이페이지</a>
		<a href="/logout">로그아웃</a>
	</sec:authorize>
	<!-- 관리자 -->
	<sec:authorize access="hasRole('ADMIN')">
		<a href="/admin/main">관리자페이지</a>
		<a href="/logout">로그아웃</a><br>
	</sec:authorize>		
</body>
</html>
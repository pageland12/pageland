<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인페이지</title>
</head>
<body>
	<div>
        <h2>시스템 관리자 컨트롤 패널</h2>
    </div>
    
    <div class="admin-grid">
        
        <a href="/admin/bookWriteForm">
            <div>신규 도서 등록</div>
        </a>
        
        <a href="/admin/bookList">
            <div>등록 도서 관리</div>
        </a>
        
        <a href="/admin/passWriteForm">
            <div>신규 구독권 등록</div>
        </a>
        
        <a href="/admin/passList">
            <div>등록 구독권 관리</div>
        </a>
        
        <a href="/admin/memberList">
            <div class="card-name">전체 회원 관리</div>
        </a>
        
        <a href="/main">
            <div class="card-name">메인 홈</div>
        </a>
        
    </div>
</body>
</html>
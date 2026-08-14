<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title> 메인페이지</title>
</head>
<body>
	<div>
        <h2>반갑습니다.</h2>
    </div>
    
    <div class="admin-grid">
        
        <a href="/member/passwordCheckForm?mode=update">
            <div>회원수정</div>
        </a>
        
        <a href="/member/passwordCheckForm?mode=delete">
            <div>회원탈퇴</div>
        </a>
        
        <a href="/member/orderList">
            <div>주문 조회</div>
        </a>
        
        <a href="/member/myOrderBookList">
            <div>대여 도서 조회</div>
        </a>
        
        <a href="/member/myBookList">
            <div>대여중인 도서 조회</div>
        </a>
        
        <a href="/member/myPassList?mno=${passList.mno}">
            <div>구독권 조회</div>
        </a>
        
        <a href="/member/boardList">
            <div>나의 게시글</div>
        </a>
        
        <a href="/main">
            <div class="card-name">메인 홈</div>
        </a>
        
    </div>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 완료</title>
</head>
<body>
	<div class="container">
        <h2>주문이 정상적으로 완료되었습니다!</h2>
        <p>소중한 주문 감사드립니다. 빠른 시일 내에 처리해 드리겠습니다.</p>

        <div class="order-info">
            주문 번호 : <strong>${paymentId}</strong>
        </div>

        <div>
            <a href="/main">홈페이지로 가기</a>
            <a href="/member/orderList">주문 목록으로 가기</a>
        </div>
    </div>
</body>
</html>
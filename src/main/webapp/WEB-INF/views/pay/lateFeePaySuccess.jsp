<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반납 완료</title>
</head>
<body>
	<div class="container">
        <h2>반납이 정상적으로 완료되었습니다!</h2>
        <p>도서가 정상적으로 반납 완료 처리되었으며, 연체 상태가 해제되었습니다.</p>

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
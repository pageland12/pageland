<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 완료</title>
<link rel="stylesheet" href="/css/paySuccess.css">
</style>
</head>
<body>
	<%@ include file="../guest/header.jsp" %>
	
	<main class="result-container">
        <div class="result-card">
            <h2 class="result-title">주문이 정상적으로 완료되었습니다!</h2>
            <p class="result-desc">
                소중한 주문 감사드립니다.<br>
                신속하고 안전하게 준비하여 발송해 드리겠습니다.
            </p>

            <div class="info-box">
                <span>주문 번호 :</span>
                <strong>${paymentId}</strong>
            </div>

            <div class="btn-group">
                <a href="/main" class="btn btn-home">홈으로 이동</a>
                <a href="/member/orderList" class="btn btn-order">주문내역 확인</a>
            </div>
        </div>
    </main>

    <%@ include file="../guest/footer.jsp" %>
</body>
</html>
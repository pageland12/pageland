<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>반납 완료</title>
<link rel="stylesheet" href="/css/paySuccess.css">
</head>
<body>
	<%@ include file="../guest/header.jsp" %>

    <main class="result-container">
        <div class="result-card">
            <h2 class="result-title">반납이 정상적으로 완료되었습니다!</h2>
            <p class="result-desc">
                도서 반납 처리가 완료되었으며,<br>
                연체 상태 및 대여 목록이 최신 상태로 갱신되었습니다.
            </p>

            <div class="info-box">
                <span>처리 번호 :</span>
                <strong>${paymentId}</strong>
            </div>

            <div class="btn-group">
                <a href="/main" class="btn btn-home">홈으로 이동</a>
                <a href="/member/myBookList" class="btn btn-order">대여 도서 목록</a>
            </div>
        </div>
    </main>

    <%@ include file="../guest/footer.jsp" %>
</body>
</html>
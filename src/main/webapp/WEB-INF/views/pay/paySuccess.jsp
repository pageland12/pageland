<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 완료</title>
<style>
    .result-container {
        width: 100%;
        max-width: 600px;
        margin: 70px auto 90px auto;
        padding: 0 20px;
        box-sizing: border-box;
    }

    .result-card {
        background-color: #FFFFFF;
        border: 1px solid #EFE0D3;
        border-radius: 16px;
        padding: 50px 35px;
        box-shadow: 0 8px 24px rgba(90, 74, 66, 0.06);
        text-align: center;
    }

    .result-icon {
        font-size: 54px;
        margin-bottom: 20px;
        display: inline-block;
    }

    .result-title {
        font-size: 1.6rem;
        font-weight: 800;
        color: #2C221E;
        margin: 0 0 12px 0;
        letter-spacing: -0.5px;
    }

    .result-desc {
        font-size: 0.98rem;
        color: #7A6A60;
        line-height: 1.6;
        margin: 0 0 30px 0;
    }

    .info-box {
        background-color: #FAF0E6;
        border: 1px solid #E8D8CA;
        border-radius: 10px;
        padding: 18px 20px;
        margin-bottom: 35px;
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 12px;
        font-size: 1rem;
        color: #5A4A42;
    }

    .info-box strong {
        color: #8B5E3C;
        font-size: 1.15rem;
        font-weight: 800;
        letter-spacing: 0.5px;
    }

    .btn-group {
        display: flex;
        gap: 12px;
        justify-content: center;
    }

    .btn {
        flex: 1;
        max-width: 180px;
        padding: 13px 0;
        border-radius: 8px;
        font-size: 0.98rem;
        font-weight: 700;
        text-decoration: none;
        transition: all 0.2s ease;
        text-align: center;
        display: inline-block;
    }

    .btn-home {
        background-color: #EDE5DF;
        color: #5A4A42;
        border: 1px solid #DED3CA;
    }

    .btn-home:hover {
        background-color: #DFD5CD;
    }

    .btn-order {
        background-color: #8B5E3C;
        color: #FFFFFF;
        border: 1px solid #8B5E3C;
    }

    .btn-order:hover {
        background-color: #6F4A2F;
    }
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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>주문 / 결제</title>
    <!-- 포트원 V2 SDK 스크립트 -->
    <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
</head>
<body>
    <h2>연체료 결제 페이지</h2>
    
    <div>
        <p>연체 상품: ${prodName}</p>
        <p>결제 금액: ${totalAmount}원</p>
        <p>결제 이메일: ${buyerEmail}</p>
    </div>

    <!-- 결제하기 버튼 -->
    <button type="button" onclick="requestPayment()">결제하기</button>

    <script th:inline="javascript">
        async function requestPayment() {
            const orderName = '${prodName}';
            // const totalAmount = Number('${totalAmount}') || 0;
            const totalAmount = 1;
            const buyerEmail = '${buyerEmail}';
            const buyerTel = '${buyerTel}';
            const buyerName = '${buyerName}';
            const payment = 'KAKAO_PAY';
            
            // 주문 고유 번호 (고유값 생성)
            const paymentId = "ORD-" + new Date().getTime();

            try {
                // 포트원 V2 결제창 요청
                const response = await PortOne.requestPayment({
                    storeId: "store-30399cea-2dc5-47b1-8daa-39beeea2337e",          // Store ID 작성
                    channelKey: "channel-key-374933b0-f383-45d1-aecd-b9327f3acb38",  // Channel Key 작성
                    paymentId: paymentId,
                    orderName: orderName,
                    totalAmount: totalAmount,
                    currency: "CURRENCY_KRW",
                    payMethod: "EASY_PAY",
                    easyPay: {
                        provider: "KAKAO_PAY" // 카카오페이 호출
                    },
                    customer: {
                        email: buyerEmail,
                        phoneNumber: buyerTel,
                        fullName: buyerName
                    }
                });

                // 결제 실패 또는 취소
                if (response.code != null) {
                    alert("결제 실패: " + response.message);
                    return;
                }

                // 결제 성공
                console.log("결제 성공! paymentId:", response.paymentId);
                fetch('/pay/lateFeePaySuccess', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        paymentId: response.paymentId,      // 포트원 결제 고유 번호
                        bno: Number('${cdto.bno}') || 0,    // 도서 번호
                        ctype: '${cdto.ctype}',             // 상품 타입 (book)
                        totalAmount: Number('${totalAmount}'),           // 실제로 결제한 금액
                        payment: payment,			// 결제 수단
                        mbno: Number('${mbno}'),
                        buyerEmail: buyerEmail		// 결제 이메일
                    })
                })
                .then(res => res.json())
                .then(data => {
                	if (data.success) {
                        // 결제 및 DB 저장 성공 시 완료 페이지로 이동 (paymentId 전달)
                        location.href = "/pay/lateFeePayResult?paymentId=" + response.paymentId;
                    } else {
                        alert("주문 처리 중 오류 발생: " + data.message);
                    }
                })
                .catch(err => {
                    console.error("서버 전송 중 에러 발생:", err);
                    alert("서버와 통신 중 오류가 발생했습니다.");
                });

            } catch (error) {
                console.error("결제 중 에러 발생:", error);
            }
        }
    </script>
</body>
</html>
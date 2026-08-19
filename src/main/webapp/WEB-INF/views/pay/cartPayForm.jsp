<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>주문 / 결제</title>
    <!-- 포트원 V2 SDK 스크립트 -->
    <style>
	    /* 결제 컨테이너 */
	    .pay-container {
	        width: 100%;
	        max-width: 580px;
	        margin: 60px auto 80px auto;
	        padding: 0 20px;
	        box-sizing: border-box;
	    }
	
	    /* 결제 카드 (영수증 스타일) */
	    .pay-card {
	        background-color: #FFFFFF;
	        border: 1px solid #EFE0D3;
	        border-radius: 16px;
	        padding: 40px 35px;
	        box-shadow: 0 8px 24px rgba(90, 74, 66, 0.06);
	    }
	
	    /* 상단 타이틀 */
	    .pay-header {
	        text-align: center;
	        padding-bottom: 25px;
	        border-bottom: 2px solid #5A4A42;
	        margin-bottom: 30px;
	    }
	
	    .pay-title {
	        font-size: 1.55rem;
	        font-weight: 800;
	        color: #2C221E;
	        margin: 0;
	        letter-spacing: -0.5px;
	    }
	
	    /* 결제 상세 내역 리스트 */
	    .pay-list {
	        display: flex;
	        flex-direction: column;
	        gap: 16px;
	        margin-bottom: 30px;
	    }
	
	    .pay-row {
	        display: flex;
	        justify-content: space-between;
	        align-items: center;
	        font-size: 0.95rem;
	        color: #555555;
	    }
	
	    .pay-row .label {
	        color: #7A6A60;
	        font-weight: 600;
	    }
	
	    .pay-row .val {
	        color: #2C221E;
	        font-weight: 600;
	        text-align: right;
	        max-width: 320px;
	        word-break: break-word;
	    }
	
	    .pay-row .val.discount {
	        color: #D32F2F;
	    }
	
	    .pay-divider {
	        height: 1px;
	        background-color: #EFE0D3;
	        margin: 8px 0;
	    }
	
	    /* 최종 결제 금액 행 */
	    .pay-row.total-row {
	        margin-top: 10px;
	        padding-top: 15px;
	        border-top: 2px dashed #E8D8CA;
	        align-items: baseline;
	    }
	
	    .pay-row.total-row .label {
	        font-size: 1.15rem;
	        font-weight: 800;
	        color: #2C221E;
	    }
	
	    .pay-row.total-row .total-amount {
	        font-size: 1.6rem;
	        font-weight: 800;
	        color: #8B5E3C;
	    }
	
	    /* 결제 버튼 */
	    .btn-payment {
	        width: 100%;
	        height: 54px;
	        background-color: #8B5E3C;
	        color: #FFFFFF;
	        border: none;
	        border-radius: 10px;
	        font-size: 1.1rem;
	        font-weight: 700;
	        cursor: pointer;
	        transition: background-color 0.2s ease, transform 0.1s ease;
	        display: flex;
	        align-items: center;
	        justify-content: center;
	        gap: 8px;
	    }
	
	    .btn-payment:hover {
	        background-color: #6F4A2F;
	        transform: translateY(-2px);
	    }
	
	    .btn-payment:active {
	        transform: translateY(0);
	    }
	
	    /* 연체료 전용 강조 버튼 (필요 시 class 추가: btn-overdue) */
	    .btn-overdue {
	        background-color: #D32F2F !important;
	    }
	
	    .btn-overdue:hover {
	        background-color: #B71C1C !important;
	    }
	</style>
    <script src="https://cdn.portone.io/v2/browser-sdk.js"></script>
</head>
<body>
    <%@ include file="../guest/header.jsp" %>
	
	<main class="pay-container">
        <div class="pay-card">
            
            <!-- 1. 타이틀 (각 페이지 상황에 맞게 텍스트 교체) -->
            <div class="pay-header">
                <h2 class="pay-title">주문 / 결제</h2>
            </div>

            <!-- 2. 결제 내역 -->
            <div class="pay-list">
                <div class="pay-row">
                    <span class="label">주문 상품</span>
                    <span class="val">${prodName} <c:if test="${prodCount > 0}">외 ${prodCount}건</c:if></span>
                </div>

                <c:if test="${fee ne null}">
                    <div class="pay-row">
                        <span class="label">배송비</span>
                        <span class="val">
                            <c:choose>
                                <c:when test="${fee == 0}">무료배송</c:when>
                                <c:otherwise><fmt:formatNumber value="${fee}" pattern="#,###" />원</c:otherwise>
                            </c:choose>
                        </span>
                    </div>
                </c:if>

                <c:if test="${sale ne null and sale > 0}">
                    <div class="pay-row">
                        <span class="label">할인 금액</span>
                        <span class="val discount">-<fmt:formatNumber value="${sale}" pattern="#,###" />원</span>
                    </div>
                </c:if>

                <div class="pay-row">
                    <span class="label">주문자 이메일</span>
                    <span class="val">${buyerEmail}</span>
                </div>

                <!-- 최종 금액 행 -->
                <div class="pay-row total-row">
                    <span class="label">최종 결제 금액</span>
                    <span class="total-amount">
                        <fmt:formatNumber value="${totalAmount}" pattern="#,###" />원
                    </span>
                </div>
            </div>

            <!-- 3. 결제 버튼 -->
            <button type="button" class="btn-payment" onclick="requestPayment()">
                <c:choose>
                    <c:when test="${totalAmount == 0}">
                        정기권으로 대여하기 (0원 결제)
                    </c:when>
                    <c:otherwise>
                        <fmt:formatNumber value="${totalAmount}" pattern="#,###" />원 결제하기
                    </c:otherwise>
                </c:choose>
            </button>

        </div>
    </main>
	
	<%@ include file="../guest/footer.jsp" %>
	
    <script th:inline="javascript">
        async function requestPayment() {
            const orderName = '${prodName}';
            const totalAmount = Number('${totalAmount}') || 0; // 테스트 시 100만원이 넘지 않게 하기
            const buyerEmail = '${buyerEmail}';
            const buyerTel = '${buyerTel}';
            const buyerName = '${buyerName}';
            const cnoList = [
                <c:forEach var="cno" items="${cnoList}" varStatus="st">
                    ${cno}<c:if test="${!st.last}">,</c:if>
                </c:forEach>
            ];
            
            if (totalAmount === 0) {
                if (!confirm("정기권 혜택으로 0원 대여를 진행하시겠습니까?")) {
                    return;
                }

                fetch('/pay/subscriberCartRent', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        cnoList: cnoList,
                        buyerEmail: buyerEmail
                    })
                })
                .then(res => res.json())
                .then(data => {
                    if (data.success) {
                        alert("정기권 일괄 대여가 완료되었습니다!");
                        // 결제 완료 페이지로 이동
                        location.href = "/pay/payResult?paymentId=" + data.paymentId;
                    } else {
                        alert(data.message || "대여 처리 중 오류가 발생했습니다.");
                    }
                })
                .catch(err => {
                    console.error("정기권 대여 통신 에러:", err);
                    alert("서버와 통신 중 오류가 발생했습니다.");
                });

                return; // 0원 결제 완료 이후 함수 종료
            }
            
            // 결제 방식, 주문 고유 번호 (고유값 생성)
            const payment = 'KAKAO_PAY';
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
                fetch('/pay/cartPaySuccess', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        paymentId: response.paymentId,      	// 포트원 결제 고유 번호
                        cnoList: cnoList,						// 결제한 장바구니 목록
                        totalAmount: Number('${totalAmount}'),	// 실제로 결제한 금액
                        payment: payment,						// 결제 수단
                        fee: Number('${fee}'),					// 배송비
                        buyerEmail: buyerEmail					// 결제 이메일
                    })
                })
                .then(res => res.json())
                .then(data => {
                	if (data.success) {
                        // 결제 및 DB 저장 성공 시 완료 페이지로 이동 (paymentId 전달)
                        location.href = "/pay/payResult?paymentId=" + response.paymentId;
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
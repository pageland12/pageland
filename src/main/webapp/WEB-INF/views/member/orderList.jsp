<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 주문/결제 내역</title>
<style>
    .mypage-wrapper {
        width: 100%;
        max-width: 1400px;
        margin: 0 auto;
        padding: 50px 30px 60px 30px;
        box-sizing: border-box;
        display: flex;
        gap: 40px;
        align-items: flex-start;
    }

    .mypage-main {
        flex: 1;
        background-color: #FFFFFF;
        border-radius: 12px;
        padding: 30px;
        border: 1px solid #EFE0D3;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
        box-sizing: border-box;
    }

    .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 18px;
        margin-bottom: 25px;
        border-bottom: 2px solid #5A4A42;
    }

    .content-title {
        font-size: 1.45rem;
        font-weight: 800;
        color: #2C221E;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .content-subtitle {
        font-size: 0.9rem;
        color: #7A6A60;
    }

    /* 테이블 스타일링 */
    .custom-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
        font-size: 0.92rem;
    }

    .custom-table thead th {
        background-color: #FAF0E6;
        color: #5A4A42;
        padding: 14px 10px;
        font-weight: 700;
        border-top: 1px solid #E8D8CA;
        border-bottom: 1px solid #E8D8CA;
        white-space: nowrap;
    }

    .custom-table tbody td {
        padding: 16px 10px;
        border-bottom: 1px solid #F0E8E0;
        color: #333333;
        vertical-align: middle;
    }

    .custom-table tbody tr:hover {
        background-color: #FCF9F6;
    }

    /* 결제 관련 텍스트 강조 */
    .order-no {
        font-weight: 700;
        color: #5A4A42;
    }

    .price-text {
        color: #555555;
    }

    .sale-text {
        color: #D32F2F;
        font-weight: 600;
    }

    .total-price {
        color: #8B5E3C;
        font-weight: 800;
        font-size: 1rem;
    }

    .pay-badge {
        display: inline-block;
        padding: 4px 10px;
        background-color: #F5EFEB;
        color: #5A4A42;
        border-radius: 6px;
        font-size: 0.85rem;
        font-weight: 600;
        border: 1px solid #E3D6CC;
    }

    .empty-msg {
        text-align: center;
        padding: 60px 0;
        color: #888888;
        font-size: 1rem;
    }

    /* 페이징 영역 */
    .pagination {
        text-align: center;
        margin-top: 35px;
    }

    .pagination a {
        display: inline-block;
        padding: 6px 12px;
        margin: 0 3px;
        color: #5A4A42;
        text-decoration: none;
        border: 1px solid #E0D2C7;
        border-radius: 4px;
        font-size: 0.9rem;
        transition: background-color 0.2s;
    }

    .pagination a:hover {
        background-color: #F2E3D5;
    }

    .pagination .current-page {
        display: inline-block;
        padding: 6px 12px;
        margin: 0 3px;
        background-color: #8B5E3C;
        color: #FFFFFF;
        font-weight: 700;
        border-radius: 4px;
        border: 1px solid #8B5E3C;
        font-size: 0.9rem;
    }
</style>
</head>
<body>
    <!-- 1. guest 폴더의 header include -->
    <%@ include file="../guest/header.jsp" %>

    <div class="mypage-wrapper">
        <!-- 2. member 폴더의 사이드바 include -->
        <%@ include file="memberSidebar.jsp" %>

        <!-- 3. 우측 본문 영역 -->
        <main class="mypage-main">
            <div class="content-header">
                <h2 class="content-title">주문 / 결제 내역</h2>
                <div class="content-subtitle">
                    회원님의 전체 주문 및 결제 내역을 확인하실 수 있습니다.
                </div>
            </div>

            <table class="custom-table">
                <thead>
                    <tr>
                        <th style="width: 120px;">주문번호</th>
                        <th>주문금액</th>
                        <th>배송비</th>
                        <th>할인액</th>
                        <th>최종 결제액</th>
                        <th>결제수단</th>
                        <th>결제일</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty orders}">
                            <tr>
                                <td colspan="7" class="empty-msg">
                                    주문 및 결제 내역이 없습니다.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <td class="order-no">${order.olno}</td>
                                    <td class="price-text">
                                        <fmt:formatNumber value="${order.olprice}" pattern="#,###" />원
                                    </td>
                                    <td class="price-text">
                                        <c:choose>
                                            <c:when test="${order.olfee == 0}">무료</c:when>
                                            <c:otherwise><fmt:formatNumber value="${order.olfee}" pattern="#,###" />원</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="sale-text">
                                        <c:choose>
                                            <c:when test="${order.olsale > 0}">
                                                -<fmt:formatNumber value="${order.olsale}" pattern="#,###" />원
                                            </c:when>
                                            <c:otherwise>-</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="total-price">
                                        <fmt:formatNumber value="${order.oltotal}" pattern="#,###" />원
                                    </td>
                                    <td>
                                        <span class="pay-badge">${order.olpayment}</span>
                                    </td>
                                    <td>
                                        <fmt:formatDate value="${order.oldate}" pattern="yyyy-MM-dd HH:mm" />
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <!-- 페이징 영역 -->
            <c:if test="${not empty orders}">
                <div class="pagination">
                    <c:if test="${startPage > 1}">
                        <a href="/member/orderList?pageNum=${startPage - 1}">[이전]</a>
                    </c:if>

                    <c:forEach begin="${startPage}" end="${endPage}" var="num">
                        <c:choose>
                            <c:when test="${pageNum == num}">
                                <span class="current-page">${num}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="/member/orderList?pageNum=${num}">${num}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${endPage < totalPages}">
                        <a href="/member/orderList?pageNum=${endPage + 1}">[다음]</a>
                    </c:if>
                </div>
            </c:if>
        </main>
    </div>

    <!-- 4. guest 폴더의 footer include -->
    <%@ include file="../guest/footer.jsp" %>
</body>
</html>
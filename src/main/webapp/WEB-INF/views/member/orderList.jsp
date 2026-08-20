<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 주문/결제 내역</title>
<link rel="stylesheet" href="/css/myList.css">
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 목록 - 페이지랜드</title>
<link rel="stylesheet" href="/css/cartList.css">
</head>
<body>
	<%@ include file="/WEB-INF/views/guest/header.jsp" %>

    <div class="cart-container">

        <div class="cart-header">
            <h2 class="cart-title">🛒 장바구니</h2>
        </div>

        <form name="cartListForm" method="post" action="/pay/cartPayForm">
            
            <c:if test="${not empty carts}">
                <div class="select-bar">
                    <input type="checkbox" id="selectAll" onclick="toggleAll(this)" checked style="width: 16px; height: 16px; cursor: pointer;">
                    <label for="selectAll">전체 선택</label>
                </div>
            </c:if>

            <c:if test="${empty carts}">
                <div class="empty-cart">
                    장바구니에 담긴 상품이 없습니다.
                </div>
            </c:if>

            <c:forEach var="cart" items="${carts}">
                <div class="cart-item">
                    
                    <div style="margin-right: 18px;">
                        <input type="checkbox" name="cnoList" value="${cart.cno}" checked style="width: 18px; height: 18px; cursor: pointer;">
                    </div>

                    <div style="margin-right: 20px;">
                        <c:choose>
                            <c:when test="${cart.ctype eq 'book' and not empty cart.bimg}">
                                <img src="${cart.bimg}" class="item-img">
                            </c:when>
                            <c:when test="${cart.ctype eq 'pass' and not empty cart.pimg}">
                                <img src="${cart.pimg}" class="item-img">
                            </c:when>
                            <c:otherwise>
                                <div class="no-img-box">NO IMAGE</div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <div style="flex-grow: 1;">
                        <c:choose>
                            <c:when test="${cart.ctype eq 'book'}">
                                <span class="badge-type">도서 대여</span>
                                <div class="item-name">${cart.bname}</div>
                                <div class="item-subtext">정가: <fmt:formatNumber value="${cart.bprice}" pattern="#,###"/>원</div>
                                <div class="item-subtext">대여 기간: ${cart.cstock * 15}일</div>
                                <div class="item-price">
                                    결제가: <fmt:formatNumber value="${cart.bprice * cart.cstock}" pattern="#,###"/>원
                                </div>
                            </c:when>
                            <c:when test="${cart.ctype eq 'pass'}">
                                <span class="badge-type">이용권</span>
                                <div class="item-name">${cart.pname}</div>
                                <div class="item-subtext">정가: <fmt:formatNumber value="${cart.pprice}" pattern="#,###"/>원</div>
                                <div class="item-subtext">
                                    수량/기간: 
                                    <c:if test="${cart.ptype eq '정기권'}">${cart.cstock * 6}개월</c:if>
                                    <c:if test="${cart.ptype eq 'N회권'}">${cart.cstock * 10}개</c:if>
                                </div>
                                <div class="item-price">
                                    결제가: <fmt:formatNumber value="${cart.pprice * cart.cstock}" pattern="#,###"/>원
                                </div>
                            </c:when>
                        </c:choose>
                    </div>

                    <div style="text-align: right; min-width: 70px;">
                        <a href="/cart/cartDelete?cno=${cart.cno}" class="del-btn" onclick="return confirm('장바구니에서 삭제하시겠습니까?');">삭제</a>
                    </div>

                </div>
            </c:forEach>

            <c:if test="${not empty carts}">
                <div class="pay-btn-wrap">
                    <input type="submit" value="선택 상품 결제하기" class="pay-btn">
                </div>
            </c:if>

        </form>

        <c:if test="${not empty carts}">
            <div class="pagination">
            
                <c:if test="${startPage > 1}">
                    <a href="/cart/cartList?pageNum=${startPage - 1}" class="page-link">&lt;</a>
                </c:if>

                <c:forEach begin="${startPage}" end="${endPage}" var="num">
                    <c:choose>
                        <c:when test="${pageNum == num}">
                            <span class="page-link active">${num}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="/cart/cartList?pageNum=${num}" class="page-link">${num}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${endPage < totalPages}">
                    <a href="/cart/cartList?pageNum=${endPage + 1}" class="page-link">&gt;</a>
                </c:if>

            </div>
        </c:if>

    </div>

	<%@ include file="/WEB-INF/views/guest/footer.jsp" %>
</body>
</html>

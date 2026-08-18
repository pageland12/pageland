<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 목록</title>
<style>
    .all-btn {
        display: inline-block;
        padding: 6px 14px;
        margin-right: 4px;
        background-color: #f8f9fa;
        color: #333;
        text-decoration: none;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    .all-btn.active {
        background-color: #212529;
        color: #ffffff;
        font-weight: bold;
        border-color: #212529;
    }
    .no-img-box {
        width: 80px;
        height: 80px;
        background-color: #f0f0f0;
        color: #aaa;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 11px;
        border-radius: 6px;
    }
    .pay-btn {
        padding: 8px 20px;
        background-color: #0d6efd;
        color: #ffffff;
        border: none;
        border-radius: 4px;
        font-size: 15px;
        font-weight: bold;
        cursor: pointer;
    }
    .del-btn {
        color: #dc3545;
        text-decoration: none;
        font-size: 13px;
    }
    .badge-type {
        display: inline-block;
        padding: 2px 6px;
        font-size: 11px;
        border-radius: 4px;
        background-color: #e9ecef;
        color: #495057;
        margin-bottom: 4px;
    }
</style>
<script>
    // 전체 선택 / 해제 토글
    function toggleAll(source) {
        const checkboxes = document.getElementsByName('cnoList');
        for(let i = 0; i < checkboxes.length; i++) {
            checkboxes[i].checked = source.checked;
        }
    }
</script>
</head>
<body>

    <!-- 상단 메인 이동 링크 -->
    <div style="text-align: right; margin-bottom: 10px;">
        <a href="/" style="text-decoration: none; color: #555; font-size: 14px;">🏠 메인 페이지로 이동</a>
    </div>

    <!-- 헤더 영역 -->
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
        <h2>🛒 장바구니 목록</h2>
    </div>

    <!-- 탭 영역 -->
    <div style="margin-bottom: 20px;">
        <a href="/cart/cartList" class="all-btn active">장바구니 상품</a>
    </div>

    <hr>

    <form name="cartListForm" method="post" action="/pay/cartPayForm">
        <div style="width: 100%; max-width: 800px; margin: 0 auto;">
            
            <!-- 전체 선택 컨트롤 바 -->
            <c:if test="${not empty carts}">
                <div style="padding: 10px; background-color: #f8f9fa; border-radius: 4px; margin-bottom: 10px; display: flex; align-items: center;">
                    <input type="checkbox" id="selectAll" id="selectAll" onclick="toggleAll(this)" checked style="margin-right: 8px; cursor: pointer;">
                    <label for="selectAll" style="font-size: 14px; font-weight: bold; cursor: pointer;">전체 선택</label>
                </div>
            </c:if>

            <c:if test="${empty carts}">
                <div style="text-align: center; padding: 40px 0; color: #777;">
                    장바구니에 담긴 상품이 없습니다.
                </div>
            </c:if>

            <!-- 장바구니 항목 카드 리스트 -->
            <c:forEach var="cart" items="${carts}">
                <div style="display: flex; align-items: center; padding: 16px 10px; border-bottom: 1px solid #ddd;">
                    
                    <!-- 1. 선택 체크박스 -->
                    <div style="margin-right: 15px;">
                        <input type="checkbox" name="cnoList" value="${cart.cno}" checked style="width: 18px; height: 18px; cursor: pointer;">
                    </div>

                    <!-- 2. 상품 이미지 -->
                    <div style="margin-right: 15px;">
                        <c:choose>
                            <c:when test="${cart.ctype eq 'book' and not empty cart.bimg}">
                                <img src="${cart.bimg}" width="80" height="80" style="object-fit: cover; border-radius: 6px; border: 1px solid #eee;">
                            </c:when>
                            <c:when test="${cart.ctype eq 'pass' and not empty cart.pimg}">
                                <img src="${cart.pimg}" width="80" height="80" style="object-fit: cover; border-radius: 6px; border: 1px solid #eee;">
                            </c:when>
                            <c:otherwise>
                                <div class="no-img-box">NO IMAGE</div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <!-- 3. 상품 정보 -->
                    <div style="flex-grow: 1;">
                        <c:choose>
                            <%-- 도서 상품 정보 --%>
                            <c:when test="${cart.ctype eq 'book'}">
                                <span class="badge-type">도서 대여</span>
                                <div style="font-size: 16px; font-weight: bold; color: #333; margin-bottom: 4px;">${cart.bname}</div>
                                <div style="font-size: 13px; color: #666;">정가: <fmt:formatNumber value="${cart.bprice}" pattern="#,###"/>원</div>
                                <div style="font-size: 13px; color: #666;">대여 기간: ${cart.cstock * 15}일 (${cart.cstock}개)</div>
                                <div style="font-size: 15px; font-weight: bold; color: #0d6efd; margin-top: 4px;">
                                    결제가: <fmt:formatNumber value="${cart.bprice * cart.cstock}" pattern="#,###"/>원
                                </div>
                            </c:when>
                            <%-- 이용권 상품 정보 --%>
                            <c:when test="${cart.ctype eq 'pass'}">
                                <span class="badge-type">이용권</span>
                                <div style="font-size: 16px; font-weight: bold; color: #333; margin-bottom: 4px;">${cart.pname}</div>
                                <div style="font-size: 13px; color: #666;">정가: <fmt:formatNumber value="${cart.pprice}" pattern="#,###"/>원</div>
                                <div style="font-size: 13px; color: #666;">
                                    수량/기간: 
                                    <c:if test="${cart.ptype eq '정기권'}">${cart.cstock * 6}개월</c:if>
                                    <c:if test="${cart.ptype eq 'N회권'}">${cart.cstock * 10}개</c:if>
                                </div>
                                <div style="font-size: 15px; font-weight: bold; color: #0d6efd; margin-top: 4px;">
                                    결제가: <fmt:formatNumber value="${cart.pprice * cart.cstock}" pattern="#,###"/>원
                                </div>
                            </c:when>
                        </c:choose>
                    </div>

                    <!-- 4. 장바구니 삭제 -->
                    <div style="text-align: right; min-width: 70px;">
                        <a href="/cart/cartDelete?cno=${cart.cno}" class="del-btn" onclick="return confirm('장바구니에서 삭제하시겠습니까?');">삭제</a>
                    </div>

                </div>
            </c:forEach>

            <!-- 하단 결제 버튼 영역 -->
            <c:if test="${not empty carts}">
                <div style="text-align: right; margin-top: 20px;">
                    <input type="submit" value="선택 상품 결제하기" class="pay-btn">
                </div>
            </c:if>

        </div>
    </form>

    <!-- 페이지 번호 이동 영역 (최대 5개씩 표시) -->
    <c:if test="${not empty carts}">
        <div style="text-align: center; margin-top: 25px;">
        
            <%-- 이전 버튼 --%>
            <c:if test="${startPage > 1}">
                <a href="/cart/cartList?pageNum=${startPage - 1}" style="margin-right: 5px; text-decoration: none; color: black;">[이전]</a>
            </c:if>

            <%-- 페이지 번호 --%>
            <c:forEach begin="${startPage}" end="${endPage}" var="num">
                <c:choose>
                    <c:when test="${pageNum == num}">
                        <span style="font-weight: bold; color: red; margin: 0 5px; font-size: 16px;">${num}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="/cart/cartList?pageNum=${num}" style="margin: 0 5px; text-decoration: none; color: black;">${num}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <%-- 다음 버튼 --%>
            <c:if test="${endPage < totalPages}">
                <a href="/cart/cartList?pageNum=${endPage + 1}" style="margin-left: 5px; text-decoration: none; color: black;">[다음]</a>
            </c:if>

        </div>
    </c:if>

</body>
</html>
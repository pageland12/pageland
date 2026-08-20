<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 대여 도서 내역</title>
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
                <h2 class="content-title">대여 도서 내역</h2>
                <div class="content-subtitle">
                    대여하신 도서를 확인하고 소중한 후기를 남겨보세요!
                </div>
            </div>

            <table class="custom-table">
                <thead>
                    <tr>
                        <th style="width: 120px;">주문상세번호</th>
                        <th style="width: 100px;">도서 이미지</th>
                        <th>도서명</th>
                        <th style="width: 140px;">후기 관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty orderLists}">
                            <tr>
                                <td colspan="4" class="empty-msg">
                                    대여 도서 주문 내역이 없습니다.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="orderList" items="${orderLists}">
                                <tr>
                                    <td>${orderList.odno}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${not empty orderList.bimg}">
                                                <img src="${orderList.bimg}" alt="${orderList.bname}" class="book-thumb">
                                            </c:when>
                                            <c:otherwise>
                                                <div class="no-img-box">NO IMAGE</div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="book-title-cell">
                                        <a href="/guest/bookDetail?bno=${orderList.bno}">${orderList.bname}</a>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${orderList.cnt > 0}">
                                                <span class="badge-review-done">작성 완료</span>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" class="btn-review" onclick="goRatingWrite('${orderList.odno}', '${orderList.bno}', '${orderList.bname}', '${orderList.bimg}')">
                                                    후기 작성
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <!-- 페이징 영역 -->
            <c:if test="${not empty orderLists}">
                <div class="pagination">
                    <c:if test="${startPage > 1}">
                        <a href="/member/myOrderBookList?pageNum=${startPage - 1}">[이전]</a>
                    </c:if>

                    <c:forEach begin="${startPage}" end="${endPage}" var="num">
                        <c:choose>
                            <c:when test="${pageNum == num}">
                                <span class="current-page">${num}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="/member/myOrderBookList?pageNum=${num}">${num}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${endPage < totalPages}">
                        <a href="/member/myOrderBookList?pageNum=${endPage + 1}">[다음]</a>
                    </c:if>
                </div>
            </c:if>
        </main>
    </div>

    <!-- 4. guest 폴더의 footer include -->
    <%@ include file="../guest/footer.jsp" %>

    <script>
    function goRatingWrite(odno, bno, bname, bimg) {
        const encodedBname = encodeURIComponent(bname);
        const encodedBimg = encodeURIComponent(bimg);
        
        location.href = "/board/ratingWriteForm?odno=" + odno 
                      + "&bno=" + bno 
                      + "&bname=" + encodedBname 
                      + "&bimg=" + encodedBimg;
    }
    </script>
</body>
</html>
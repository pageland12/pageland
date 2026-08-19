<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 대여 도서 내역</title>
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

    /* 도서 이미지 */
    .book-thumb {
        width: 90px;
        height: 115px;
        object-fit: cover;
        border-radius: 6px;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
        display: block;
        margin: 0 auto;
    }

    .no-img-box {
        width: 65px;
        height: 80px;
        background-color: #EFE0D3;
        color: #7A6A60;
        display: flex;
        align-items: center;
        justify-content: center;
        font-size: 11px;
        font-weight: 700;
        border-radius: 4px;
        margin: 0 auto;
    }

    .book-title-cell {
        font-weight: 700;
        color: #2C221E;
        text-align: left;
        padding-left: 15px !important;
        line-height: 1.4;
    }

    .book-title-cell a {
        color: #2C221E;
        text-decoration: none;
    }

    .book-title-cell a:hover {
        color: #8B5E3C;
        text-decoration: underline;
    }

    /* 후기 작성 버튼 및 완료 뱃지 */
    .btn-review {
        padding: 7px 16px;
        background-color: #8B5E3C;
        color: #FFFFFF;
        border: none;
        border-radius: 6px;
        font-size: 0.85rem;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.2s ease, transform 0.1s ease;
        white-space: nowrap;
    }

    .btn-review:hover {
        background-color: #6F4A2F;
        transform: translateY(-1px);
    }

    .badge-review-done {
        display: inline-block;
        padding: 5px 12px;
        background-color: #F0EDE8;
        color: #8A7A70;
        font-size: 0.85rem;
        font-weight: 600;
        border-radius: 20px;
        border: 1px solid #DFD7CF;
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
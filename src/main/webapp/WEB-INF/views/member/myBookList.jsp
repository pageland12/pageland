<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 대여중인 도서</title>
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

    .content-count {
        font-size: 0.95rem;
        color: #7A6A60;
    }

    .content-count strong {
        color: #8B5E3C;
        font-size: 1.05rem;
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
        padding: 14px 8px;
        font-weight: 700;
        border-top: 1px solid #E8D8CA;
        border-bottom: 1px solid #E8D8CA;
        white-space: nowrap;
    }

    .custom-table tbody td {
        padding: 16px 8px;
        border-bottom: 1px solid #F0E8E0;
        color: #333333;
        vertical-align: middle;
    }

    .custom-table tbody tr:hover {
        background-color: #FCF9F6;
    }

    /* 도서 이미지 */
    .book-thumb {
        width: 60px;
        height: 75px;
        object-fit: cover;
        border-radius: 4px;
        box-shadow: 0 2px 6px rgba(0,0,0,0.1);
        display: block;
        margin: 0 auto;
    }

    .book-title-cell {
        font-weight: 700;
        color: #2C221E;
        text-align: left;
        max-width: 220px;
        line-height: 1.4;
    }

    /* 뱃지 스타일 */
    .badge {
        display: inline-block;
        padding: 4px 8px;
        border-radius: 20px;
        font-size: 0.8rem;
        font-weight: 700;
    }

    .badge-dday {
        background-color: #E8F4FD;
        color: #1976D2;
        border: 1px solid #B3E5FC;
    }

    .badge-urgent {
        background-color: #FFF3E0;
        color: #E65100;
        border: 1px solid #FFE0B2;
    }

    .badge-overdue {
        background-color: #FFEBEE;
        color: #C62828;
        border: 1px solid #FFCDD2;
    }

    /* 버튼 및 폼 요소 */
    .select-box {
        padding: 6px 10px;
        border: 1px solid #D1C4BA;
        border-radius: 6px;
        font-size: 0.85rem;
        background-color: #FFF;
        outline: none;
    }

    .btn {
        padding: 6px 12px;
        border: none;
        border-radius: 6px;
        font-size: 0.85rem;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.2s ease;
        white-space: nowrap;
    }

    .btn-extend {
        background-color: #8B5E3C;
        color: #FFFFFF;
    }

    .btn-extend:hover {
        background-color: #6F4A2F;
    }

    .btn-free {
        background-color: #2E7D32;
        color: #FFFFFF;
    }

    .btn-free:hover {
        background-color: #1B5E20;
    }

    .btn-return {
        background-color: #5A4A42;
        color: #FFFFFF;
    }

    .btn-return:hover {
        background-color: #3E322C;
    }

    .btn-overdue {
        background-color: #D32F2F;
        color: #FFFFFF;
    }

    .btn-overdue:hover {
        background-color: #B71C1C;
    }

    .btn-disabled {
        background-color: #E0E0E0;
        color: #9E9E9E;
        cursor: not-allowed;
    }

    .inline-form {
        display: inline-flex;
        gap: 6px;
        align-items: center;
        justify-content: center;
    }

    .empty-msg {
        padding: 60px 0;
        color: #999;
        font-size: 1rem;
    }
</style>
</head>
<body>
    <%@ include file="../guest/header.jsp" %>

    <div class="mypage-wrapper">
        <!-- 사이드바 인클루드 -->
        <%@ include file="memberSidebar.jsp" %>

        <!-- 마이페이지 우측 메인 콘텐츠 -->
        <main class="mypage-main">
            <div class="content-header">
                <h2 class="content-title">대여중인 도서 목록</h2>
                <div class="content-count">
                    현재 대여중인 도서: <strong>${books.size()}</strong> / 3권
                </div>
            </div>

            <table class="custom-table">
                <thead>
                    <tr>
                        <th>주문번호</th>
                        <th>도서 이미지</th>
                        <th>도서명</th>
                        <th>대여일</th>
                        <th>반납예정일</th>
                        <th>남은 기간</th>
                        <th>연체일/연체료</th>
                        <th>대여 연장</th>
                        <th>반납</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty books}">
                            <tr>
                                <td colspan="9" class="empty-msg">
                                    현재 대여 중인 도서가 없습니다.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="book" items="${books}">
                                <tr>
                                    <td>${book.olno}</td>
                                    <td>
                                        <c:if test="${not empty book.bimg}">
                                            <img src="${book.bimg}" alt="${book.bname}" class="book-thumb">
                                        </c:if>
                                    </td>
                                    <td class="book-title-cell">${book.bname}</td>
                                    <td>"${book.mbstart}</td>
                                    <td>${book.mbend}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${book.mblatedate > 0}">
                                                <span class="badge badge-overdue">연체중</span>
                                            </c:when>
                                            <c:when test="${book.daysLeft > 3}">
                                                <span class="badge badge-dday">D-${book.daysLeft}</span>
                                            </c:when>
                                            <c:when test="${book.daysLeft >= 0}">
                                                <span class="badge badge-urgent">D-${book.daysLeft} (${book.daysLeft == 0 ? '오늘만료' : '임박'})</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge badge-overdue">기간만료</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${book.mblatedate > 0}">
                                                <span style="color: #D32F2F; font-weight: bold;">
                                                    ${book.mblatedate}일<br>(<fmt:formatNumber value="${book.mblatefee}" pattern="#,###" />원)
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span style="color: #888;">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- 연장 영역 -->
                                    <td>
                                        <c:choose>
                                            <%-- 1. 연체된 경우 연장 불가 --%>
                                            <c:when test="${book.mblatedate > 0}">
                                                <button type="button" class="btn btn-disabled" disabled>연장 불가</button>
                                            </c:when>
                                            <%-- 2. 일반 회원 결제 연장 --%>
                                            <c:otherwise>
                                                <sec:authorize access="hasRole('NORMAL')">
                                                    <form class="inline-form" name="extensionForm" method="post" action="/pay/extensionPayForm">
                                                        <input type="hidden" value="${book.bno}" name="bno">
                                                        <input type="hidden" value="${book.mbno}" name="mbno">
                                                        <input type="hidden" value="" name="pno">
                                                        <input type="hidden" value="book" name="ctype">
                                                        <select name="cstock" class="select-box" required>
                                                            <option value="">선택</option>
                                                            <option value="1">15일</option>
                                                            <option value="2">30일</option>
                                                            <option value="4">60일</option>
                                                        </select>
                                                        <input type="submit" value="연장" class="btn btn-extend">
                                                    </form>
                                                </sec:authorize>
                                                
                                                <%-- 3. 구독자 무료 연장 --%>
                                                <sec:authorize access="hasRole('SUBSCRIBER')">
                                                    <form class="inline-form" name="extensionForm" method="post" action="/pay/extendBookFree" onsubmit="return confirm('구독자 혜택으로 무료 연장하시겠습니까?');">
                                                        <input type="hidden" value="${book.mbno}" name="mbno">
                                                        <select name="cstock" class="select-box" required>
                                                            <option value="">선택</option>
                                                            <option value="1">15일</option>
                                                            <option value="2">30일</option>
                                                        </select>
                                                        <input type="submit" value="무료연장" class="btn btn-free">
                                                    </form>
                                                </sec:authorize>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- 반납 영역 -->
                                    <td>
                                        <c:choose>
                                            <%-- 연체 도서 반납(연체료 결제 이동) --%>
                                            <c:when test="${book.mblatedate > 0}">
                                                <form name="overdueForm" method="post" action="/pay/lateFeePayForm" onsubmit="return confirm('연체료 정산 후 반납이 완료됩니다.\n정산 페이지로 이동하시겠습니까?');">
                                                    <input type="hidden" value="${book.bno}" name="bno">
                                                    <input type="hidden" value="${book.mbno}" name="mbno">
                                                    <input type="hidden" value="${book.mblatefee}" name="mblatefee">
                                                    <input type="hidden" value="" name="pno">
                                                    <input type="hidden" value="book" name="ctype">
                                                    <input type="submit" value="연체료 납부/반납" class="btn btn-overdue">
                                                </form>
                                            </c:when>
                                            <%-- 일반 정상 반납 --%>
                                            <c:otherwise>
                                                <form name="returnForm" method="post" action="/member/returnBook" onsubmit="return confirm('${book.bname} 도서를 반납하시겠습니까?');">
                                                    <input type="hidden" value="${book.bno}" name="bno">
                                                    <input type="hidden" value="${book.mbno}" name="mbno">
                                                    <input type="submit" value="반납" class="btn btn-return">
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </main>
    </div>

    <c:if test="${not empty msg}">
        <script>
            alert("${msg}");
        </script>
    </c:if>

    <%@ include file="../guest/footer.jsp" %>
</body>
</html>
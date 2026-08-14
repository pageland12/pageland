<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 도서</title>
<style>
    /* 버튼 탭 스타일 */
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
    /* 현재 선택된 버튼 스타일 */
    .all-btn.active {
        background-color: #212529;
        color: #ffffff;
        font-weight: bold;
        border-color: #212529;
    }
</style>
</head>
<body>

    <!-- 상단 메인 이동 링크 -->
    <div style="text-align: right; margin-bottom: 10px;">
        <a href="/" style="text-decoration: none; color: #555; font-size: 14px;">🏠 메인 페이지로 이동</a>
    </div>

    <!-- 헤더 타이틀 -->
    <h2>📚 전체 도서</h2>

    <!-- 탭 버튼 영역 (전체 버튼 활성화) -->
    <div style="margin-bottom: 20px;">
        <a href="/guest/allBookList" class="all-btn active">전체</a>
    </div>

    <hr>

    <!-- 전체 도서 목록 출력 -->
    <table>
        <c:forEach var="book" items="${books}" varStatus="status">
            <tr onclick="location.href='/guest/bookDetail?bno=${book.bno}'" style="cursor:pointer;">
                <td><img src="${book.bimg}" width="100" height="100"></td>
                <td>${book.bname}</td>
                <td>${book.bprice}원</td>
            </tr>
        </c:forEach>
    </table>

</body>
</html>
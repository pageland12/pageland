<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분야별 도서</title>
<style>
    /* 버튼 탭 스타일 */
    .genre-btn {
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
    .genre-btn.active {
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
    <h2>📚 ${currentGenre}</h2>

    <!-- 4개 분야 + 전체 버튼 -->
    <div style="margin-bottom: 20px;">
        <a href="/guest/allBookGenreList?genre=전체" 
           class="genre-btn ${selectedGenre == '전체' || empty selectedGenre ? 'active' : ''}">전체</a>
        
        <a href="/guest/allBookGenreList?genre=생활/창작" 
           class="genre-btn ${selectedGenre == '생활/창작' ? 'active' : ''}">생활/창작</a>
        
        <a href="/guest/allBookGenreList?genre=수학/영어" 
           class="genre-btn ${selectedGenre == '수학/영어' ? 'active' : ''}">수학/영어</a>
        
        <a href="/guest/allBookGenreList?genre=자연/과학" 
           class="genre-btn ${selectedGenre == '자연/과학' ? 'active' : ''}">자연/과학</a>
        
        <a href="/guest/allBookGenreList?genre=전래/명작" 
           class="genre-btn ${selectedGenre == '전래/명작' ? 'active' : ''}">전래/명작</a>
    </div>

    <hr>

    <!-- 필터링 결과 출력 목록 -->
    <table>
        <c:forEach var="book" items="${books}">
            <tr onclick="location.href='/guest/bookDetail?bno=${book.bno}'" style="cursor:pointer;">
                <td><img src="${book.bimg}" width="100" height="100"></td>
                <td>[${book.bgenre}] ${book.bname}</td>
                <td>${book.bprice}원</td>
            </tr>
        </c:forEach>
    </table>

</body>
</html>
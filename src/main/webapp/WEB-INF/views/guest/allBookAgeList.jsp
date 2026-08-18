<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>연령별 도서</title>
<style>
    /* 버튼처럼 보이게 만드는 CSS 스타일 */
    .category-btn {
        display: inline-block;
        padding: 6px 14px;
        margin-right: 4px;
        background-color: #f8f9fa;
        color: #333;
        text-decoration: none;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-weight: normal;
    }
    /* 현재 선택된 카테고리 버튼 강조 스타일 */
    .category-btn.active {
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

	<!-- a 태그 링크 바 -->
	<div style="margin-bottom: 20px;">
		<a href="/guest/allBookAgeList?category=전체" 
		   class="category-btn ${selectedCategory == '전체' || empty selectedCategory ? 'active' : ''}">전체</a>
		
		<a href="/guest/allBookAgeList?category=0-3세" 
		   class="category-btn ${selectedCategory == '0-3세' ? 'active' : ''}">0~3세</a>
		
		<a href="/guest/allBookAgeList?category=4-7세" 
		   class="category-btn ${selectedCategory == '4-7세' ? 'active' : ''}">4~7세</a>
		
		<a href="/guest/allBookAgeList?category=초등 저학년" 
		   class="category-btn ${selectedCategory == '초등 저학년' ? 'active' : ''}">초등 저학년</a>
		
		<a href="/guest/allBookAgeList?category=초등 고학년" 
		   class="category-btn ${selectedCategory == '초등 고학년' ? 'active' : ''}">초등 고학년</a>
	</div>

	<hr>

	<!-- 필터링된 결과 도서 목록 출력 -->
	<table>
		<c:forEach var="book" items="${books}">
		    <tr onclick="location.href='/guest/bookDetail?bno=${book.bno}'" style="cursor:pointer;">
		    	<td><img src="${book.bimg}" width="100" height="100"></td>
		    	<td>${book.bname}</td>
		    	<td>${book.bprice}원</td>
		    </tr>
		</c:forEach>
	</table>
	
	<!-- 페이지 번호 이동 영역 -->
	<div style="text-align: center; margin-top: 20px;">
	    
	    <%-- 이전 버튼 --%>
	    <c:if test="${startPage > 1}">
	        <a href="/guest/allBookAgeList?category=${selectedCategory}&pageNum=${startPage - 1}" style="margin-right: 5px; text-decoration: none; color: black;">[이전]</a>
	    </c:if>
	
	    <%-- 페이지 번호 --%>
	    <c:forEach begin="${startPage}" end="${endPage}" var="num">
	        <c:choose>
	            <c:when test="${pageNum == num}">
	                <span style="font-weight: bold; color: red; margin: 0 5px; font-size: 16px;">${num}</span>
	            </c:when>
	            <c:otherwise>
	                <a href="/guest/allBookAgeList?category=${selectedCategory}&pageNum=${num}" style="margin: 0 5px; text-decoration: none; color: black;">${num}</a>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	
	    <%-- 다음 버튼 --%>
	    <c:if test="${endPage < totalPages}">
	        <a href="/guest/allBookAgeList?category=${selectedCategory}&pageNum=${endPage + 1}" style="margin-left: 5px; text-decoration: none; color: black;">[다음]</a>
	    </c:if>
	
	</div>
</body>
</html>
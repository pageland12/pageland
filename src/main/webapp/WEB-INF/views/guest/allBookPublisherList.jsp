<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>출판사별 도서</title>
<style>
    /* 버튼 탭 스타일 */
    .pub-btn {
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
    .pub-btn.active {
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
    <h2>📚 ${currentPublisher}</h2>
    
    <div style="margin-bottom: 20px;">
     
        <a href="/guest/allBookPublisherList?publisher=전체" 
           class="pub-btn ${selectedPublisher == '전체' || empty selectedPublisher ? 'active' : ''}">전체</a>
        
        <a href="/guest/allBookPublisherList?publisher=그레이트북스" 
           class="pub-btn ${selectedPublisher == '그레이트북스' ? 'active' : ''}">그레이트북스</a>
        
        <a href="/guest/allBookPublisherList?publisher=아람북스" 
           class="pub-btn ${selectedPublisher == '아람북스' ? 'active' : ''}">아람북스</a>
        
        <a href="/guest/allBookPublisherList?publisher=키즈스콜레" 
           class="pub-btn ${selectedPublisher == '키즈스콜레' ? 'active' : ''}">키즈스콜레</a>
        
        <a href="/guest/allBookPublisherList?publisher=프뢰벨" 
           class="pub-btn ${selectedPublisher == '프뢰벨' ? 'active' : ''}">프뢰벨</a>
    </div>

    <hr>

    <!-- 필터링 결과 출력 목록 -->
    <table>
        <c:forEach var="book" items="${books}">
            <tr onclick="location.href='/guest/bookDetail?bno=${book.bno}'" style="cursor:pointer;">
                <td><img src="${book.bimg}" width="100" height="100"></td>
                <td>[${book.bpublisher}] ${book.bname}</td>
                <td>${book.bprice}원</td>
            </tr>
        </c:forEach>
    </table>

	<!-- 페이지 번호 이동 영역 -->
	<div style="text-align: center; margin-top: 20px;">
	    
	    <c:if test="${startPage > 1}">
	        <a href="/guest/allBookPublisherList?publisher=${selectedPublisher}&pageNum=${startPage - 1}" style="margin-right: 5px; text-decoration: none; color: black;">[이전]</a>
	    </c:if>
	
	    <c:forEach begin="${startPage}" end="${endPage}" var="num">
	        <c:choose>
	            <c:when test="${pageNum == num}">
	                <span style="font-weight: bold; color: red; margin: 0 5px; font-size: 16px;">${num}</span>
	            </c:when>
	            <c:otherwise>
	                <a href="/guest/allBookPublisherList?publisher=${selectedPublisher}&pageNum=${num}" style="margin: 0 5px; text-decoration: none; color: black;">${num}</a>
	            </c:otherwise>
	        </c:choose>
	    </c:forEach>
	
	    <c:if test="${endPage < totalPages}">
	        <a href="/guest/allBookPublisherList?publisher=${selectedPublisher}&pageNum=${endPage + 1}" style="margin-left: 5px; text-decoration: none; color: black;">[다음]</a>
	    </c:if>
	
	</div>
</body>
</html>
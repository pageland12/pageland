<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>공지사항</title>
			<style>
			    /* 탭 버튼 스타일 */
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
			    /* 작성 버튼 스타일 */
			    .write-btn {
			        display: inline-block;
			        padding: 6px 12px;
			        background-color: #0d6efd;
			        color: #fff;
			        text-decoration: none;
			        border-radius: 4px;
			        font-size: 14px;
			    }
			</style>
	</head>
	<body>
	
	    <!-- 상단 메인 이동 링크 -->
	    <div style="text-align: right; margin-bottom: 10px;">
	        <a href="/" style="text-decoration: none; color: #555; font-size: 14px;">🏠 메인 페이지로 이동</a>
	    </div>
	
	    <!-- 헤더 및 작성 버튼 영역 -->
	    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
	        <h2>📢 공지사항</h2>
	        <sec:authorize access="hasRole('ADMIN')">
	            <a href="/admin/abWriteForm" class="write-btn">✏️ 공지사항 작성</a>
	        </sec:authorize>
	    </div>
	
	    <!-- 탭 버튼 영역 -->
	    <div style="margin-bottom: 20px;">
	        <a href="/guest/noticeList" class="all-btn active">전체</a>
	    </div>
	
	    <hr>
	
	    <!-- 공지사항 목록 출력 (표 및 이미지 제거) -->
	    <div style="width: 100%; max-width: 800px; margin: 0 auto;">
	        <c:forEach var="item" items="${notice}">
	            <div onclick="location.href='/guest/abView?abno=${item.abno}'" 
	                 style="display: flex; justify-content: space-between; align-items: center; padding: 14px 10px; border-bottom: 1px solid #ddd; cursor: pointer; transition: background-color 0.2s;"
	                 onmouseover="this.style.backgroundColor='#f9f9f9';" 
	                 onmouseout="this.style.backgroundColor='transparent';">
	                
	                <!-- 1. 제목 및 작성자 -->
	                <div style="flex-grow: 1; padding-right: 15px;">
	                    <div style="font-weight: bold; font-size: 16px; margin-bottom: 6px; color: #333;">
	                        ${item.abtitle}
	                    </div>
	                    <div style="font-size: 13px; color: #777;">
	                        <span>작성자: ${item.mname ne null ? item.mname : '관리자'}</span>
	                    </div>
	                </div>
	                
	                <!-- 2. 작성일 및 조회수 -->
	                <div style="text-align: right; font-size: 13px; color: #888; white-space: nowrap;">
	                    <div><fmt:formatDate value="${item.abdate}" pattern="yyyy-MM-dd" /></div>
	                    <div style="margin-top: 4px;">조회수 ${item.abhit}</div>
	                </div>
	
	            </div>
	        </c:forEach>
	    </div>
	    
	    <!-- 페이지 번호 이동 영역 (최대 5개씩 표시) -->
	    <div style="text-align: center; margin-top: 25px;">
	    
	        <%-- 이전 버튼 --%>
	        <c:if test="${startPage > 1}">
	            <a href="/guest/noticeList?pageNum=${startPage - 1}" style="margin-right: 5px; text-decoration: none; color: black;">[이전]</a>
	        </c:if>
	
	        <%-- 5개 단위 페이지 번호 --%>
	        <c:forEach begin="${startPage}" end="${endPage}" var="num">
	            <c:choose>
	                <c:when test="${pageNum == num}">
	                    <span style="font-weight: bold; color: red; margin: 0 5px; font-size: 16px;">${num}</span>
	                </c:when>
	                <c:otherwise>
	                    <a href="/guest/noticeList?pageNum=${num}" style="margin: 0 5px; text-decoration: none; color: black;">${num}</a>
	                </c:otherwise>
	            </c:choose>
	        </c:forEach>
	
	        <%-- 다음 버튼 --%>
	        <c:if test="${endPage < totalPages}">
	            <a href="/guest/noticeList?pageNum=${endPage + 1}" style="margin-left: 5px; text-decoration: none; color: black;">[다음]</a>
	        </c:if>
	
	    </div>
	
	</body>
</html>
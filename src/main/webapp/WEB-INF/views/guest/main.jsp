<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pageland</title>
</head>
<body>
	<!-- 공통 -->
	<h2>페이지랜드</h2>
		<p>반갑습니다. 환상의 나라 페이지랜드입니다. ^_^~*</p>
		<p>
			<a href="/guest/allBookList">전체도서 | </a>
			<a href="/guest/allBookAgeList">연령별 | </a>
			<a href="/guest/allPassList">구독 서비스 | </a>
			<a href="/guest/allBookGenreList">분야별 | </a>
			<a href="/guest/allBookPublisherList">출판사별 | </a>
			<select onchange="if(this.value) location.href=this.value;">
			    <option value="">-- 고객센터 --</option>
			    <option value="/guest/noticeList">공지사항</option>
			    <option value="/guest/eventList">이벤트</option>
			    <option value="/guest/qnaList">Q&A</option>
			</select>

		</p>
	<!-- 비회원 -->
	<sec:authorize access="isAnonymous()">
		<a href="/loginForm">로그인</a><br>
		<a href="/guest/writeForm">회원가입</a>
	</sec:authorize>
	<!-- 회원 -->
	<sec:authorize access="hasAnyRole('NORMAL', 'SUBSCRIBER')">
		<a href="/logout">로그아웃 | </a>
		<a href="/member/memberMain">마이페이지 | </a>
		<a href="/member/orderList">주문조회 | </a>
		<a href="/cart/cartList">장바구니</a>
	</sec:authorize>
	<!-- 관리자 -->
	<sec:authorize access="hasRole('ADMIN')">
		<a href="/logout">로그아웃</a><br>
		<a href="/admin/adminMain">관리자페이지</a>
	</sec:authorize>
	
	<table>
		<c:forEach var="best" items="${best}">
		    <tr onclick="location.href='/guest/bookDetail?bno=${best.bno}'" style="cursor:pointer;">
		    	<td><img src="${best.bimg}" width="100" height="100"></td>
		    	<td>${best.bname}</td>
		    	<td>${best.bprice}원</td>
		    </tr>
		</c:forEach>
	</table>
	
	<c:if test="${not empty sessionScope.overdueCount and sessionScope.overdueCount > 0}">
	    <script>
	        const overdueCount = "${sessionScope.overdueCount}";
	        const overdueFee = "${sessionScope.overdueFee}";
	        alert("⚠️ 현재 연체 중인 도서가 " + overdueCount + "권 있습니다.\n(총 연체료: " + overdueFee + "원)\n마이페이지에서 확인 및 반납을 진행해 주세요.");
	    </script>
	    <c:remove var="overdueCount" scope="session" />
	    <c:remove var="overdueFee" scope="session" />
	</c:if>
</body>
</html>
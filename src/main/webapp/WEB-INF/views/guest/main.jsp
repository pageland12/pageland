<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Pageland</title>
<style>
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
    }

    body {
        display: flex;
        flex-direction: column;
    }

    .main-content {
        flex: 1;
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 100px 20px 20px 20px; /* 상단 패딩을 100px로 늘려서 헤더와 간격 확보 */
        box-sizing: border-box;
    }

    /* 상단 헤더 영역 */
    .header-section {
        text-align: center;
        margin-bottom: 35px;
    }

    .title-area {
        display: flex;
        justify-content: center;
        align-items: center;
        gap: 8px;
        margin-bottom: 10px;
    }

    .page-title {
        font-size: 1.6rem;
        font-weight: 800;
        margin: 0;
        color: #000;
    }

    /* DB 전체 도서 개수 표시 영역 */
    .count-section {
        font-size: 0.95rem;
        color: #666;
        margin-bottom: 15px;
    }

    .count-section strong {
        color: #000;
        font-weight: 800;
    }

    /* ---------------------------------------------------- */
    /* 4x4 상품 그리드 스타일 */
    /* ---------------------------------------------------- */
    .book-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr); /* 한 줄에 4개 배치 */
        gap: 24px 20px; /* 카드 간 격차 (상하 24px, 좌우 20px) */
        padding: 10px 0 20px 0;
    }

    .book-card {
        display: flex;
        flex-direction: column;
        align-items: flex-start; /* 좌측 정렬 */
        border: none;
        border-radius: 8px;
        padding: 0 0 15px 0; /* 좌우 padding 제거하여 상단 수직선 맞춤 */
        background-color: #fff;
        box-sizing: border-box;
    }

    /* 1:1 비율 정방형 이미지 박스 */
    .book-img-wrapper {
        width: 100%;
        aspect-ratio: 1 / 1; /* 1:1 비율 지정 */
        overflow: hidden;
        border-radius: 4px;
        margin-bottom: 12px;
        cursor: pointer; /* 이미지 클릭 가능 표시 */
    }

    .book-img-wrapper img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: filter 0.3s ease, opacity 0.3s ease; /* 부드러운 뿌연 효과 전환 */
    }

    /* 마우스 올렸을 때 이미지를 뿌옇게(Blur) 만드는 효과 */
    .book-img-wrapper:hover img {
        filter: blur(3px); /* 블러 처리 */
        opacity: 0.85;     /* 약간 은은하게 불투명도 조절 */
    }

    /* 제목 및 가격 영역 */
    .book-info {
        text-align: left;
        width: 100%;
    }

    .book-title {
        font-size: 0.97rem;
        font-weight: 750;
        color: #000;
        margin-bottom: 6px;
        line-height: 1.4;
        word-break: break-word;
        cursor: pointer; /* 제목 클릭 가능 표시 */
    }

    /* 제목에 마우스 올렸을 때 밑줄 효과 */
    .book-title:hover {
        text-decoration: underline;
    }

    .book-price {
        font-size: 0.92rem;
        font-weight: 500;
        color: #000;
        cursor: default; /* 가격은 기본 마우스 포인터 */
    }
</style>
</head>
<body>
	<%@ include file="header.jsp" %>
	
	<main class="main-content">
	    <!-- 상단 헤더 영역 -->
	    <div class="header-section">
	        <div class="title-area">
	            <h2 class="page-title">베스트 도서</h2>
	        </div>
	    </div>

		<div class="book-grid">
			<c:forEach var="best" items="${best}">
				<div class="book-card">
					<!-- 1. 이미지 (클릭 가능 + 마우스 호버 시 뿌옇게) -->
					<div class="book-img-wrapper" onclick="location.href='/guest/bookDetail?bno=${best.bno}'">
						<img src="${best.bimg}" alt="${best.bname}">
					</div>
					
					<!-- 2. 제목 & 가격 그룹 -->
					<div class="book-info">
						<!-- 제목만 클릭 가능 -->
						<div class="book-title" onclick="location.href='/guest/bookDetail?bno=${best.bno}'">${best.bname}</div>
						<!-- 가격 (클릭 불가) -->
						<div class="book-price">${best.bprice}원</div>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<c:if test="${not empty sessionScope.overdueCount and sessionScope.overdueCount > 0}">
    		<script>
		        const overdueCount = "${sessionScope.overdueCount}";
		        const overdueFee = "${sessionScope.overdueFee}";
		        alert("⚠️ 현재 연체 중인 도서가 " + overdueCount + "권 있습니다.\n(총 연체료: " + overdueFee + "원)\n마이페이지에서 확인 및 반납을 진행해 주세요.");
    		</script>
		    <c:remove var="overdueCount" scope="session" />
		    <c:remove var="overdueFee" scope="session" />
		</c:if>
		
	</main>
	<%@ include file="footer.jsp" %>
</body>
</html>
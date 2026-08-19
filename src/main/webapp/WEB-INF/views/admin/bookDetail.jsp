<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>등록 도서 관리</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/adminDetailCss.css'/>">
</head>
<body>
    <%@ include file="../guest/header.jsp" %>
    
    <div class="detail-container">
        <!-- 상단 2단 레이아웃 (좌: 이미지 / 우: 상세 정보) -->
        <div class="product-top-section">
            
            <!-- 좌측 대표 썸네일 -->
            <div class="product-image-area">
                <img alt="${book.bname}" src="${book.bimg}">
            </div>
            
            <!-- 우측 상품 정보 및 관리자 메뉴 -->
            <div class="product-info-area">
                <div>
                    <span class="admin-badge">관리자 모드</span>
                </div>
                <h1 class="product-title">${book.bname}</h1>
                
                <div class="info-row">
                    <span class="info-label">연령</span>
                    <span class="info-value">${book.bage}</span>
                </div>

                <div class="info-row">
                    <span class="info-label">분야</span>
                    <span class="info-value">${book.bgenre}</span>
                </div>

                <div class="info-row">
                    <span class="info-label">출판사</span>
                    <span class="info-value">${book.bpublisher}</span>
                </div>
                
                <div class="info-row">
                    <span class="info-label">가격</span>
                    <span class="info-value price">${book.bprice}원</span>
                </div>

                <div class="info-row">
                    <span class="info-label">재고수량</span>
                    <span class="info-value">${book.bstock}개</span>
                </div>
                
                <div class="info-row">
                    <span class="info-label">추천수</span>
                    <span class="info-value like-count">♥ ${book.blike}</span>
                </div>
                
                <!-- 관리자 버튼 영역 (수정 / 삭제 / 목록) -->
                <div class="button-group">
                    <a href="/admin/bookUpdateForm?bno=${book.bno}" class="btn-update">수정하기</a>
                    <a href="javascript:void(0);" onclick="deleteCheck('${book.bno}')" class="btn-delete">삭제하기</a>
                    <button type="button" class="btn-list" onclick="location.href='/guest/allBookList'">도서 목록</button>
                </div>
            </div>
        </div>
        
        <!-- 하단 상세 설명 이미지 -->
        <div class="product-detail-section">
            <h2 class="detail-title">상세 정보</h2>
            <img class="detail-content-img" alt="도서정보" src="${book.binfo}">
        </div>
    </div>

    <script>
        // 삭제 클릭 시 실수 방지를 위한 확인 창
        function deleteCheck(bno) {
            if (confirm("정말 이 도서를 삭제하시겠습니까?")) {
                location.href = "/admin/bookDelete?bno=" + bno;
            }
        }
    </script>
    
  	<%@ include file="../guest/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>등록 구독권 관리</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/detailCss.css'/>">
</head>
<body>
    <%@ include file="../guest/header.jsp" %>
    
    <div class="detail-container">
        <!-- 상단 2단 레이아웃 (좌: 이미지 / 우: 상세 정보) -->
        <div class="product-top-section">
            
            <!-- 좌측 대표 썸네일 -->
            <div class="product-image-area">
                <img alt="${pass.pname}" src="${pass.pimg}">
            </div>
            
            <!-- 우측 구독권 정보 및 관리자 메뉴 -->
            <div class="product-info-area">
                <div>
                    <span class="admin-badge">관리자 모드</span>
                </div>
                <h1 class="product-title">${pass.pname}</h1>
                
                <div class="info-row">
                    <span class="info-label">구독권 유형</span>
                    <span class="info-value">${pass.ptype}</span>
                </div>

                <div class="info-row">
                    <span class="info-label">구독권 기간</span>
                    <span class="info-value">${pass.pperiod}</span>
                </div>

                <div class="info-row">
                    <span class="info-label">N회권 개수</span>
                    <span class="info-value">${pass.pcount}개</span>
                </div>
                
                <div class="info-row">
                    <span class="info-label">가격</span>
                    <span class="info-value price">${pass.pprice}원</span>
                </div>
                
                <!-- 관리자 버튼 영역 (수정 / 삭제 / 관리자페이지) -->
                <div class="button-group">
                    <a href="/admin/passUpdateForm?pno=${pass.pno}" class="btn-update">수정하기</a>
                    <a href="javascript:void(0);" onclick="deleteCheck('${pass.pno}')" class="btn-delete">삭제하기</a>
                </div>
            </div>
        </div>
        
        <!-- 하단 상세 설명 이미지 -->
        <div class="product-detail-section">
            <h2 class="detail-title">상세 정보</h2>
            <img class="detail-content-img" alt="구독권 상세정보" src="${pass.pinfo}">
        </div>
    </div>

    <script>
        function deleteCheck(pno) {
            if (confirm("정말 이 구독권을 삭제하시겠습니까?")) {
                location.href = "/admin/passDelete?pno=" + pno;
            }
        }
    </script>
    <%@ include file="../guest/footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 회원 상세보기</title>
<link rel="stylesheet" href="/css/adminSystem.css">
</head>
<body>

    <!-- 상단 헤더 포함 -->
    <%@ include file="header.jsp" %>

    <main class="main-content">
        <div class="page-title">회원 상세보기</div>

        <div class="admin-panel">
            <table class="admin-view-table">
                <tr>
                    <th>회원번호</th>
                    <td>${view.mno}</td>
                </tr>
                <tr>
                    <th>이메일</th>
                    <td>${view.memail}</td>
                </tr>
                <tr>
                    <th>비밀번호</th>
                    <td>${view.mpasswd}</td>
                </tr>
                <tr>
                    <th>이름</th>
                    <td>${view.mname}</td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td>${view.maddr}</td>
                </tr>
                <tr>
                    <th>연락처</th>
                    <td>${view.mtel}</td>
                </tr>
                <tr>
                    <th>계좌정보</th>
                    <td>${view.maccount}</td>
                </tr>
                <tr>
                    <th>등급</th>
                    <td>${view.mgrade}</td>
                </tr>
                <tr>
                    <th>생성일</th>
                    <td>${view.mdate}</td>
                </tr>
                <tr>
                    <th>포인트</th>
                    <td>${view.mpoint}</td>
                </tr>
            </table>
            
            <!-- 하단 버튼 영역 -->
            <div class="btn-area">
                <a href="/admin/passwordCheckForm?mode=update&mno=${view.mno}" class="btn btn-dark">회원수정</a>
                <a href="/admin/passwordCheckForm?mode=delete&mno=${view.mno}" class="btn btn-outline">탈퇴</a>
            </div>
        </div>
    </main>

    <!-- 하단 푸터 포함 -->
    <%@ include file="footer.jsp" %>

</body>
</html>
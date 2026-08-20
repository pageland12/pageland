<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="maddrArray" value="${fn:split(update.maddr, ',')}" />
<c:set var="mtelArray" value="${fn:split(update.mtel, '-')}" />
<c:set var="maccountArray" value="${fn:split(update.maccount, ',')}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 회원 수정</title>
<link rel="stylesheet" href="/css/adminSystem.css">
</head>
<body>

    <!-- 상단 헤더 포함 -->
    <%@ include file="../guest/header.jsp" %>

    <main class="main-content">
        <div class="page-title">회원 정보 수정</div>

        <div class="admin-panel">
            <form name="adminUpdate" method="post" action="/admin/adminUpdate">
                <input type="hidden" name="mno" value="${update.mno}">
                
                <table class="admin-write-table">
                    <tr>
                        <th>회원번호</th>
                        <td>${update.mno}</td>
                    </tr>
                    <tr>
                        <th>이메일</th>
                        <td>${update.memail}</td>
                    </tr>
                    <tr>
                        <th>비밀번호</th>
                        <td>${update.mpasswd}</td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>${update.mname}</td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>${update.maddr}</td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td>${update.mtel}</td>
                    </tr>
                    <tr>
                        <th>계좌정보</th>
                        <td>${update.maccount}</td>
                    </tr>
                    <tr>
                        <th>등급</th>
                        <td>
                            <select name="mgrade" required>
                                <option value="">----- 등급 선택 -----</option>
                                <option value="NORMAL" ${update.mgrade == 'NORMAL' ? 'selected' : ''}>NORMAL</option>
                                <option value="SUBSCRIBER" ${update.mgrade == 'SUBSCRIBER' ? 'selected' : ''}>SUBSCRIBER</option>
                                <option value="INACTIVE" ${update.mgrade == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
                                <option value="ADMIN" ${update.mgrade == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>생성일</th>
                        <td>${update.mdate}</td>
                    </tr>
                    <tr>
                        <th>포인트</th>
                        <td><input type="text" name="mpoint" value="${update.mpoint}"></td>
                    </tr>
                </table>
                
                <!-- 하단 버튼 영역 -->
                <div class="btn-area">
                    <input type="submit" value="수정" class="btn btn-submit">
                    <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                </div>
            </form>
        </div>
    </main>

    <!-- 하단 푸터 포함 -->
    <%@ include file="../guest/footer.jsp" %>

</body>
</html>
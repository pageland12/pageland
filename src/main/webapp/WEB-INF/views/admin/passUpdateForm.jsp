<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 구독권 수정</title>
<script src="/js/passUpdate.js"></script>
<link rel="stylesheet" href="/css/adminSystem.css">
</head>
<body>

    <!-- 상단 헤더 포함 -->
    <%@ include file="../guest/header.jsp" %>

    <main class="main-content">
        <div class="page-title">구독권 정보 수정</div>

        <div class="admin-panel">
            <form name="passUpdateForm" method="post" action="/admin/passUpdate">
                <input type="hidden" name="pno" value="${update.pno}">
                
                <table class="admin-write-table">
                    <tr>
                        <th>구독권명</th>
                        <td><input type="text" name="pname" value="${update.pname}" placeholder="구독권을 입력하세요"></td>
                    </tr>
                    <tr>
                        <th>구독권 종류</th>
                        <td>
                            <select name="ptype">
                                <option value="">선택</option>
                                <option value="정기권" ${update.ptype == '정기권' ? 'selected' : ''}>정기권</option>
                                <option value="N회권" ${update.ptype == 'N회권' ? 'selected' : ''}>N회권</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>구독권 이미지</th>
                        <td><input type="text" name="pimg" value="${update.pimg}" placeholder="구독권 이미지 URL"></td>
                    </tr>
                    <tr>
                        <th>상세 정보</th>
                        <td><input type="text" name="pinfo" value="${update.pinfo}" placeholder="상세 정보 이미지 URL"></td>
                    </tr>
                    <tr>
                        <th>구독권 가격</th>
                        <td><input type="text" name="pprice" value="${update.pprice}" placeholder="구독권 가격"></td>
                    </tr>                        
                    <tr>
                        <th>구독권 기간</th>
                        <td><input type="text" name="pperiod" value="${update.pperiod}" placeholder="구독권 기간(정기권)"></td>
                    </tr>
                    <tr>
                        <th>구독권 횟수</th>
                        <td><input type="text" name="pcount" value="${update.pcount}" placeholder="구독권 횟수(N회권)"></td>
                    </tr>            
                </table>
                
                <!-- 하단 버튼 영역 -->
                <div class="btn-area">
                    <input type="submit" value="수정" class="btn btn-submit" onclick="return check()">
                    <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                </div>
            </form>
        </div>
    </main>

    <!-- 하단 푸터 포함 -->
    <%@ include file="../guest/footer.jsp" %>

</body>
</html>
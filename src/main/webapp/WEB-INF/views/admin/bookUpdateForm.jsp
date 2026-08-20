<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 도서 수정</title>
<script src="/js/bookUpdate.js"></script>
<link rel="stylesheet" href="/css/adminSystem.css">
</head>
<body>

    <!-- 상단 헤더 포함 -->
    <%@ include file="../guest/header.jsp" %>

    <main class="main-content">
        <div class="page-title">도서 정보 수정</div>

        <div class="admin-panel">
            <form name="bookUpdateForm" method="post" action="/admin/bookUpdate">
                <input type="hidden" name="bno" value="${update.bno}">
                
                <table class="admin-write-table">
                    <tr>
                        <th>도서명</th>
                        <td><input type="text" name="bname" value="${update.bname}" placeholder="도서명"></td>
                    </tr>
                    <tr>
                        <th>연령</th>
                        <td>
                            <select name="bage">
                                <option value="">선택</option>
                                <option value="0-3세" ${update.bage == '0-3세' ? 'selected' : ''}>0-3세</option>
                                <option value="4-7세" ${update.bage == '4-7세' ? 'selected' : ''}>4-7세</option>
                                <option value="초등 저학년" ${update.bage == '초등 저학년' ? 'selected' : ''}>초등 저학년</option>
                                <option value="초등 고학년" ${update.bage == '초등 고학년' ? 'selected' : ''}>초등 고학년</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>분야</th>
                        <td>
                            <select name="bgenre">
                                <option value="">선택</option>
                                <option value="생활/창작" ${update.bgenre == '생활/창작' ? 'selected' : ''}>생활/창작</option>
                                <option value="전래/명작" ${update.bgenre == '전래/명작' ? 'selected' : ''}>전래/명작</option>
                                <option value="수학/영어" ${update.bgenre == '수학/영어' ? 'selected' : ''}>수학/영어</option>
                                <option value="자연/과학" ${update.bgenre == '자연/과학' ? 'selected' : ''}>자연/과학</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>출판사</th>
                        <td><input type="text" name="bpublisher" value="${update.bpublisher}" placeholder="출판사명"></td>
                    </tr>            
                    <tr>
                        <th>도서 이미지</th>
                        <td><input type="text" name="bimg" value="${update.bimg}" placeholder="도서 이미지 URL"></td>
                    </tr>
                    <tr>
                        <th>상세 정보</th>
                        <td><input type="text" name="binfo" value="${update.binfo}" placeholder="상세 정보 이미지 URL"></td>
                    </tr>
                    <tr>
                        <th>가격</th>
                        <td><input type="text" name="bprice" value="${update.bprice}" placeholder="정상 대여가(15일)"></td>
                    </tr>
                    <tr>
                        <th>재고 수량</th>
                        <td><input type="text" name="bstock" value="${update.bstock}" placeholder="재고 수량"></td>
                    </tr>
                </table>
                
                <!-- 하단 버튼 영역 (수정 및 취소 버튼 배치) -->
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 도서 등록</title>
<script src="/js/bookWrite.js"></script>
<link rel="stylesheet" href="/css/adminSystem.css">
</head>
<body>

    <!-- 상단 헤더 포함 -->
    <%@ include file="../guest/header.jsp" %>

    <main class="main-content">
        <div class="page-title">신규 도서 등록</div>

        <div class="admin-panel">
            <form name="bookWriteForm" method="post" action="/admin/bookWrite">
                <table class="admin-write-table">
                    <tr>
                        <th>도서명</th>
                        <td>
                            <input type="text" name="bname" placeholder="도서명">
                        </td>
                    </tr>
                    <tr>
                        <th>연령</th>
                        <td>
                            <select name="bage">
                                <option value="">선택</option>
                                <option value="0-3세">0-3세</option>
                                <option value="4-7세">4-7세</option>
                                <option value="초등 저학년">초등 저학년</option>
                                <option value="초등 고학년">초등 고학년</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>분야</th>
                        <td>
                            <select name="bgenre">
                                <option value="">선택</option>
                                <option value="생활/창작">생활/창작</option>
                                <option value="전래/명작">전래/명작</option>
                                <option value="수학/영어">수학/영어</option>
                                <option value="자연/과학">자연/과학</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>출판사</th>
                        <td>
                            <input type="text" name="bpublisher" placeholder="출판사명">
                        </td>
                    </tr>
                    <tr>
                        <th>도서 이미지</th>
                        <td>
                            <input type="text" name="bimg" placeholder="도서 이미지 URL">
                        </td>
                    </tr>
                    <tr>
                        <th>상세 정보</th>
                        <td>
                            <input type="text" name="binfo" placeholder="상세 정보 이미지 URL">
                        </td>
                    </tr>
                    <tr>
                        <th>가격</th>
                        <td>
                            <input type="text" name="bprice" placeholder="정상 대여가(15일)">
                        </td>
                    </tr>
                    <tr>
                        <th>재고 수량</th>
                        <td>
                            <input type="text" name="bstock" placeholder="재고 수량">
                        </td>
                    </tr>
                </table>
                
                <!-- 하단 버튼 영역 -->
                <div class="btn-area">
                    <input type="submit" value="등록" class="btn btn-submit" onclick="return check()">
                    <button type="button" class="btn btn-cancel" onclick="history.back()">취소</button>
                </div>
            </form>
        </div>
    </main>

    <!-- 하단 푸터 포함 -->
    <%@ include file="../guest/footer.jsp" %>

</body>
</html>
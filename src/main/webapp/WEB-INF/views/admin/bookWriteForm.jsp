<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 도서 등록</title>
<script src="bookWrite.js"></script>
<style>
    /* 공통 레이아웃 */
    html, body {
        height: 100%;
        margin: 0;
        padding: 0;
    }
    
    body {
        display: flex;
        flex-direction: column;
        background-color: #ffffff;
        color: #333333;
        font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
    }
    
    .main-content {
        flex: 1;
        width: 100%;
        max-width: 1200px;
        margin: 0 auto;
        padding: 100px 20px 40px 20px;
        box-sizing: border-box;
    }

    /* 페이지 타이틀 */
    .page-title {
        text-align: center;
        font-size: 1.6rem;
        font-weight: 800;
        color: #000;
        margin-bottom: 35px;
    }

    /* 관리자 패널 박스 (세로 길이에 맞춰 내부 패딩 넉넉히 부여) */
    .admin-panel {
        background-color: #f8f9fa;
        border: 1px solid #dee2e6;
        border-radius: 6px;
        padding: 55px 45px 25px 45px;
        width: 100%;
        max-width: 850px;
        margin: 0 auto;
        box-sizing: border-box;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.03);
    }

    /* 등록 폼 테이블 디자인 (세로 폭을 더 넓고 쾌적하게 확장) */
    .admin-write-table {
        width: 100%;
        border-collapse: collapse;
        font-size: 0.95rem;
        margin-bottom: 20px;
    }

    .admin-write-table th {
        background-color: #f8f9fa;
        color: #111111;
        font-weight: 700;
        width: 20%;
        padding: 22px 15px; /* 세로 길이를 더 넓게 확장 */
        border-bottom: 1px solid #dee2e6;
        text-align: left;
    }

    .admin-write-table td {
        padding: 17px 15px; /* 세로 길이를 더 넓게 확장 */
        border-bottom: 1px solid #dee2e6;
        color: #333333;
    }

    /* 입력 필드 및 셀렉트박스 디자인 (높이감 부여) */
    .admin-write-table input[type="text"],
    .admin-write-table select {
        width: 100%;
        padding: 12px 12px;
        border: 1px solid #ced4da;
        border-radius: 4px;
        box-sizing: border-box;
        font-size: 0.95rem;
        font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
        outline: none;
        background-color: #ffffff;
        transition: border-color 0.2s;
    }

    .admin-write-table input[type="text"]:focus,
    .admin-write-table select:focus {
        border-color: #212529;
    }

    /* 하단 버튼 영역 (우측 정렬 및 밀착) */
    .btn-area {
        display: flex;
        justify-content: flex-end;
        align-items: center;
    }

    /* 버튼 기본 스타일 */
    .btn {
        display: inline-flex;
        justify-content: center;
        align-items: center;
        padding: 10px 30px;
        border-radius: 4px;
        font-size: 0.95rem;
        font-weight: 600;
        text-decoration: none;
        cursor: pointer;
        transition: all 0.2s;
    }

    /* 등록하기 버튼 (다크 스타일) */
    .btn-submit {
        background-color: #212529;
        color: #ffffff;
        border: 1px solid #212529;
    }
    .btn-submit:hover {
        background-color: #444444;
        border-color: #444444;
    }
</style>
</head>
<body>

    <!-- 상단 헤더 포함 -->
    <%@ include file="header.jsp" %>

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
                </div>
            </form>
        </div>
    </main>

    <!-- 하단 푸터 포함 -->
    <%@ include file="footer.jsp" %>

</body>
</html>
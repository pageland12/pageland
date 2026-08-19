<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 - 구독권 등록</title>
<script src="/js/passWrite.js"></script>
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

    /* 관리자 패널 박스 */
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

    /* 등록 폼 테이블 디자인 */
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
        padding: 22px 15px;
        border-bottom: 1px solid #dee2e6;
        text-align: left;
    }

    .admin-write-table td {
        padding: 17px 15px;
        border-bottom: 1px solid #dee2e6;
        color: #333333;
    }

    /* 입력 필드 및 셀렉트박스 디자인 */
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

    /* 하단 버튼 영역 (우측 정렬) */
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

    /* 등록하기 버튼 */
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
        <div class="page-title">신규 구독권 등록</div>

        <div class="admin-panel">
            <form name="passWriteForm" method="post" action="/admin/passWrite">
                <table class="admin-write-table">
                    <tr>
                        <th>구독권명</th>
                        <td>
                            <input type="text" name="pname" placeholder="구독권명">
                        </td>
                    </tr>
                    <tr>
                        <th>구독권 종류</th>
                        <td>
                            <select name="ptype">
                                <option value="">선택</option>
                                <option value="정기권">정기권</option>
                                <option value="N회권">N회권</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <th>구독권 이미지</th>
                        <td>
                            <input type="text" name="pimg" placeholder="구독권 이미지 URL">
                        </td>
                    </tr>
                    <tr>
                        <th>상세 정보</th>
                        <td>
                            <input type="text" name="pinfo" placeholder="상세 정보 이미지 URL">
                        </td>
                    </tr>
                    <tr>
                        <th>구독권 가격</th>
                        <td>
                            <input type="text" name="pprice" placeholder="구독권 가격">
                        </td>
                    </tr>
                    <tr>
                        <th>구독권 기간</th>
                        <td>
                            <input type="text" name="pperiod" placeholder="구독권 기간(정기권)">
                        </td>
                    </tr>
                    <tr>
                        <th>구독권 횟수</th>
                        <td>
                            <input type="text" name="pcount" placeholder="구독권 횟수(N회권)">
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
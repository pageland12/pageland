<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<c:set var="maddrArray" value="${fn:split(update.maddr, ',')}" />
<c:set var="mtelArray" value="${fn:split(update.mtel, '-')}" />
<c:set var="maccountArray" value="${fn:split(update.maccount, ',')}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 회원정보 수정</title>
<style>
    .mypage-wrapper {
        width: 100%;
        max-width: 1400px;
        margin: 0 auto;
        padding: 50px 30px 60px 30px;
        box-sizing: border-box;
        display: flex;
        gap: 40px;
        align-items: flex-start;
    }

    .mypage-main {
        flex: 1;
        background-color: #FFFFFF;
        border-radius: 12px;
        padding: 35px 40px;
        border: 1px solid #EFE0D3;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
        box-sizing: border-box;
    }

    .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 18px;
        margin-bottom: 30px;
        border-bottom: 2px solid #5A4A42;
    }

    .content-title {
        font-size: 1.45rem;
        font-weight: 800;
        color: #2C221E;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .content-subtitle {
        font-size: 0.9rem;
        color: #7A6A60;
    }

    /* 폼 테이블 스타일 */
    .form-table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 30px;
    }

    .form-table tr {
        border-bottom: 1px solid #F0E8E0;
    }

    .form-table th {
        width: 150px;
        padding: 16px 12px;
        background-color: #FCF9F6;
        color: #5A4A42;
        font-weight: 700;
        font-size: 0.95rem;
        text-align: left;
        vertical-align: middle;
    }

    .form-table td {
        padding: 14px 18px;
        vertical-align: middle;
    }

    /* 인풋 및 셀렉트 공통 */
    .form-control {
        height: 38px;
        padding: 0 12px;
        border: 1px solid #D9CDC2;
        border-radius: 6px;
        font-size: 0.95rem;
        color: #333333;
        outline: none;
        box-sizing: border-box;
        transition: border-color 0.2s, box-shadow 0.2s;
    }

    .form-control:focus {
        border-color: #8B5E3C;
        box-shadow: 0 0 0 2px rgba(139, 94, 60, 0.15);
    }

    .form-control[readonly] {
        background-color: #F8F5F2;
        color: #777777;
        cursor: not-allowed;
    }

    .input-full {
        width: 100%;
        max-width: 400px;
    }

    .input-mid {
        width: 250px;
    }

    .input-tel {
        width: 80px;
        text-align: center;
    }

    /* 그룹형 레이아웃 */
    .input-group-row {
        display: flex;
        gap: 8px;
        align-items: center;
    }

    .address-stack {
        display: flex;
        flex-direction: column;
        gap: 8px;
    }

    /* 버튼 스타일 */
    .btn-search {
        height: 38px;
        padding: 0 16px;
        background-color: #5A4A42;
        color: #FFFFFF;
        border: none;
        border-radius: 6px;
        font-size: 0.9rem;
        font-weight: 600;
        cursor: pointer;
        transition: background-color 0.2s;
        white-space: nowrap;
    }

    .btn-search:hover {
        background-color: #3E322C;
    }

    .form-btn-area {
        display: flex;
        justify-content: center;
        gap: 12px;
        margin-top: 20px;
    }

    .btn-submit {
        padding: 12px 40px;
        background-color: #8B5E3C;
        color: #FFFFFF;
        border: none;
        border-radius: 8px;
        font-size: 1.05rem;
        font-weight: 700;
        cursor: pointer;
        transition: background-color 0.2s, transform 0.1s;
    }

    .btn-submit:hover {
        background-color: #6F4A2F;
        transform: translateY(-1px);
    }

    .btn-cancel {
        padding: 12px 30px;
        background-color: #EDE5DF;
        color: #5A4A42;
        border: none;
        border-radius: 8px;
        font-size: 1.05rem;
        font-weight: 600;
        cursor: pointer;
        text-decoration: none;
        display: inline-flex;
        align-items: center;
        justify-content: center;
        transition: background-color 0.2s;
    }

    .btn-cancel:hover {
        background-color: #DED3CA;
    }
</style>
</head>
<body>
    <!-- 1. guest 폴더의 header include -->
    <%@ include file="../guest/header.jsp" %>

    <div class="mypage-wrapper">
        <!-- 2. member 폴더의 사이드바 include -->
        <%@ include file="memberSidebar.jsp" %>

        <!-- 3. 우측 본문 영역 -->
        <main class="mypage-main">
            <div class="content-header">
                <h2 class="content-title">회원정보 수정</h2>
                <div class="content-subtitle">
                    회원님의 기본 정보와 환불/정산용 계좌 정보를 수정할 수 있습니다.
                </div>
            </div>

            <form name="memberUpdate" method="post" action="/member/memberUpdate">
                <input type="hidden" name="mno" value="${update.mno}">

                <table class="form-table">
                    <tr>
                        <th>이메일 (아이디)</th>
                        <td>
                            <input type="text" name="memail" class="form-control input-full" readonly value="${update.memail}">
                        </td>
                    </tr>
                    <tr>
                        <th>이름</th>
                        <td>
                            <input type="text" name="mname" class="form-control input-mid" value="${update.mname}">
                        </td>
                    </tr>
                    <tr>
                        <th>주소</th>
                        <td>
                            <div class="address-stack">
                                <div class="input-group-row">
                                    <input type="text" name="mzipno" class="form-control" style="width: 120px;" readonly placeholder="우편번호" value="${maddrArray[2]}">
                                    <input type="button" value="주소검색" class="btn-search" onclick="goPopup();">
                                </div>
                                <input type="text" name="maddr1" class="form-control input-full" readonly placeholder="기본주소" value="${maddrArray[0]}">
                                <input type="text" name="maddr2" class="form-control input-full" placeholder="상세주소" value="${maddrArray[1]}">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>연락처</th>
                        <td>
                            <div class="input-group-row">
                                <input type="text" name="mtel1" class="form-control input-tel" maxlength="3" value="${mtelArray[0]}">
                                <span>-</span>
                                <input type="text" name="mtel2" class="form-control input-tel" maxlength="4" value="${mtelArray[1]}">
                                <span>-</span>
                                <input type="text" name="mtel3" class="form-control input-tel" maxlength="4" value="${mtelArray[2]}">
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <th>환불 계좌 정보</th>
                        <td>
                            <div class="address-stack">
                                <div class="input-group-row">
                                    <select name="maccount2" class="form-control" style="width: 160px;">
                                        <option value="">은행 선택</option>
                                        <option value="KB국민은행" ${maccountArray[1] == 'KB국민은행' ? 'selected' : ''}>KB국민은행</option>
                                        <option value="NH농협은행" ${maccountArray[1] == 'NH농협은행' ? 'selected' : ''}>NH농협은행</option>
                                        <option value="우리은행" ${maccountArray[1] == '우리은행' ? 'selected' : ''}>우리은행</option>
                                        <option value="BNK부산은행" ${maccountArray[1] == 'BNK부산은행' ? 'selected' : ''}>BNK부산은행</option>
                                        <option value="카카오뱅크" ${maccountArray[1] == '카카오뱅크' ? 'selected' : ''}>카카오뱅크</option>
                                        <option value="토스뱅크" ${maccountArray[1] == '토스뱅크' ? 'selected' : ''}>토스뱅크</option>
                                    </select>
                                    <input type="text" name="maccount1" class="form-control" style="width: 130px;" placeholder="예금주" value="${maccountArray[0]}">
                                </div>
                                <input type="text" name="maccount3" class="form-control input-full" placeholder="계좌번호 (- 제외)" value="${maccountArray[2]}">
                            </div>
                        </td>
                    </tr>
                </table>

                <div class="form-btn-area">
                    <input type="submit" value="정보 수정" class="btn-submit" onclick="return check()">
                    <a href="/member/myBookList" class="btn-cancel">취소</a>
                </div>
            </form>
        </main>
    </div>

    <!-- 4. guest 폴더의 footer include -->
    <%@ include file="../guest/footer.jsp" %>

    <script src="/js/memberUpdate.js"></script>
</body>
</html>
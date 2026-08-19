<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 중복 검사</title>
<style>
    body {
        margin: 0;
        padding: 0;
        background-color: #f8f8f8;
        font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
        display: flex;
        justify-content: center;
        align-items: center;
        min-height: 100vh;
        box-sizing: border-box;
    }

    .popup-card {
        background-color: #ffffff;
        width: 100%;
        max-width: 360px;
        padding: 30px 24px;
        border-radius: 16px;
        box-shadow: 0 4px 20px rgba(0, 0, 0, 0.06);
        box-sizing: border-box;
        text-align: center;
    }

    .popup-title {
        font-size: 18px;
        font-weight: bold;
        color: #111111;
        margin-top: 0;
        margin-bottom: 20px;
    }

    .input-group {
        display: flex;
        gap: 8px;
        margin-bottom: 15px;
    }

    input[type="text"] {
        flex: 1;
        height: 44px;
        padding: 0 12px;
        background-color: #f7f7f7;
        border: 1px solid #eeeeee;
        border-radius: 8px;
        font-size: 13px;
        color: #333333;
        box-sizing: border-box;
        outline: none;
        transition: border-color 0.2s, background-color 0.2s;
    }

    input[type="text"]:focus {
        border-color: #8c5a3c;
        background-color: #ffffff;
    }

    .btn-check {
        height: 44px;
        padding: 0 14px;
        background-color: #8c5a3c;
        color: #ffffff;
        border: none;
        border-radius: 8px;
        font-size: 13px;
        font-weight: bold;
        cursor: pointer;
        white-space: nowrap;
        transition: background-color 0.2s;
    }

    .btn-check:hover {
        background-color: #73482f;
    }

    .result-box {
        margin-top: 18px;
        padding: 16px 12px;
        border-radius: 10px;
        font-size: 13px;
        line-height: 1.5;
    }

    .result-box.danger {
        background-color: #fff0f0;
        border: 1px solid #ffd1d1;
        color: #e53935;
    }

    .result-box.success {
        background-color: #f0f7f4;
        border: 1px solid #cce5d9;
        color: #2e7d32;
    }

    .result-box strong {
        color: #111111;
        word-break: break-all;
    }

    .btn-use {
        width: 100%;
        height: 42px;
        margin-top: 12px;
        background-color: #2e7d32;
        color: #ffffff;
        border: none;
        border-radius: 8px;
        font-size: 13px;
        font-weight: bold;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .btn-use:hover {
        background-color: #215c24;
    }
</style>
<script>
    function useEmail() {
        opener.emailCallBack("${memail}");
        window.close();
    }
    
    function check() {
        let memail = document.emailCheck.memail;
        let memailExp = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        
        if(!memail.value){
            alert("이메일을 입력해주세요.");
            memail.focus();
            return false;
        }
        
        if(!memailExp.test(memail.value)){
            alert("이메일을 올바르게 입력해주세요.");
            memail.focus();
            return false;
        }
    }
</script>
</head>
<body>

    <div class="popup-card">
        <h3 class="popup-title">이메일 중복 확인</h3>

        <form name="emailCheck" method="post" action="/guest/emailCheck">
            <div class="input-group">
                <input type="text" name="memail" value="${memail}" placeholder="이메일을 입력하세요" required autocomplete="off">
                <button type="submit" class="btn-check" onclick="return check()">중복확인</button>
            </div>
        </form>

        <c:if test="${checked}">
            <c:choose>
                <%-- Case 1: 이미 존재하는 아이디일 때 --%>
                <c:when test="${isDuplicated}">
                    <div class="result-box danger">
                        <strong>"${memail}"</strong><br>이미 사용 중인 이메일입니다.
                    </div>
                </c:when>
                        
                <%-- Case 2: 사용 가능할 때 --%>
                <c:otherwise>
                    <div class="result-box success">
                        <strong>"${memail}"</strong><br>사용 가능한 이메일입니다.
                        <button type="button" class="btn-use" onclick="useEmail()">이메일 사용하기</button>
                    </div>
                </c:otherwise>
            </c:choose>
        </c:if>
    </div>

</body>
</html>
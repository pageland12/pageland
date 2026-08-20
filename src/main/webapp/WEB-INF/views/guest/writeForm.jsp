<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 - 페이지랜드</title>
<link rel="stylesheet" href="/css/memberWriteForm.css">
<script src="/js/memberWrite.js" language="javascript"></script>
</head>
<body>
	<%@ include file="header.jsp" %>
	<main class="main-content">
	    <div class="form-card">
	        <h2 class="form-title">회원가입</h2>
	
	        <form name="member" method="post" action="/guest/write">
	            
	            <div class="form-group">
	                <label>이메일</label>
	                <div class="input-row">
	                    <input type="text" name="memail" readonly placeholder="중복 검사를 진행해주세요.">
	                    <input type="button" value="중복 검사" class="btn-sub" onclick="goEmailCheck()">
	                </div>
	            </div>
	
	            <div class="form-group">
	                <label>비밀번호</label>
	                <input type="password" name="mpasswd" placeholder="비밀번호를 입력하세요">
	            </div>
	
	            <div class="form-group">
	                <label>비밀번호 확인</label>
	                <input type="password" name="mpasswd2" placeholder="비밀번호를 다시 입력하세요">
	            </div>
	
	            <div class="form-group">
	                <label>이름</label>
	                <input type="text" name="mname" placeholder="이름을 입력하세요">
	            </div>
	
	            <div class="form-group">
	                <label>주소</label>
	                <div class="input-row" style="margin-bottom: 8px;">
	                    <input type="text" name="mzipno" placeholder="우편번호" readonly>
	                    <input type="button" value="주소검색" class="btn-sub" onclick="goPopup();">
	                </div>
	                <input type="text" name="maddr1" placeholder="기본주소" readonly style="margin-bottom: 8px;">
	                <input type="text" name="maddr2" placeholder="상세주소 입력" readonly>
	            </div>
	
	            <div class="form-group">
	                <label>연락처</label>
	                <div class="tel-group">
	                    <input type="text" name="mtel1" maxlength="3">
	                    <span>-</span>
	                    <input type="text" name="mtel2" maxlength="4">
	                    <span>-</span>
	                    <input type="text" name="mtel3" maxlength="4">
	                </div>
	            </div>
	
	            <div class="form-group" style="margin-top: 25px; padding-top: 15px; border-top: 1px solid #f0f0f0;">
	                <label>예금주</label>
	                <input type="text" name="maccount1" placeholder="예금주명">
	            </div>
	
	            <div class="form-group">
	                <label>은행명</label>
	                <select name="maccount2">
	                    <option value="">----- 은행 선택 -----</option>
	                    <option value="KB국민은행">KB국민은행</option>
	                    <option value="NH농협은행">NH농협은행</option>
	                    <option value="우리은행">우리은행</option>
	                    <option value="BNK부산은행">BNK부산은행</option>
	                    <option value="카카오뱅크">카카오뱅크</option>
	                    <option value="토스뱅크">토스뱅크</option>
	                </select>
	            </div>
	
	            <div class="form-group">
	                <label>계좌번호</label>
	                <input type="text" name="maccount3" placeholder="숫자 및 하이픈(-) 포함 9 ~ 18자리">
	            </div>
	
	            <div class="btn-wrap">
	                <input type="submit" value="회원가입" class="btn-submit" onclick="return check()">
	                <input type="button" value="취소" class="btn-cancel" onclick="history.back()">
	            </div>
	
	        </form>
	    </div>
    </main>
	<%@ include file="footer.jsp" %>
</body>
</html>
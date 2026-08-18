<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이메일 중복 검사</title>
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
	<h3>이메일 중복 확인</h3>
	<form name="emailCheck" method="post" action="/guest/emailCheck">
		<input type="text" name="memail" value="${memail}" placeholder="이메일을 입력하세요" required autocomplete="off">
		<button type="submit" onclick="return check()">중복확인</button>
	</form>
	<c:if test="${checked}">
	    <hr>
	    <c:choose>
		    <%-- Case 1: 이미 존재하는 아이디일 때 --%>
		    <c:when test="${isDuplicated}">
			    <strong>"${memail}"</strong> 은(는)<br>이미 사용 중인 이메일입니다.
	    	</c:when>
	                
		    <%-- Case 2: 사용 가능할 때 --%>
		    <c:otherwise>
			    <strong>"${memail}"</strong> 은(는)<br>사용 가능한 이메일입니다. <br>
			    <button type="button" onclick="useEmail()">이메일 사용하기</button>
		    </c:otherwise>
	    </c:choose>
    </c:if>
</body>
</html>
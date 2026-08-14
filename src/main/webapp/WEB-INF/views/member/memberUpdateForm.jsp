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
<title>회원가입</title>
</head>
<script language="javascript">
	function goPopup(){	
		var pop = window.open("/guest/jusoPopup","pop","width=570,height=420, scrollbars=yes, resizable=yes"); 		    
	}

	function jusoCallBack(maddr1,maddr2,mzipno){
		document.memberUpdate.maddr1.value = maddr1;
		document.memberUpdate.maddr2.value = maddr2;
		document.memberUpdate.mzipno.value = mzipno;		
		
	}
</script>
<body>
	<form name="memberUpdate" method="post" action="/member/memberUpdate">
		<input type="hidden" name="mno" value="${update.mno}">
		<h2>회원수정</h2>
		<table>
			<tr>
				<td>이메일</td>
				<td><input type="text" name="memail" readonly value="${update.memail}"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="mname" value="${update.mname}"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="maddr1" readonly value="${maddrArray[0]}"><input type="button" value="주소검색" onclick="goPopup();"></td>
			</tr>
			<tr>
				<td>상세주소</td>
				<td><input type="text" name="maddr2" readonly value="${maddrArray[1]}"></td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td><input type="text" name="mzipno" readonly value="${maddrArray[2]}"></td>
			</tr>
			<tr>
				<td>연락처</td>
				<td>
					<input type="text" name="mtel1" size="3" maxlength="3" value="${mtelArray[0]}"> -
					<input type="text" name="mtel2" size="4" maxlength="4" value="${mtelArray[1]}"> -
					<input type="text" name="mtel3" size="4" maxlength="4" value="${mtelArray[2]}">
				</td>
			</tr>
			<tr>
				<td>예금주</td>
				<td><input type="text" name="maccount1" value="${maccountArray[0]}"></td>
			</tr>
			<tr>
				<td>은행명</td>
				<td>
					<select name="maccount2">
						<option value="">----- 은행 선택 -----</option>
						<option value="KB국민은행" ${maccountArray[1] == 'KB국민은행' ? 'selected' : ''}>KB국민은행</option>
						<option value="NH농협은행" ${maccountArray[1] == 'NH농협은행' ? 'selected' : ''}>NH농협은행</option>
						<option value="우리은행" ${maccountArray[1] == '우리은행' ? 'selected' : ''}>우리은행</option>
						<option value="BNK부산은행" ${maccountArray[1] == 'BNK부산은행' ? 'selected' : ''}>BNK부산은행</option>
						<option value="카카오뱅크" ${maccountArray[1] == '카카오뱅크' ? 'selected' : ''}>카카오뱅크</option>
						<option value="토스뱅크" ${maccountArray[1] == '토스뱅크' ? 'selected' : ''}>토스뱅크</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>계좌번호</td>
				<td><input type="text" name="maccount3" value="${maccountArray[2]}"></td>
			</tr>
		</table>
		<input type="submit" value="수정">
	</form>
</body>
</html>
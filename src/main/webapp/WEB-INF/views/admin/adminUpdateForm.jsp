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
<title>Insert title here</title>
</head>
<body>
	<form name="adminUpdate" method="post" action="/admin/adminUpdate">
		<input type="hidden" name="mno" value="${update.mno}">
		<h2>회원수정</h2>
		<table border="1" width="700">
		<tr>
			<td>회원번호</td>
			<td>${update.mno}</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${update.memail}</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>${update.mpasswd}</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>${update.mname}</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>${update.maddr}</td>
		</tr>
		<tr>
			<td>연락처</td>
			<td>${update.mtel}</td>
		</tr>
		<tr>
			<td>계좌정보</td>
			<td>${update.maccount}</td>
		</tr>
		<tr>
			<td>등급</td>
			<td>
				<select name="mgrade" required>
					<option value="">----- 등급 선택 -----</option>
					<option value="NORMAL" ${update.mgrade == 'NORMAL' ? 'selected' : ''}>NORMAL</option>
					<option value="SUBSCRIBER" ${update.mgrade == 'SUBSCRIBER' ? 'selected' : ''}>SUBSCRIBER</option>
					<option value="INACTIVE" ${update.mgrade == 'INACTIVE' ? 'selected' : ''}>INACTIVE</option>
					<option value="ADMIN" ${update.mgrade == 'ADMIN' ? 'selected' : ''}>ADMIN</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>생성일</td>
			<td>${update.mdate}</td>
		</tr>
		<tr>
			<td>포인트</td>
			<td><input type="text" name="mpoint" value="${update.mpoint}"></td>
		</tr>
	</table>
		<input type="submit" value="수정">
		<input type="button" value="취소" onclick="history.back()">
	</form>
</body>
</html>
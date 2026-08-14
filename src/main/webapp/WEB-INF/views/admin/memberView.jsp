<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 상세보기</title>
</head>
<body>
	<table border="1" width="700">
		<tr>
			<td>회원번호</td>
			<td>${view.mno}</td>
		</tr>
		<tr>
			<td>이메일</td>
			<td>${view.memail}</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>${view.mpasswd}</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>${view.mname}</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>${view.maddr}</td>
		</tr>
		<tr>
			<td>연락처</td>
			<td>${view.mtel}</td>
		</tr>
		<tr>
			<td>계좌정보</td>
			<td>${view.maccount}</td>
		</tr>
		<tr>
			<td>등급</td>
			<td>${view.mgrade}</td>
		</tr>
		<tr>
			<td>생성일</td>
			<td>${view.mdate}</td>
		</tr>
		<tr>
			<td>포인트</td>
			<td>${view.mpoint}</td>
		</tr>
	</table>
	<a href="/admin/passwordCheckForm?mode=update&mno=${view.mno}">회원수정</a>
	<a href="/admin/passwordCheckForm?mode=delete&mno=${view.mno}">탈퇴</a>
	<a href="/admin/memberList">목록으로 돌아가기</a>
</body>
</html>
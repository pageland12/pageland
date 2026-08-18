<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>등록 구독권 상세</title>
</head>
<body>
	<table border=1 width=400>
		<tr>
			<td>구독권 이름</td>
			<td>${pass.pname}</td>
		</tr>
		<tr>
			<td>구독권 유형</td>
			<td>${pass.ptype}</td>
		</tr>
		<tr>
			<td>구독권 이미지</td>
			<td><img src="${pass.pimg}" width=100 alt=구독권 이미지></td>
		</tr>
		<tr>
			<td>상세 정보</td>
			<td><img src="${pass.pinfo}" width=100 alt=구독권 상세정보></td>
		</tr>		
		<tr>
			<td>구독권 기간</td>
			<td>${pass.pperiod}</td>
		</tr>
		<tr>
			<td>N회권 개수</td>
			<td>${pass.pcount}</td>
		</tr>
		<tr>
			<td>N회권 가격</td>
			<td>${pass.pprice}</td>
		</tr>
	</table>
	<a href="/admin/passUpdateForm?pno=${pass.pno}">수정</a>
	<a href="/admin/passDelete?pno=${pass.pno}">삭제</a>
	<a href="/admin/adminMain">관리자페이지로 이동</a>
</body>
</html>
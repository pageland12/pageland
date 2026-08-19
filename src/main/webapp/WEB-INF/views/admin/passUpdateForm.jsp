<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독권 수정</title>
</head>
<script src="/js/passUpdate.js"></script>
<body>
	<form name="passUpdateForm" method="post" action="/admin/passUpdate">
	<input type="hidden" name="pno" value="${update.pno}">
		<table border=1 width=400>
			<tr>
				<td>구독권 이름</td>
				<td><input type="text" name="pname" value="${update.pname}"></td>
			</tr>
			<tr>
	            <td>구독권 종류</td>
	            <td>
	                <select name="ptype">
	                    <option value="">선택</option>
	                    <option value="정기권" ${update.ptype == '정기권' ? 'selected' : ''}>정기권</option>
	                    <option value="N회권" ${update.ptype == 'N회권' ? 'selected' : ''}>N회권</option>
	                </select>
	            </td>
	        </tr>
			<tr>
				<td>구독권 이미지</td>
				<td><input type="text" name="pimg" value="${update.pimg}"></td>
			</tr>
			<tr>
				<td>상세 정보</td>
				<td><input type="text" name="pinfo" value="${update.pinfo}"></td>
			</tr>
			<tr>
				<td>구독권 가격</td>
				<td><input type="text" name="pprice" value="${update.pprice}"></td>
			</tr>						
			<tr>
				<td>구독권 기간</td>
				<td><input type="text" name="pperiod" value="${update.pperiod}"></td>
			</tr>
			<tr>
				<td>구독권 횟수(N회권)</td>
				<td><input type="text" name="pcount" value="${update.pcount}"></td>
			</tr>			
		</table>
		<input type="submit" value="수정" onclick="return check()">
		<a href="/admin/adminMain">관리자페이지로 이동</a>
	</form>
</body>
</html>
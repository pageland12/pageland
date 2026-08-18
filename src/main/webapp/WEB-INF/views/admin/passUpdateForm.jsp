<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독권 수정</title>
</head>
<script>
function check() {
	let pname = document.passUpdateForm.pname;
	let ptype = document.passUpdateForm.ptype;
	let pimg = document.passUpdateForm.pimg;
	let pinfo = document.passUpdateForm.pinfo;
	let pprice = document.passUpdateForm.pprice;
	let pperiod = document.passUpdateForm.pperiod;
	let pcount = document.passUpdateForm.pcount;
	
	let expPname = /^[a-zA-Z0-9가-힣\s?!.,-]+$/;
	let expPprice = /^[0-9]{1,6}$/;
	let expPperiod = /^[0-9]{1,3}$/;
	let expPcount = /^[0-9]{1,3}$/;
	
	// 구독권 이름
	if(!pname.value) {
		alert("구독권 이름을 입력하세요.");
		pname.focus();
		return false;
	}
	
	if(!expPname.test(pname.value) || pname.value.length > 10) {
		alert("구독권 이름을 올바르게(10자 이내) 입력하세요.");
		pname.value = "";
		pname.focus();
		return false;
	}
	
	// 구독권 종류
	if(!ptype.value) {
		alert("구독권 종류를 선택하세요.");
		ptype.focus();
		return false;
	}
	
	// 구독권 이미지
	if(!pimg.value) {
		alert("구독권 이미지 경로를 입력하세요.");
		pimg.focus();
		return false;
	}
	
	// 상세 정보
	if(!pinfo.value) {
		alert("상세 정보를 입력하세요.");
		pinfo.focus();
		return false;
	}
	
	// 구독권 가격
	if(!pprice.value) {
		alert("가격을 입력하세요.");
		pprice.focus();
		return false;
	}
	
	if(!expPprice.test(pprice.value)) {
		alert("가격은 숫자만 최대 6자리 이내로 올바르게 입력하세요.");
		pprice.value = "";
		pprice.focus();
		return false;
	}
	
	// 구독권 기간
	if(pperiod.value && !expPperiod.test(pperiod.value)) {
		alert("기간은 숫자만 최대 3자리 이내로 올바르게 입력하세요.");
		pperiod.value = "";
		pperiod.focus();
		return false;
	}
	
	// 구독권 횟수(N회권)
	if(pcount.value && !expPcount.test(pcount.value)) {
		alert("횟수는 숫자만 최대 3자리 이내로 올바르게 입력하세요.");
		pcount.value = "";
		pcount.focus();
		return false;
	}
	
	return true;
}
</script>
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
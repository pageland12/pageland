<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
		document.member.maddr1.value = maddr1;
		document.member.maddr2.value = maddr2;
		document.member.mzipno.value = mzipno;		
		
	}
</script>
<body>
	<form name="member" method="post" action="/guest/write">
		<h2>회원가입</h2>
		<table>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="memail"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="password" name="mpasswd"></td>
			</tr>
			<tr>
				<td>비밀번호 확인</td>
				<td><input type="password" name="mpasswd2"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="mname"></td>
			</tr>
			<tr>
				<td>주소</td>
				<td><input type="text" name="maddr1" readonly><input type="button" value="주소검색" onclick="goPopup();"></td>
			</tr>
			<tr>
				<td>상세주소</td>
				<td><input type="text" name="maddr2" readonly></td>
			</tr>
			<tr>
				<td>우편번호</td>
				<td><input type="text" name="mzipno" readonly></td>
			</tr>
			<tr>
				<td>연락처</td>
				<td>
					<input type="text" name="mtel1" size="3" maxlength="3"> -
					<input type="text" name="mtel2" size="4" maxlength="4"> -
					<input type="text" name="mtel3" size="4" maxlength="4">
				</td>
			</tr>
			<tr>
				<td>예금주</td>
				<td><input type="text" name="maccount1"></td>
			</tr>
			<tr>
				<td>은행명</td>
				<td>
					<select name="maccount2">
						<option value="">----- 은행 선택 -----</option>
						<option value="KB국민은행">KB국민은행</option>
						<option value="NH농협은행">NH농협은행</option>
						<option value="우리은행">우리은행</option>
						<option value="BNK부산은행">BNK부산은행</option>
						<option value="카카오뱅크">카카오뱅크</option>
						<option value="토스뱅크">토스뱅크</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>계좌번호</td>
				<td><input type="text" name="maccount3"></td>
			</tr>
		</table>
		<input type="submit" value="회원가입">
	</form>
</body>
</html>
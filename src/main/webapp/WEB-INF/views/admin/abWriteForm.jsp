<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 게시판 작성</title>
<script>
function check() {
	let abtitle = document.adminBoard.abtitle;
	
	let expAbtitle = /^[a-zA-Z0-9가-힣\s?!.-]+$/;
	
	if(!abtitle.value) {
		alert("제목을 입력해주세요");
		abtitle.focus();
		return false;
	}
	
	if(!expAbtitle.test(abtitle.value)) {
		alert("제목을 올바르게 입력해주세요.");
		abtitle.value="";
		abtitle.focus();
		return false;
	}
	
	if(abtitle.value.length<2 || abtitle.value.length>15) {
		alert("제목은 2자이상 15자 이하로 입력해주세요.");
	    abtitle.focus();
	    return false;
	}
}
</script>
</head>
<body>
	<h3>관리자 게시판</h3>
	<form method="post" name="adminBoard" action="/admin/abWrite" enctype="multipart/form-data">
		제목 : <input type="text" name="abtitle"> <br>
		카테고리 : <select name="abcategory">
					<option value="NOTICE">공지사항</option>
					<option value="EVENT">이벤트</option>
				 </select> <br>
		첨부파일 : <input type="file" name="abupload"> <br>
		내용 : <textarea name="abcontent" rows="4" cols="50"></textarea> <br>
		<input type="submit" value="등록" onclick="return check()">
		<input type="reset" value="초기화" onclick="history.back()">
	</form>
</body>
</html>
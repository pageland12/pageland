<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 게시판 수정</title>
<script src="/js/abWrite.js"></script>
</head>
<body>
	<h3>관리자 게시판 수정</h3>
	<form method="post" name="adminBoard" action="/admin/abUpdate" enctype="multipart/form-data">
		<input type="hidden" name="abno" value="${update.abno}">
		제목 : <input type="text" name="abtitle" value="${update.abtitle}"> <br>
		카테고리 : <select name="abcategory" value="${update.abcategory}">
					<option value="NOTICE" ${update.abcategory.indexOf('NOTICE')>-1?'selected':''}>공지사항</option>
					<option value="EVENT" ${update.abcategory.indexOf('EVENT')>-1?'selected':''}>이벤트</option>
				 </select> <br>
		첨부파일 : <input type="file" name="abupload"> <br>
		내용 : <textarea name="abcontent" rows="4" cols="50">${update.abcontent}</textarea> <br>
		<input type="submit" value="등록" onclick="return check()">
		<input type="reset" value="취소" onclick="history.back()">
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 게시판 작성</title>
<script src="/js/abWrite.js"></script>
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
		<input type="reset" value="취소" onclick="history.back()">
	</form>
</body>
</html>
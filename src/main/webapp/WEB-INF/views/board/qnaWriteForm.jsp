<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 작성</title>
<script src="/js/qnaWrite.js"></script>
</head>
<body>
	<h3>Q&A</h3>
	<form name="qna" method="post" action="/board/qnaWrite" enctype="multipart/form-data">
		제목 : <input type="text" name="qtitle"><br>
		첨부파일 : <input type="file" name="qupload"><br>
		내용 : <textarea name="qcontent" placeholder="내용을 입력해주세요" cols="50" rows="4"></textarea><br>
		게시글 비밀번호 : <input type="password" name="qpasswd"><br>
		비밀글 설정 : 공개글 <input type="radio" name="qsecret" value="공개글">
					비밀글 <input type="radio" name="qsecret" value="비밀글" checked><br>
		<input type="submit" value="등록" onclick="return check()">
		<input type="reset" value="취소" onclick="history.back()">
	</form>
</body>
</html>
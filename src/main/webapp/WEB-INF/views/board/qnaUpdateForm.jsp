<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 수정</title>
</head>
<body>
	<h3>QnA 수정</h3>
	<form name="qna" method="post" action="/board/qnaUpdate" enctype="multipart/form-data">
		<input type="hidden" name="qno" value="${update.qno}">
		제목 : <input type="text" name="qtitle" value="${update.qtitle}"><br>
		첨부파일 : <input type="file" name="qupload"><br>
		내용 : <textarea name="qcontent" placeholder="내용을 입력해주세요" cols="50", rows="4">${update.qcontent}</textarea><br>
		비밀번호 : <input type="password" name="qpasswd"><br>
		비밀글 설정 : 공개글 <input type="radio" name="qsecret" value="공개글">
					비밀글 <input type="radio" name="qsecret" value="비밀글" checked><br>
		<input type="submit" value="등록">
		<input type="reset" value="초기화">
	</form>
</body>
</html>
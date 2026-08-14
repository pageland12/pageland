<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>QnA 작성</title>
<script>
function check() {
	let qtitle = document.qna.qtitle;
	let qcontent = document.qna.qcontent;
	let qpasswd = document.qna.qpasswd;
	
	let expQtitle = /^[a-zA-Z0-9가-힣\s?!.-]+$/;
	let expQpasswd = /^[a-zA-Z0-9!@#$%^&*?]{4,15}$/;
	
	if(!qtitle.value) {
		alert("제목을 입력해주세요");
		qtitle.focus();
		return false;
	}
	
	if(!expQtitle.test(qtitle.value)) {
		alert("제목을 올바르게 입력해주세요.");
		qtitle.value="";
		qtitle.focus();
		return false;
	}
	
	if(qtitle.value.length<2 || qtitle.value.length>15) {
		alert("제목은 2자이상 15자 이하로 입력해주세요.");
	    qtitle.focus();
	    return false;
	}
	
	if(!qcontent.value) {
		alert("내용을 입력해주세요");
		qcontent.focus();
		return false;
	}
	
	if(qcontent.value.length<2 || qcontent.value.length>100) {
		alert("내용은 2자 이상 100자 이하로 작성해 주세요.");
	    qcontent.focus();
	    return false;
	}
	
	if(!qpasswd.value) {
		alert("비밀번호를 입력해주세요");
		qpasswd.focus();
		return false;
	}
	
	if(!expQpasswd.test(qpasswd.value)) {
			alert("비밀번호는 영문 대,소문자와 숫자, 특수기호(!@#$%^&*?)의 조합 4~15자만 가능합니다");
			qpasswd.value="";
			qpasswd.focus();
			return false;
	}
	
}
</script>
</head>
<body>
	<h3>Q&A</h3>
	<form name="qna" method="post" action="/board/qnaWrite" enctype="multipart/form-data">
		제목 : <input type="text" name="qtitle"><br>
		첨부파일 : <input type="file" name="qupload"><br>
		내용 : <textarea name="qcontent" placeholder="내용을 입력해주세요" cols="50", rows="4"></textarea><br>
		게시글 비밀번호 : <input type="password" name="qpasswd"><br>
		비밀글 설정 : 공개글 <input type="radio" name="qsecret" value="공개글">
					비밀글 <input type="radio" name="qsecret" value="비밀글" checked><br>
		<input type="submit" value="등록" onclick="return check()">
		<input type="reset" value="초기화" onclick="history.back()">
	</form>
</body>
</html>
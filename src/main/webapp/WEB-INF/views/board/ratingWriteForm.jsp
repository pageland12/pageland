<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 작성</title>
<script>
function check() {
	let rtitle = document.rating.rtitle;
	
	let expRtitle = /^[a-zA-Z0-9가-힣\s?!.-]+$/;
	
	if(!rtitle.value) {
		alert("제목을 입력해주세요");
		rtitle.focus();
		return false;
	}
	
	if(!expRtitle.test(rtitle.value)) {
		alert("제목에 사용할 수 없는 특수문자가 포함되어 있습니다.");
		rtitle.focus();
		return false;
	}
	
	if(rtitle.value.length<2 || rtitle.value.length>15) {
		alert("제목은 2자이상 15자 이하로 입력해주세요.");
	    rtitle.focus();
	    return false;
	}
}
</script>
</head>
<body>
	<h3>구매 도서 후기 작성</h3>
	주문 상세 번호: ${rating.odno} <br>
	도서이미지 : <c:if test="${not empty rating.bimg}">
				<img src="${rating.bimg}" width="300" height="300">
			  </c:if> <br>
 	도서명 : ${rating.bname} <br>
    
    <form  method="post" name="rating" action="/board/ratingWrite" enctype="multipart/form-data">
        <input type="hidden" name="bno" value="${rating.bno}">
        <input type="hidden" name="odno" value="${rating.odno}">
        제목 : <input type="text" name="rtitle"> <br>
        평점 : <select name="rrate">
			    <option value="5.0">★★★★★</option>
			    <option value="4.0">★★★★☆</option>
			    <option value="3.0">★★★☆☆</option>
			    <option value="2.0">★★☆☆☆</option>
			    <option value="1.0">★☆☆☆☆</option>
        	</select> <br>
        첨부파일 : <input type="file" name="rupload"> <br>
		내용 : <textarea name="rcontent" cols="50" rows="4"></textarea> <br>
		<input type="submit" value="등록" onclick="return check()">
		<input type="reset" value="취소" onclick="history.back()">
    </form>
</body>
</html>
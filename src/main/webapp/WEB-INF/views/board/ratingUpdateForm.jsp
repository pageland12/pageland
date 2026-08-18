<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>후기 수정</title>
<script src="/js/ratingWrite.js"></script>
</head>
<body>
	<h3>도서 대여 후기 수정</h3>
	주문 상세 번호: ${update.odno} <br>
	도서이미지 : <c:if test="${not empty update.bimg}">
				<img src="${update.bimg}" width="300" height="300">
			  </c:if> <br>
 	도서명 : ${update.bname} <br>
    
    <form  method="post" name="rating" action="/board/ratingUpdate" enctype="multipart/form-data">
        <input type="hidden" name="rno" value="${update.rno}">
        <input type="hidden" name="bno" value="${update.bno}">
        <input type="hidden" name="odno" value="${update.odno}">
        제목 : <input type="text" name="rtitle" value="${update.rtitle}"> <br>
        평점 : <select name="rrate">
			    <option value="5.0" ${update.rrate == 5.0 ? 'selected' : ''}>★★★★★</option>
			    <option value="4.0" ${update.rrate == 4.0 ? 'selected' : ''}>★★★★☆</option>
			    <option value="3.0" ${update.rrate == 3.0 ? 'selected' : ''}>★★★☆☆</option>
			    <option value="2.0" ${update.rrate == 2.0 ? 'selected' : ''}>★★☆☆☆</option>
			    <option value="1.0" ${update.rrate == 1.0 ? 'selected' : ''}>★☆☆☆☆</option>
        	</select> <br>
        첨부파일 : <input type="file" name="rupload"> <br>
		내용 : <textarea name="rcontent" cols="50" rows="4">${update.rcontent}</textarea> <br>
		<input type="submit" value="등록" onclick="return check()">
		<input type="reset" value="취소" onclick="history.back()">
    </form>
</body>
</html>
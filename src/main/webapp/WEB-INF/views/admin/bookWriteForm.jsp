<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 등록</title>
</head>
<script src="/js/bookWrite.js"></script>
<body>
	<form name="bookWriteForm" method="post" action="/admin/bookWrite">
	    <table>
	        <tr>
	            <td>제목</td>
	            <td><input type="text" name="bname" placeholder="도서명을 입력하세요"></td>
	        </tr>
	        <tr>
	            <td>연령</td>
	            <td>
	                <select name="bage">
	                    <option value="">선택</option>
	                    <option value="0-3세">0-3세</option>
	                    <option value="4-7세">4-7세</option>
	                    <option value="초등 저학년">초등 저학년</option>
	                    <option value="초등 고학년">초등 고학년</option>
	                </select>
	            </td>
	        </tr>
	        <tr>
	            <td>분야</td>
	            <td>
	                <select name="bgenre">
	                    <option value="">선택</option>
	                    <option value="생활/창작">생활/창작</option>
	                    <option value="전래/명작">전래/명작</option>
	                    <option value="수학/영어">수학/영어</option>
	                    <option value="자연/과학">자연/과학</option>
	                </select>
	            </td>
	        <tr>
	            <td>출판사</td>
	            <td><input type="text" name="bpublisher" placeholder="출판사명"></td>
	        </tr>
	        <tr>
	            <td>책 이미지</td>
	            <td><input type="text" name="bimg" placeholder="도서 이미지 URL"></td>
	        </tr>
	        <tr>
	            <td>세부 정보</td>
	            <td><input type="text" name="binfo" placeholder="도서 정보 이미지 URL"></td>
	        </tr>
	        <tr>
	            <td>가격</td>
	            <td><input type="text" name="bprice" placeholder="정상 대여가(15일)"></td>
	        </tr>
	        <tr>
	            <td>재고 수량</td>
	            <td><input type="text" name="bstock" placeholder="최초 입고량"></td>
	        </tr>
	    </table>
	    
	    <div>
		    <input type="submit" value="등록하기" onclick="return check()">
		    <a href="/admin/adminMain">관리자페이지로 이동</a>
		</div>
	</form>
</body>
</html>
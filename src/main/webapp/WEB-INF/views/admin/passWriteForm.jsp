<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독권 등록</title>
</head>
<script src="/js/passWrite.js"></script>
<body>
	<form name="passWriteForm" method="post" action="/admin/passWrite">
	    <table border=1 width=400>
	        <tr>
	            <td>구독권 이름</td>
	            <td><input type="text" name="pname" placeholder="구독권을 입력하세요"></td>
	        </tr>
	        <tr>
	            <td>구독권 종류</td>
	            <td>
	                <select name="ptype">
	                    <option value="">선택</option>
	                    <option value="정기권">정기권</option>
	                    <option value="N회권">N회권</option>
	                </select>
	            </td>
	        </tr>
	        <tr>
	            <td>구독권 이미지</td>
	            <td><input type="text" name="pimg" placeholder="구독권 이미지 URL"></td>
	        </tr>
	        <tr>
	            <td>상세 정보</td>	            
	            <td><input type="text" name="pinfo" placeholder="구독권 정보 이미지 URL"></td>
	        </tr>
	        <tr>
	            <td>구독권 가격</td>
	            <td><input type="text" name="pprice" placeholder="구독권 가격"></td>
	        </tr>
	        <tr>
	        	<td>구독권 기간</td>
	            <td><input type="text" name="pperiod" placeholder="구독권 기간(정기권)"></td>
	        </tr>
	        <tr>
	        	<td>구독권 횟수</td>
	            <td><input type="text" name="pcount" placeholder="구독권 횟수(N회권)"></td>
	        </tr>
	    </table>
	    
	    <div>
		    <input type="submit" value="등록하기" onclick="return check()">
		    <a href="/admin/adminMain">관리자페이지로 이동</a>
		</div>
	</form>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>도서 등록</title>
</head>
<script>
function check() {
	let bname = document.bookWriteForm.bname;
	let bage = document.bookWriteForm.bage;
	let bgenre = document.bookWriteForm.bgenre;
	let bpublisher = document.bookWriteForm.bpublisher;
	let bimg = document.bookWriteForm.bimg;
	let binfo = document.bookWriteForm.binfo;
	let bprice = document.bookWriteForm.bprice;
	let bstock = document.bookWriteForm.bstock;
	
	let expBname = /^[a-zA-Z0-9가-힣\s?!.,-]+$/;
	let expBpublisher = /^[a-zA-Z0-9가-힣\s]+$/;
	let expBprice = /^[0-9]{1,6}$/;
	let expBstock = /^[0-9]{1,5}$/;
	
	// 도서 제목
	if(!bname.value) {
		alert("도서 제목을 입력하세요.");
		bname.focus();
		return false;
	}
	
	if(!expBname.test(bname.value) || bname.value.length > 300) {
        alert("도서 제목을 올바르게(300자 이내) 입력해주세요.");
        bname.value = "";
        bname.focus();
        return false;
    }
	
	// 연령
	if(!bage.value) {
		alert("연령을 선택하세요.");
		return false;
	}
	
	// 분야
	if(!bgenre.value) {
		alert("분야를 선택하세요.");
		return false;
	}
	
	// 출판사
	if(!bpublisher.value) {
		alert("출판사를 입력하세요.")
		bpublisher.focus();
		return false;
	}
	
	if(!expBpublisher.test(bpublisher.value) || bpublisher.value.length > 6) {
        alert("출판사명은 한글/영문/숫자로 올바르게(6자 이내) 입력하세요.");
        bpublisher.value = "";
        bpublisher.focus();
        return false;
    }
	
	// 이미지
	if(!bimg.value) {
        alert("책 이미지 경로를 입력하세요.");
        bimg.focus();
        return false;
    }
	
	// 상세 정보
	if(!binfo.value) {
        alert("세부 정보 이미지 경로를 입력하세요.");
        binfo.focus();
        return false;
    }
	
	// 가격
	if(!bprice.value) {
		alert("가격을 입력하세요.")
		bprice.focus();
		return false;
	}
	
	if(!expBprice.test(bprice.value)) {
        alert("가격은 숫자만 최대 6자리 이내로 올바르게 입력해주세요.");
        bprice.value = "";
        bprice.focus();
        return false;
    }
	
	// 재고 수량
	if(!bstock.value) {
		alert("재고 수량을 입력하세요.")
		bstock.focus();
		return false;
	}
	
	if(!expBstock.test(bstock.value)) {
        alert("재고 수량은 숫자만 최대 5자리 이내로 올바르게 입력하세요.");
        bstock.value = "";
        bstock.focus();
        return false;
	}
	
	return true;
}
</script>
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
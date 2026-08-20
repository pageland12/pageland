function check() {
	let bname = document.bookUpdateForm.bname;
	let bage = document.bookUpdateForm.bage;
	let bgenre = document.bookUpdateForm.bgenre;
	let bpublisher = document.bookUpdateForm.bpublisher;
	let bimg = document.bookUpdateForm.bimg;
	let binfo = document.bookUpdateForm.binfo;
	let bprice = document.bookUpdateForm.bprice;
	let bstock = document.bookUpdateForm.bstock;
	
	let expBname = /^[a-zA-Z0-9가-힣\s?!.,\[\]⌛⏳~\-]+$/;
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
}
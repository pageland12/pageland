function check() {
	let pname = document.passUpdateForm.pname;
	let ptype = document.passUpdateForm.ptype;
	let pimg = document.passUpdateForm.pimg;
	let pinfo = document.passUpdateForm.pinfo;
	let pprice = document.passUpdateForm.pprice;
	let pperiod = document.passUpdateForm.pperiod;
	let pcount = document.passUpdateForm.pcount;
	
	let expPname = /^[a-zA-Z0-9가-힣\s?!.,-]+$/;
	let expPprice = /^[0-9]{1,6}$/;
	let expPperiod = /^[0-9]{1,3}$/;
	let expPcount = /^[0-9]{1,3}$/;
	
	// 구독권 이름
	if(!pname.value) {
		alert("구독권 이름을 입력하세요.");
		pname.focus();
		return false;
	}
	
	if(!expPname.test(pname.value) || pname.value.length > 10) {
		alert("구독권 이름을 올바르게(10자 이내) 입력하세요.");
		pname.value = "";
		pname.focus();
		return false;
	}
	
	// 구독권 종류
	if(!ptype.value) {
		alert("구독권 종류를 선택하세요.");
		ptype.focus();
		return false;
	}
	
	// 구독권 이미지
	if(!pimg.value) {
		alert("구독권 이미지 경로를 입력하세요.");
		pimg.focus();
		return false;
	}
	
	// 상세 정보
	if(!pinfo.value) {
		alert("상세 정보를 입력하세요.");
		pinfo.focus();
		return false;
	}
	
	// 구독권 가격
	if(!pprice.value) {
		alert("가격을 입력하세요.");
		pprice.focus();
		return false;
	}
	
	if(!expPprice.test(pprice.value)) {
		alert("가격은 숫자만 최대 6자리 이내로 올바르게 입력하세요.");
		pprice.value = "";
		pprice.focus();
		return false;
	}
	
	// 정기권 선택 시
	if (ptype.value == "정기권") {
		// N회권 횟수 비활성화 및 초기화
		pcount.disabled = true;
		pcount.value = "";
		pperiod.disabled = false;
	
		if (!pperiod.value) {
			alert("기간을 입력하세요.");
			pperiod.focus();
			return false;
		}
		
		if (!expPperiod.test(pperiod.value)) {
			alert("기간은 숫자만 최대 3자리 이내로 올바르게 입력하세요.");
			pperiod.value = "";
			pperiod.focus();
			return false;
		}
	}
	
	// N회권 선택 시
	if (ptype.value == "N회권") {
		// 정기권 기간 비활성화 및 초기화
		pperiod.disabled = true;
		pperiod.value = "";
		pcount.disabled = false;
	
		if (!pcount.value) {
			alert("횟수를 입력하세요.");
			pcount.focus();
			return false;
		}
		
		if (!expPcount.test(pcount.value)) {
			alert("횟수는 숫자만 최대 3자리 이내로 올바르게 입력하세요.");
			pcount.value = "";
			pcount.focus();
			return false;
		}
	}
	
	return true;
}

function handleTypeChange() {
	let ptype = document.passUpdateForm.ptype.value;
	let pperiod = document.passUpdateForm.pperiod;
	let pcount = document.passUpdateForm.pcount;

	if (ptype === "정기권") {
		pperiod.disabled = false;
		pcount.disabled = true;
		pcount.value = ""; // 기존 입력값 비우기
	} else if (ptype === "N회권") {
		pcount.disabled = false;
		pperiod.disabled = true;
		pperiod.value = ""; // 기존 입력값 비우기
	} else {
		// 미선택 상태
		pperiod.disabled = false;
		pcount.disabled = false;
	}
}
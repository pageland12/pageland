function check() {
	let mgrade = document.adminUpdate.mgrade;
	let mpoint = document.adminUpdate.mpoint;
	
	let expMpoint = /^[0-9]+$/;
	
	// 회원 등급
	if(!mgrade.value) {
		alert("회원 등급을 선택하세요.");
		return false;
	}
	
	
	// 회원 포인트
	if(!mpoint.value) {
		alert("회원 포인트를 입력하세요.");
		return false;
	}
	
	if(!expMpoint.test(mpoint.value) || mpoint.value.length > 6) {
        alert("회원 포인트를 올바르게(6자 이내 숫자로만) 입력해주세요.");
        mpoint.value = "";
        mpoint.focus();
        return false;
    }
	
	return true;
}
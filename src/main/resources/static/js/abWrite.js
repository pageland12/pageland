function check() {
	let abtitle = document.adminBoard.abtitle;
	
	let expAbtitle = /^[a-zA-Z0-9가-힣\s?!.,~*'"()\[\]&-]+$/;
	
	if(!abtitle.value) {
		alert("제목을 입력해주세요");
		abtitle.focus();
		return false;
	}
	
	if(!expAbtitle.test(abtitle.value)) {
		alert("제목을 올바르게 입력해주세요.");
		abtitle.value="";
		abtitle.focus();
		return false;
	}
	
	if(abtitle.value.length<2 || abtitle.value.length>15) {
		alert("제목은 2자이상 15자 이하로 입력해주세요.");
	    abtitle.focus();
	    return false;
	}
}
function check() {
	let rtitle = document.rating.rtitle;
	
	let expRtitle = /^[a-zA-Z0-9가-힣\s?!.,*~'"()\[\]&-]+$/;
	
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
function check() {
	let qtitle = document.qna.qtitle;
	let qcontent = document.qna.qcontent;
	let qpasswd = document.qna.qpasswd;
	
	let expQtitle = /^[a-zA-Z0-9가-힣\s?!.*&-]+$/;
	let expQpasswd = /^[a-zA-Z0-9!@#$%^&*?]{4,15}$/;
	
	if(!qtitle.value) {
		alert("제목을 입력해주세요");
		qtitle.focus();
		return false;
	}
	
	if(!expQtitle.test(qtitle.value)) {
		alert("제목을 올바르게 입력해주세요.");
		qtitle.value="";
		qtitle.focus();
		return false;
	}
	
	if(qtitle.value.length<2 || qtitle.value.length>15) {
		alert("제목은 2자이상 15자 이하로 입력해주세요.");
	    qtitle.focus();
	    return false;
	}
	
	if(!qcontent.value) {
		alert("내용을 입력해주세요");
		qcontent.focus();
		return false;
	}
	
	if(qcontent.value.length<2 || qcontent.value.length>300) {
		alert("내용은 2자 이상 300자 이하로 작성해 주세요.");
	    qcontent.focus();
	    return false;
	}
	
	if(!qpasswd.value) {
		alert("비밀번호를 입력해주세요");
		qpasswd.focus();
		return false;
	}
	
	if(!expQpasswd.test(qpasswd.value)) {
			alert("비밀번호는 영문 대,소문자와 숫자, 특수기호(!@#$%^&*?)의 조합과\n 4~15자만 가능합니다");
			qpasswd.value="";
			qpasswd.focus();
			return false;
	}
	
}
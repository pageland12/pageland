function hidePopupForDay() {
    /* 쿠키가 존재할 시간: 1분 */
    const maxAge = 60;
    
    /* 쿠키 굽기 규격 설정 (path=/ 를 지정해야 사이트 전역에서 인식합니다)
    자바스크립트에서 쿠키 설정: 키=값;속성1=값;속성2=값...
    max-age="" -> setMaxAge()
    path=/ -> setPath("/"), 해당 jsp파일이 guest하위이므로 해당 쿠키를 전역으로 뿌리기 위함 */
    const cookieString = "hideCoupon=true; max-age=" + maxAge + "; path=/";
    
    if (window.opener) {
    	// 팝업창을 열어준 부모 창(메인페이지)에 쿠키를 저장
        window.opener.document.cookie = cookieString;
    }
    
    window.close();
}
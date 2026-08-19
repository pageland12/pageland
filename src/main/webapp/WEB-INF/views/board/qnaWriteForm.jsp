<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Q&A 작성</title>
	<link rel="stylesheet" href="/css/boardForm.css">
    <script src="/js/qnaWrite.js"></script>
</head>
<body>

    <%@ include file="/WEB-INF/views/guest/header.jsp" %>

    <div class="write-container">
        
        <div class="page-title">Q&A</div>

        <form name="qna" method="post" action="/board/qnaWrite" enctype="multipart/form-data">
            
            <table class="write-table">
                <tr>
                    <th>제목</th>
                    <td>
                        <input type="text" name="qtitle" class="input-text" placeholder="제목을 입력해주세요.">
                    </td>
                </tr>
                <tr>
                    <th>본문</th>
                    <td>
                        <textarea name="qcontent" class="textarea-content" placeholder="내용을 입력해주세요."></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        <input type="file" name="qupload" class="file-input">
                    </td>
                </tr>
                <tr>
                    <th>비밀글 설정</th>
                    <td>
                        <div class="radio-group">
                            <label>
                                <input type="radio" name="qsecret" value="공개글" onchange="togglePassword(this.value)"> 공개글
                            </label>
                            <label>
                                <input type="radio" name="qsecret" value="비밀글" checked onchange="togglePassword(this.value)"> 비밀글
                            </label>
                        </div>
                    </td>
                </tr>
                <tr id="passwdRow">
                    <th>게시글 비밀번호</th>
                    <td>
                        <input type="password" name="qpasswd" id="qpasswd" class="input-text" placeholder="비밀번호를 입력해주세요.">
                    </td>
                </tr>
            </table>

            <div class="notice-area">
                <p>상품과 관련없는 내용 또는 이미지, 욕설/비방, 개인정보유출, 광고/홍보글 등 적절하지 않은 게시물은 별도의 고지없이 비공개 처리 될 수 있습니다.</p>
                <p>작성된 게시물(사진, 동영상 포함)은 운영 및 마케팅에 활용될 수 있습니다.</p>
            </div>

            <div class="btn-group">
                <div class="btn-left">
                    <a href="/guest/qnaList" class="btn btn-outline">목록</a>
                </div>
                <div class="btn-right-group">
                    <button type="button" class="btn btn-outline" onclick="history.back()">취소</button>
                    <button type="submit" class="btn btn-dark" onclick="return check()">등록</button>
                </div>
            </div>

        </form>

    </div>

    <%@ include file="/WEB-INF/views/guest/footer.jsp" %>

    <script>
        function togglePassword(value) {
            const passwdRow = document.getElementById('passwdRow');
            const qpasswd = document.getElementById('qpasswd');
            
            if (value === '공개글') {
                passwdRow.style.display = 'none';
                qpasswd.value = ''; // 공개글 선택 시 입력값 초기화
            } else {
                passwdRow.style.display = 'table-row';
            }
        }
    </script>
</body>
</html>
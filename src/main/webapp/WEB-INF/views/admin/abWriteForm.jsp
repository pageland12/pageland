<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 게시판 작성</title>
    <link rel="stylesheet" href="/css/boardForm.css">
    <script src="/js/abWrite.js"></script>
</head>
<body>

    <%@ include file="/WEB-INF/views/guest/header.jsp" %>

    <div class="write-container">
        
        <div class="page-title">관리자 게시판 작성</div>

        <form method="post" name="adminBoard" action="/admin/abWrite" enctype="multipart/form-data">
            
            <table class="write-table">
                <tr>
                    <th>카테고리</th>
                    <td>
                        <select name="abcategory" class="select-category">
                            <option value="NOTICE" ${category eq 'NOTICE' ? 'selected' : ''}>공지사항</option>
    						<option value="EVENT" ${category eq 'EVENT' ? 'selected' : ''}>이벤트</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td>
                        <input type="text" name="abtitle" class="input-text" placeholder="제목을 입력해주세요.">
                    </td>
                </tr>
                <tr>
                    <th>본문</th>
                    <td>
                        <textarea name="abcontent" class="textarea-content" placeholder="내용을 입력해주세요."></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        <input type="file" name="abupload" class="file-input">
                    </td>
                </tr>
            </table>

            <div class="btn-group">
                <div class="btn-left">
                    <a href="/guest/abList" class="btn btn-outline">목록</a>
                </div>
                <div class="btn-right-group">
                    <button type="button" class="btn btn-outline" onclick="history.back()">취소</button>
                    <button type="submit" class="btn btn-dark" onclick="return check()">등록</button>
                </div>
            </div>

        </form>

    </div>

    <%@ include file="/WEB-INF/views/guest/footer.jsp" %>

</body>
</html>
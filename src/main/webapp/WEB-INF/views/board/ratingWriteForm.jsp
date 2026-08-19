<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>후기 작성</title>
    <link rel="stylesheet" href="/css/boardForm.css">
    <script src="/js/ratingWrite.js"></script>
</head>
<body>

    <%@ include file="/WEB-INF/views/guest/header.jsp" %>

    <div class="write-container">
        
        <div class="page-title">도서 대여 후기 작성</div>

        <div class="book-info-card">
            <c:if test="${not empty rating.bimg}">
                <img src="${rating.bimg}" alt="${rating.bname}" class="book-img">
            </c:if>
            <div class="book-details">
                <span class="order-no">주문 상세 번호 : ${rating.odno}</span>
                <span class="book-title">${rating.bname}</span>
            </div>
        </div>

        <form method="post" name="rating" action="/board/ratingWrite" enctype="multipart/form-data">
            <input type="hidden" name="bno" value="${rating.bno}">
            <input type="hidden" name="odno" value="${rating.odno}">

            <table class="write-table">
                <tr>
                    <th>제목</th>
                    <td>
                        <input type="text" name="rtitle" class="input-text" placeholder="후기 제목을 입력해주세요.">
                    </td>
                </tr>
                <tr>
                    <th>평점</th>
                    <td>
                        <select name="rrate" class="select-rate">
                            <option value="5.0">★★★★★ (5.0)</option>
                            <option value="4.0">★★★★☆ (4.0)</option>
                            <option value="3.0">★★★☆☆ (3.0)</option>
                            <option value="2.0">★★☆☆☆ (2.0)</option>
                            <option value="1.0">★☆☆☆☆ (1.0)</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <th>본문</th>
                    <td>
                        <textarea name="rcontent" class="textarea-content" placeholder="솔직한 도서 대여 후기를 남겨주세요."></textarea>
                    </td>
                </tr>
                <tr>
                    <th>첨부파일</th>
                    <td>
                        <input type="file" name="rupload" class="file-input">
                    </td>
                </tr>
            </table>

            <div class="notice-area">
                <p>작성해주신 후기는 다른 이용자들에게 큰 도움이 됩니다.</p>
                <p>상품과 무관한 사진이나 비방, 광고글 등은 비공개 처리될 수 있습니다.</p>
            </div>

            <div class="btn-group">
                <div class="btn-left">
                    <a href="/guest/ratingList" class="btn btn-outline">목록</a>
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
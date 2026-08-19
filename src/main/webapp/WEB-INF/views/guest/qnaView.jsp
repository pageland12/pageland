<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${view.qtitle} - 페이지랜드</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: #ffffff;
            color: #333333;
            font-family: 'Malgun Gothic', '맑은 고딕', sans-serif;
        }

        .view-container {
            width: 100%;
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px 80px 20px;
            box-sizing: border-box;
        }

        .page-category-title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color: #111111;
            margin-bottom: 40px;
        }

        .article-header {
            border-top: 1px solid #111111;
            border-bottom: 1px solid #eeeeee;
            padding: 25px 10px;
            margin-bottom: 30px;
        }

        .title-wrapper {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-bottom: 16px;
        }

        .article-title {
            font-size: 22px;
            font-weight: bold;
            color: #111111;
            line-height: 1.3;
        }

        .secret-badge {
            display: inline-flex;
            align-items: center;
            gap: 4px;
            background-color: #fff0f0;
            color: #e74c3c;
            border: 1px solid #ffcdd2;
            border-radius: 4px;
            padding: 3px 8px;
            font-size: 12px;
            font-weight: bold;
        }

        .article-meta {
            font-size: 13.5px;
            color: #777777;
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
        }

        .article-body {
            min-height: 200px;
            line-height: 1.7;
            font-size: 15px;
            color: #333333;
            margin-bottom: 50px;
        }

        .article-image-area {
            text-align: center;
            margin-bottom: 30px;
        }

        .article-image-area img {
            max-width: 100%;
            height: auto;
            border-radius: 4px;
        }

        .article-content-text {
            white-space: pre-line;
            word-break: break-all;
        }

        .btn-group {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid #eeeeee;
            padding-top: 25px;
        }

        .btn-left, .btn-right {
            display: flex;
            gap: 8px;
        }

        .btn {
            display: inline-block;
            padding: 9px 20px;
            font-size: 13px;
            font-weight: 500;
            text-decoration: none;
            border-radius: 4px;
            transition: background-color 0.2s;
        }

        .btn-default {
            background-color: #f4f4f4;
            color: #333333;
            border: 1px solid #dddddd;
        }
        .btn-default:hover {
            background-color: #e8e8e8;
        }

        .btn-edit {
            background-color: #222222;
            color: #ffffff;
            border: 1px solid #222222;
        }
        .btn-edit:hover {
            background-color: #444444;
        }

        .btn-danger {
            background-color: #e74c3c;
            color: #ffffff;
            border: 1px solid #e74c3c;
        }
        .btn-danger:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>

    <%@ include file="header.jsp" %>

    <div class="view-container">
        
        <div class="page-category-title">Q&A</div>

        <div class="article-header">
            
            <div class="title-wrapper">
                <span class="article-title">${view.qtitle}</span>

                <c:if test="${view.qsecret == '비밀글'}">
                    <span class="secret-badge">🔒 비밀글</span>
                </c:if>
            </div>

            <div class="article-meta">
                <span>작성자: ${view.mname ne null ? view.mname : '익명'}</span>
                <span>|</span>
                <span><fmt:formatDate value="${view.qdate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                <span>|</span>
                <span>조회 ${view.qhit}</span>
            </div>
        </div>

        <div class="article-body">
            <c:if test="${not empty view.qfiles}">
                <div class="article-image-area">
                    <img src="/images/${view.qfiles}" alt="QnA 첨부 사진">
                </div>
            </c:if>

            <div class="article-content-text">
                ${view.qcontent}
            </div>
        </div>

        <div class="btn-group">
            <div class="btn-left">
                <a href="/guest/qnaList" class="btn btn-default">목록으로</a>
            </div>

            <div class="btn-right">
                <a href="${view.qsecret == '비밀글' ? '/board/qnaPasswordCheckForm?qno='.concat(view.qno).concat('&mode=update') : '/board/qnaUpdateForm?qno='.concat(view.qno)}" 
                   class="btn btn-edit">수정</a>
                
                <a href="${view.qsecret == '비밀글' ? '/board/qnaPasswordCheckForm?qno='.concat(view.qno).concat('&mode=delete') : '/board/qnaDelete?qno='.concat(view.qno)}" 
                   class="btn btn-danger" 
                   onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            </div>
        </div>

    </div>

    <%@ include file="footer.jsp" %>

</body>
</html>
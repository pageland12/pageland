<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${view.abtitle} - 페이지랜드</title>
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
            max-width: 900px; /* 게시글 보기 본문 적정 너비 */
            margin: 0 auto;
            padding: 40px 20px 80px 20px;
            box-sizing: border-box;
        }

        /* 1. 상단 타이틀 (공지사항 / 이벤트 등) */
        .page-category-title {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            color: #111111;
            margin-bottom: 40px;
        }

        /* 2. 게시글 헤더 영역 (제목, 정보) */
        .article-header {
            border-top: 1px solid #111111;
            border-bottom: 1px solid #eeeeee;
            padding: 20px 10px;
            margin-bottom: 30px;
        }

        .article-title {
            font-size: 20px;
            font-weight: bold;
            color: #111111;
            margin-bottom: 12px;
            line-height: 1.4;
        }

        .article-meta {
            font-size: 13px;
            color: #777777;
            display: flex;
            align-items: center;
            gap: 15px;
        }

        /* 3. 게시글 본문 영역 */
        .article-body {
            min-height: 250px;
            line-height: 1.7;
            font-size: 15px;
            color: #333333;
            margin-bottom: 50px;
        }

        /* 이미지 중앙 정렬 및 반응형 사이즈 처리 */
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
            white-space: pre-line; /* 줄바꿈 그대로 적용 */
            word-break: break-all;
        }

        /* 4. 하단 버튼 영역 */
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

        .btn-admin {
            background-color: #222222;
            color: #ffffff;
            border: 1px solid #222222;
        }
        .btn-admin:hover {
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

    <!-- 헤더 인클루드 -->
    <%@ include file="header.jsp" %>

    <div class="view-container">
        
        <!-- 상단 카테고리 타이틀 -->
        <div class="page-category-title">
            <c:choose>
                <c:when test="${view.abcategory == 'NOTICE'}">공지사항</c:when>
                <c:when test="${view.abcategory == 'EVENT'}">이벤트</c:when>
                <c:otherwise>고객센터</c:otherwise>
            </c:choose>
        </div>

        <!-- 게시글 헤더 (제목 및 정보) -->
        <div class="article-header">
            <div class="article-title">${view.abtitle}</div>
            <div class="article-meta">
                <span>${view.mname ne null ? view.mname : '페이지랜드'}</span>
                <span>|</span>
                <span><fmt:formatDate value="${view.abdate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                <span>|</span>
                <span>조회 ${view.abhit}</span>
            </div>
        </div>

        <!-- 게시글 본문 (이미지 우선 -> 텍스트 내용) -->
        <div class="article-body">
            <!-- 1. 이미지 먼저 출력 -->
            <c:if test="${not empty view.abfiles}">
                <div class="article-image-area">
                    <img src="/images/${view.abfiles}" alt="첨부 이미지">
                </div>
            </c:if>

            <!-- 2. 작성한 내용(타이핑 한 글) 출력 -->
            <div class="article-content-text">
                ${view.abcontent}
            </div>
        </div>

        <!-- 하단 버튼 영역 -->
        <div class="btn-group">
            <div class="btn-left">
                <c:if test="${view.abcategory == 'NOTICE'}">
                    <a href="/guest/noticeList" class="btn btn-default">목록으로</a>
                </c:if>
                <c:if test="${view.abcategory == 'EVENT'}">
                    <a href="/guest/eventList" class="btn btn-default">목록으로</a>
                </c:if>
                <c:if test="${view.abcategory ne 'NOTICE' and view.abcategory ne 'EVENT'}">
                    <a href="javascript:history.back();" class="btn btn-default">목록으로</a>
                </c:if>
            </div>

            <!-- 관리자 수정/삭제 버튼 -->
            <sec:authorize access="hasRole('ADMIN') or hasRole('ROLE_ADMIN') or hasAuthority('ADMIN') or hasAuthority('ROLE_ADMIN')">
                <div class="btn-right">
                    <a href="/admin/abUpdateForm?abno=${view.abno}" class="btn btn-admin">수정</a>
                    <a href="/admin/abDelete?abno=${view.abno}" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                </div>
            </sec:authorize>
        </div>

    </div>

    <!-- 푸터 인클루드 -->
    <%@ include file="footer.jsp" %>

</body>
</html>
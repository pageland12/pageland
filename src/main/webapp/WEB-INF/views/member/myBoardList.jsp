<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 나의 게시글</title>
<style>
    .mypage-wrapper {
        width: 100%;
        max-width: 1400px;
        margin: 0 auto;
        padding: 50px 30px 60px 30px;
        box-sizing: border-box;
        display: flex;
        gap: 40px;
        align-items: flex-start;
    }

    .mypage-main {
        flex: 1;
        background-color: #FFFFFF;
        border-radius: 12px;
        padding: 30px;
        border: 1px solid #EFE0D3;
        box-shadow: 0 4px 16px rgba(0, 0, 0, 0.02);
        box-sizing: border-box;
    }

    .content-header {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding-bottom: 18px;
        margin-bottom: 25px;
        border-bottom: 2px solid #5A4A42;
    }

    .content-title {
        font-size: 1.45rem;
        font-weight: 800;
        color: #2C221E;
        margin: 0;
        display: flex;
        align-items: center;
        gap: 10px;
    }

    .content-subtitle {
        font-size: 0.9rem;
        color: #7A6A60;
    }

    /* 테이블 스타일링 */
    .custom-table {
        width: 100%;
        border-collapse: collapse;
        text-align: center;
        font-size: 0.92rem;
    }

    .custom-table thead th {
        background-color: #FAF0E6;
        color: #5A4A42;
        padding: 14px 10px;
        font-weight: 700;
        border-top: 1px solid #E8D8CA;
        border-bottom: 1px solid #E8D8CA;
        white-space: nowrap;
    }

    .custom-table tbody td {
        padding: 16px 10px;
        border-bottom: 1px solid #F0E8E0;
        color: #333333;
        vertical-align: middle;
    }

    .custom-table tbody tr:hover {
        background-color: #FCF9F6;
    }

    /* 게시글 분류 뱃지 */
    .badge-category {
        display: inline-block;
        padding: 4px 10px;
        font-size: 0.8rem;
        font-weight: 700;
        border-radius: 20px;
    }

    .badge-qna {
        background-color: #E3F2FD;
        color: #1976D2;
        border: 1px solid #BBDEFB;
    }

    .badge-review {
        background-color: #E8F5E9;
        color: #2E7D32;
        border: 1px solid #C8E6C9;
    }

    /* 제목 링크 */
    .post-title-cell {
        text-align: center;
        padding-left: 15px !important;
        max-width: 320px;
    }

    .post-title-cell a {
        color: #2C221E;
        text-decoration: none;
        font-weight: 600;
        line-height: 1.4;
        display: inline-block;
    }

    .post-title-cell a:hover {
        color: #8B5E3C;
        text-decoration: underline;
    }

    .secret-icon {
        font-size: 0.85rem;
        margin-right: 4px;
    }

    /* 부가 정보 */
    .extra-info-text {
        font-size: 0.88rem;
        color: #666666;
    }

    .extra-info-rating {
        color: #E65100;
        font-weight: 600;
    }

    .meta-text {
        color: #7A6A60;
        font-size: 0.88rem;
    }

    .empty-msg {
        text-align: center;
        padding: 60px 0;
        color: #888888;
        font-size: 1rem;
    }

    /* 페이징 영역 */
    .pagination {
        text-align: center;
        margin-top: 35px;
    }

    .pagination a {
        display: inline-block;
        padding: 6px 12px;
        margin: 0 3px;
        color: #5A4A42;
        text-decoration: none;
        border: 1px solid #E0D2C7;
        border-radius: 4px;
        font-size: 0.9rem;
        transition: background-color 0.2s;
    }

    .pagination a:hover {
        background-color: #F2E3D5;
    }

    .pagination .current-page {
        display: inline-block;
        padding: 6px 12px;
        margin: 0 3px;
        background-color: #8B5E3C;
        color: #FFFFFF;
        font-weight: 700;
        border-radius: 4px;
        border: 1px solid #8B5E3C;
        font-size: 0.9rem;
    }
</style>
</head>
<body>
    <!-- 1. guest 폴더의 header include -->
    <%@ include file="../guest/header.jsp" %>

    <div class="mypage-wrapper">
        <!-- 2. member 폴더의 사이드바 include -->
        <%@ include file="memberSidebar.jsp" %>

        <!-- 3. 우측 본문 영역 -->
        <main class="mypage-main">
            <div class="content-header">
                <h2 class="content-title">나의 게시글</h2>
                <div class="content-subtitle">
                    회원님이 작성하신 Q&A와 도서 후기를 한곳에서 확인하세요.
                </div>
            </div>

            <table class="custom-table">
                <thead>
                    <tr>
                        <th style="width: 100px;">분류</th>
                        <th>제목</th>
                        <th style="width: 220px;">부가정보</th>
                        <th style="width: 130px;">작성일</th>
                        <th style="width: 80px;">조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${empty board}">
                            <tr>
                                <td colspan="5" class="empty-msg">
                                    작성한 게시글이 없습니다.
                                </td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="post" items="${board}">
                                <tr>
                                    <!-- 1. 분류 뱃지 -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${post.btype eq 'QNA'}">
                                                <span class="badge-category badge-qna">Q&A</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-category badge-review">도서후기</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- 2. 제목 및 상세 링크 분기 -->
                                    <td class="post-title-cell">
                                        <c:choose>
                                            <c:when test="${post.btype eq 'QNA'}">
                                                <a href="${post.extraInfo == '비밀글' ? '/board/qnaPasswordCheckForm?qno='.concat(post.bno).concat('&mode=view') : '/guest/qnaView?qno='.concat(post.bno)}">
                                                    ${post.title}
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <a href="/guest/ratingView?rno=${post.bno}">
                                                    ${post.title}
                                                </a>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- 3. 부가정보 (도서명/평점 또는 비밀글 여부) -->
                                    <td class="extra-info-text">
                                        <c:choose>
                                            <c:when test="${post.btype eq 'QNA'}">
                                                <c:choose>
                                                    <c:when test="${post.extraInfo == '비밀글'}">
                                                        <span style="color: #888;">비밀글</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span style="color: #666;">공개글</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="extra-info-rating">${post.extraInfo}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- 4. 작성일 -->
                                    <td class="meta-text">
                                        ${post.regdate}
                                    </td>

                                    <!-- 5. 조회수 -->
                                    <td class="meta-text">${post.hit}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>

            <!-- 페이징 영역 -->
            <c:if test="${not empty board}">
                <div class="pagination">
                    <c:if test="${startPage > 1}">
                        <a href="/member/boardList?pageNum=${startPage - 1}">[이전]</a>
                    </c:if>

                    <c:forEach begin="${startPage}" end="${endPage}" var="num">
                        <c:choose>
                            <c:when test="${pageNum == num}">
                                <span class="current-page">${num}</span>
                            </c:when>
                            <c:otherwise>
                                <a href="/member/boardList?pageNum=${num}">${num}</a>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>

                    <c:if test="${endPage < totalPages}">
                        <a href="/member/boardList?pageNum=${endPage + 1}">[다음]</a>
                    </c:if>
                </div>
            </c:if>
        </main>
    </div>

    <!-- 4. guest 폴더의 footer include -->
    <%@ include file="../guest/footer.jsp" %>
</body>
</html>
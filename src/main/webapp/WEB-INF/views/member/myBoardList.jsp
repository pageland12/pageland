<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 나의 게시글</title>
<link rel="stylesheet" href="/css/myList.css">
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
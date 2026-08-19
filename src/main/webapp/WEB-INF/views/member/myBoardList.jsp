<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 작성한 글 목록</title>
</head>
<body>
    <h2>내가 작성한 글 목록</h2>

    <table border="1" width="100%">
        <thead>
            <tr bgcolor="#f2f2f2">
                <th>분류</th>
                <th>제목</th>
                <th>부가정보</th>
                <th>작성일</th>
                <th>조회수</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty boardList}">
                    <tr>
                        <td colspan="5" align="center">작성한 게시글이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach var="post" items="${boardList}">
                        <tr>
                            <!-- 분류 뱃지 -->
                            <td align="center">
                                <c:choose>
                                    <c:when test="${post.btype eq 'QNA'}">
                                        <span style="color: blue; font-weight: bold;">[Q&A]</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="color: green; font-weight: bold;">[도서후기]</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <!-- 제목 및 상세 링크 분기 -->
                            <td>
                                <c:choose>
                                    <c:when test="${post.btype eq 'QNA'}">
                                        <a href="${post.extraInfo == '비밀글' ? '/board/qnaPasswordCheckForm?qno='.concat(post.bno).concat('&mode=view') : '/guest/qnaView?qno='.concat(post.bno)}">${post.title}</a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="/guest/ratingView?rno=${post.bno}">${post.title}</a>
                                    </c:otherwise>
                                </c:choose>
                            </td>

                            <!-- 부가정보 (도서명/평점 or 비밀글여부) -->
                            <td align="center">${post.extraInfo}</td>

                            <!-- 작성일 -->
                            <td align="center">
                                "${post.regdate}"
                            </td>

                            <!-- 조회수 -->
                            <td align="center">${post.hit}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

    <br>
    <button type="button" onclick="location.href='/member/memberMain'">마이페이지</button>
</body>
</html>
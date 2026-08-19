<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<style>
    .mypage-sidebar {
        width: 240px;
        background-color: #FAF0E6;
        border-radius: 12px;
        padding: 24px 18px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.03);
        border: 1px solid #EFE0D3;
        flex-shrink: 0;
        box-sizing: border-box;
    }

    .mypage-sidebar-title {
        font-size: 1.15rem;
        font-weight: 800;
        color: #5A4A42;
        padding-bottom: 15px;
        margin-bottom: 15px;
        border-bottom: 2px solid #E3D1C2;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .sidebar-menu-list {
        list-style: none;
        padding: 0;
        margin: 0;
        display: flex;
        flex-direction: column;
        gap: 6px;
    }

    .sidebar-menu-list a {
        display: block;
        padding: 12px 14px;
        border-radius: 8px;
        color: #6B5B52;
        font-size: 0.95rem;
        font-weight: 600;
        text-decoration: none;
        transition: all 0.2s ease;
    }

    .sidebar-menu-list a:hover {
        background-color: #F2E3D5;
        color: #2C221E;
        transform: translateX(4px);
    }

    .sidebar-menu-list a.active {
        background-color: #8B5E3C;
        color: #FFFFFF;
        font-weight: 700;
    }

    .sidebar-divider {
        height: 1px;
        background-color: #E8D8CA;
        margin: 10px 0;
    }
</style>

<aside class="mypage-sidebar">
    <div class="mypage-sidebar-title">
        마이페이지
    </div>
    <ul class="sidebar-menu-list">
        <li><a href="/member/myBookList">대여중인 도서</a></li>
        <li><a href="/member/myOrderBookList">대여 도서 내역</a></li>
        <li><a href="/member/orderList">주문/결제 조회</a></li>
        <li><a href="/member/myPassList">내 구독권 조회</a></li>
        <li><a href="/member/boardList">나의 게시글</a></li>
        <li class="sidebar-divider"></li>
        <li><a href="/member/passwordCheckForm?mode=update">회원정보 수정</a></li>
        <li>
        	<a href="/member/passwordCheckForm?mode=delete"
        		onclick="return confirm('정말 회원 탈퇴를 진행하시겠습니까?\n탈퇴 시 이용 중인 도서 및 구독권 혜택이 중단될 수 있습니다.');">
        		회원 탈퇴</a>
        </li>
    </ul>
</aside>

<script>
document.addEventListener("DOMContentLoaded", function() {
    checkUrl();
});

function checkUrl(){
	const currentPath = window.location.pathname;
	const currentSearch = window.location.search;
	
	const atag = document.querySelectorAll('.sidebar-menu-list a');
	
	for (const link of atag) {
		const href = link.getAttribute('href');
		
		if (href.includes('?mode=')) {
			if ('/member/passwordCheck' == currentPath && !href.includes('delete')) {
				link.classList.add('active');
			}
		} else {
			if (href == currentPath) {
				link.classList.add('active');
			}
		}
	}
}
</script>